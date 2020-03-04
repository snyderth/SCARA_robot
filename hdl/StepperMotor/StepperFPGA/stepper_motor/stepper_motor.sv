module stepper_motor(input  logic clk_50,
							input  logic reset_n,
							input	 logic new_in,
							input  logic [7:0] num_steps,
							input  logic fast,
							input  logic direction,
							input  logic enable,
							input  logic [15:0] step_scale,
							input  logic [2:0] step_divide
							output logic step,
							output logic dir,
							output logic finished,
							output logic [7:0] steps_out);
							
							logic [31:0] count;
							logic [7:0] step_count;
							
							logic [7:0] set_steps;
							logic 		set_dir;
							
							logic reset_time_n;
							logic reset_step_n;
							
							logic [31:0]	step_length;
							logic [31:0]	longest_step;
							logic [31:0]	adjustment;
							logic step_prev;
		initial
			begin
				count = 0;
				//step_count = 0;
			end
		
		//According to data sheet:
		//STEP min HIGH pulse width: 1 us
		//STEP min LOW pusle width:  1 us
		//setup time (=hold time) after stepsize, reset, or dir input change
		//				200 ns
		
		//50 Mhz clock
		//Want 
		assign steps_out = set_steps;
		
		//assign adjustment = set_fast ? 500 : 5000; //MUST NOT RECEIVE MORE THAN 99 STEPS
		//assign longest_step = set_fast ? 50000 : 500000;
		//assign step_length  = step_count < set_steps/2 ? longest_step - adjustment * step_count : longest_step -  adjustment * (set_steps - step_count);
		
		
		always_comb
			 step_length = ((5000000 / step_divide) << 8) / (step_scale);
		assign reset_time_n = (count < step_length) & !new_in;
		assign reset_step_n = !new_in;
		assign step 		  = (count > step_length >> 1);
		
		assign dir 			  = set_dir;
		assign finished 	  = (step_count == set_steps);
		
		stp_counter #(32) step_time(.clk(clk_50),
										.reset_n(reset_n),
										.reset1_n(reset_time_n),
										.en(enable & (!finished)),
										.q(count));
		always_ff@(posedge clk_50) begin
			if(!reset_step_n | !reset_n) begin
				step_count <= 0;
				step_prev <= 0;
			end
			
		//Falling edge
			else begin
				if(step_prev && !step) begin
					step_count <= step_count + 1;
				end
				step_prev <= step;
			end
		end
//		stp_counter #(8) step_counter(.clk(!step),
//										.reset_n(reset_n),
//										.reset1_n(reset_step_n),
//										.en(enable),
//										.q(step_count));
		
							
		always_ff @(posedge new_in, negedge reset_n)
			begin
				if(!reset_n) 
					begin
						set_steps	<= 0;
						set_dir		<= 0;
						set_fast		<= 0;
						
					end
				else
					begin
						set_steps	<= num_steps;
						set_dir		<= direction;
						set_fast		<= fast;
					end
			end
			
		
			
endmodule
