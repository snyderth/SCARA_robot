module stepper_motor(input  logic clk_50,
							input  logic reset_n,
							input	 logic new_in,
							input  logic [7:0] num_steps,
							input  logic direction,
							input  logic enable,
							
							
							output logic step,
							output logic dir,
							output logic finished);
							
							logic [15:0] count;
							logic [7:0] step_count;
							
							logic [7:0] set_steps;
							logic 		set_dir;
							
							logic reset_time_n;
							logic reset_step_n;
							
		initial
			begin
				count = 0;
				step_count = 0;
			end
		
		//According to data sheet:
		//STEP min HIGH pulse width: 1 us
		//STEP min LOW pusle width:  1 us
		//setup time (=hold time) after stepsize, reset, or dir input change
		//				200 ns
		
		assign reset_time_n = (count != 50000) | !new_in;
		assign reset_step_n = !new_in;
		assign step 		  = (count > 25000);
		
		assign dir 			  = set_dir;
		assign finished 	  = (step_count == set_steps);
		
		counter #(16) step_time(.clk(clk_50),
										.reset_n(reset_n),
										.reset1_n(reset_time_n),
										.en(enable & (!finished)),
										.q(count));
		
		counter #(8) step_counter(.clk(!step),
										.reset_n(reset_n),
										.reset1_n(reset_step_n),
										.en(enable),
										.q(step_count));
		
							
		always_ff @(posedge new_in, negedge reset_n)
			begin
				if(!reset_n) 
					begin
						set_steps	<= 0;
						set_dir		<= 0;
					end
				else
					begin
						set_steps	<= num_steps;
						set_dir		<= direction;
					end
			end
			
		
			
endmodule
