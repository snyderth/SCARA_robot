module CheckFinished(
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
						
		typedef enum logic [1:0] {Convert, CompareRelative, CompareAbsolute, Init} statetype;

		statetype state, nextstate;
		
		
		logic AbsCompDone, AbsCompEn, AbsCompReset;
		logic RelCompDone,	RelCompEn, RelCompReset;
			
		
			/*	Logic to determine relative location or not */
			always_ff@(posedge clk, posedge reset)
			begin
				if(reset) begin /* Initialize to Init state */
					state <= Init;
				end
				/* Init state */
				else if((state == Init) & enable & ~reset) begin
					if(relative_target)
						nextstate <= CompareRelative;
					else
						nextstate <= CompareAbsolute;
				end
				/* Compare Relative Target */
				else if((state == CompareRelative) & enable & ~reset) begin
					if(RelCompDone) begin
						nextstate <= Init;
						RelCompEn <= 0;
						RelCompReset <= 1;
					end
					else begin
						nextstate <= CompareRelative;
						RelCompEn <= 1;
						RelCompReset <= 0;
					end
				end
				
				/* Compare Absoulte coordinates */
				else if((state == CompareAbsolute) & enable & ~reset) begin
					if(AbsCompDone) begin
						nextstate <= Init;
						AbsCompEn <= 0;
						AbsCompReset <= 1;
					end
					else begin
						nextstate <= Init;
						AbsCompEn <= 1;
						AbsCompReset <= 0;
					end
				end
				
			end
			
			
			logic x_less_thresh_abs, y_less_thresh_abs;
			logic x_less_thresh_rel, y_less_thresh_rel;


			
			/* Relative comparison state */
			DoubleComparator compareXRel(
								.dataa(x_target),
								.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),//100
								.clock(clk),
								.aleb(x_less_thresh_rel)
								);
											
											
			DoubleComparator compareYRel(
								.dataa(y_target),
								.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),
								.clock(clk),
								.aleb(y_less_thresh_rel)
								);
										
			logic add_done_rel, compReadyRel, out_rel_ready;							
			
			SRLatch compLatchRel(.reset(RelCompReset),
							.set(CompAbsEn),
							.q(compReadyRel));
									
			ClockTimer #(2, 1) compTimer(
								.reset(RelCompReset),
								.clk(clk),
								.en(compReadyRel),
								.expire(out_rel_ready));
							
			
			/* If the computations are absolute, subtract and see if <= 100 */
			logic add_done_x, add_done_y;
			logic [63:0] x_added, y_added;
			
			DoubleAdder xCheckAbs(
								.dataa(x_target),
								.datab({~x_current[63], x_current}),
								.clk(clk),
								.in_ready(CompAbsEn),
								.reset(CompAbsReset),
								.data_ready(add_done_x),
								.result(x_added)
							);				
			
			
			DoubleAdder yCheckAbs(
								.dataa(y_target),
								.datab({~y_current[63], y_current}),
								.clk(clk),
								.in_ready(CompAbsEn),
								.reset(CompAbsReset),
								.data_ready(add_done_y),
								.result(y_added)
			);				
			
			assign add_done_abs = add_done_y & add_done_x;
			
			
			
			
			DoubleComparator compareXAbs(
											.dataa(x_added),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),//100
											.clock(clk),
											.aleb(x_less_thresh_abs)
											);
											
											
			DoubleComparator compareYAbs(
											.dataa(y_added),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),
											.clock(clk),
											.aleb(y_less_thresh_abs)
											);
			
			
			// Time the compare
			logic compReadyAbs, out_abs_ready;
			
			SRLatch compLatchAbs(.reset(AbsCompReset | reset),
									.set(add_done_abs),
									.q(compReadyAbs));
											
			ClockTimer #(2, 1) compTimerAbs(
												.reset(reset),
												.clk(clk),
												.en(compReadyAbs),
												.expire(out_abs_ready));
							
			assign ready = enable & (out_abs_ready | out_rel_ready);
			assign AtTarget = ((y_less_thresh_rel & x_less_thresh_rel) | (y_less_thresh_abs & x_less_thresh_abs));
							
endmodule
