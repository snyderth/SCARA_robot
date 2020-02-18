/***************************************************
*	File: 		CheckFinished
*	Author: 		Thomas Snyder
*	Date:			2/17/2020
*	Description:Implementation of Jacobian Inverse 
*					control algorithm
*
*				The latency of this block is 138 cycles
*	Parameters:
*				None
*
*	Dependencies:
*				ForwardKinematics.sv
*				Jacobian.sv
*				JacobianInverse.sv
*				MatMult.sv
*
*	NOTE: For simulation, the MultiplierFP file needs
*			the library to be specified via 
*			-L 220model -L lpm_ver -L altera_mf_ver
*
***************************************************/
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
					nextstate <= Init;
					
					AbsCompReset <= 1;
					AbsCompEn <= 0;
					RelCompReset <= 1;
					RelCompEn <= 0;
					
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
						nextstate <= CompareAbsolute;
						AbsCompEn <= 1;
						AbsCompReset <= 0;
					end
				end
				state <= nextstate;
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
								
			// Latch the output stage and the counter
			
			logic add_done_rel, compReadyRel;							
			
			SRLatch compLatchRel(.reset(RelCompReset | RelCompDone),
							.set(RelCompEn),
							.q(compReadyRel));
									
			ClockTimer #(2, 2) compTimer(
								.reset(RelCompReset),
								.clk(clk),
								.en(compReadyRel),
								.expire(RelCompDone));
							
			
			/* If the computations are absolute, subtract and see if <= 100 */
			logic add_done_x, add_done_y;
			logic [63:0] x_added, y_added;
			
			DoubleAdder xCheckAbs(
								.dataa(x_target),
								.datab({~x_current[63], x_current[62:0]}),
								.clk(clk),
								.in_ready(AbsCompEn),
								.reset(AbsCompReset),
								.data_ready(add_done_x),
								.result(x_added)
							);				
			
			
			DoubleAdder yCheckAbs(
								.dataa(y_target),
								.datab({~y_current[63], y_current[62:0]}),
								.clk(clk),
								.in_ready(AbsCompEn),
								.reset(AbsCompReset),
								.data_ready(add_done_y),
								.result(y_added)
			);				
			
			assign add_done_abs = add_done_y & add_done_x;
			
			logic [63:0] y_added_temp, x_added_temp;
			
			always@(y_added)
			begin
				if(y_added[63])begin
					y_added_temp[62:0] <= y_added[62:0];
					y_added_temp[63] <= 0;
				end
				else begin
					y_added_temp <= y_added;
				end
			end
			
			always@(x_added)
			begin
				if(x_added[63])begin
					x_added_temp[62:0] <= x_added[62:0];
					x_added_temp[63] <= 0;
				end
				else begin
					x_added_temp <= x_added;
				end
			end
			
			DoubleComparator compareXAbs(
											.dataa(x_added_temp),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),//100
											.clock(clk),
											.aleb(x_less_thresh_abs)
											);
											
											
			DoubleComparator compareYAbs(
											.dataa(y_added_temp),
											.datab(64'b0100000001011001000000000000000000000000000000000000000000000000),
											.clock(clk),
											.aleb(y_less_thresh_abs)
											);
			
			
			// Time the compare
			logic compReadyAbs;
			
			SRLatch compLatchAbs(.reset(AbsCompReset | reset | AbsCompDone),
									.set(add_done_abs),
									.q(compReadyAbs));
											
			ClockTimer #(2, 2) compTimerAbs(
												.reset(AbsCompReset | reset),
												.clk(clk),
												.en(compReadyAbs),
												.expire(AbsCompDone));
			
			/* Output Stage */
			
			assign ready = enable & (AbsCompDone | RelCompDone);
			assign AtTarget = ((y_less_thresh_rel & x_less_thresh_rel) | (y_less_thresh_abs & x_less_thresh_abs));
							
endmodule
