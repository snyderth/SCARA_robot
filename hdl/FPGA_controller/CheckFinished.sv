module CheckFinised(
								input logic clk,
								input logic enable,
								input logic reset,
								input logic relative_target,
								input logic [63:0] x_target,
								input logic [63:0] y_target,
								input logic [63:0] x_current,
								input logic [63:0] y_current,
								output logic AtTarget,
								output logic ready
							);
						
		/*NOT EXACTLY FINISHED? STILL NEED SIM AND UNCERTAIN ABOUT
		THE WHOLE RELATIVE POSITION THING*/			
			
			logic beginAddition;
			logic add_done;
			logic output_good;
			logic out;
			
			/*	Logic to determine relative location or not */
			always_ff@(posedge clk, posedge reset)
			begin
				if(relative_target & ~reset) begin
					beginAddition <= 0;
					if(x_current < threshold & y_current < threshold) begin
						out <= 1;
						output_good <= 1;
					end
					else begin
						out <= 0;
						output_good <= 1;
					end
				end
				
				else if(~relative_target & ~reset) begin
					beginAddition <= 1;
				end
				else if(reset) begin
					beginAddition <= 0;
					output_good <= 0;
					out <= 0;
				end
			end
			
			
			/* If the computations are absolute, subtract and see if <= 100 */
			logic add_done_x, add_done_y;
			logic [63:0] x_added, y_added;
			
			DoubleAdder xCheck(
								.dataa(x_target),
								.datab({~x_current[63], x_current}),
								.clk(clk),
								.in_ready(beginAddition),
								.reset(reset),
								.data_ready(add_done_x),
								.result(x_added)
			);				
			
			
			DoubleAdder yCheck(
								.dataa(y_target),
								.datab({~y_current[63], y_current}),
								.clk(clk),
								.in_ready(beginAddition),
								.reset(reset),
								.data_ready(add_done_y),
								.result(y_added)
			);				
			
			assign add_done = add_done_y & add_done_x;
			
			
			logic x_less_thresh, y_less_thresh;
			
			DoubleComparator compareX(
											.dataa(x_added),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),//100
											.clock(clk),
											.aleb(x_less_thresh)
											);
											
											
			DoubleComparator compareY(
											.dataa(y_added),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),
											.clock(clk),
											.aleb(y_less_thresh)
											);
											
			assign AtTarget = y_less_thresh & x_less_thresh;
			
			// Time the compare
			logic compReady;
			
			SRLatch compLatch(.reset(reset),
									.set(add_done),
									.q(compReady));
											
			ClockTimer #(2, 1) compTimer(
												.reset(reset),
												.clk(clk),
												.en(compReady),
												.expire(ready));
							
endmodule
