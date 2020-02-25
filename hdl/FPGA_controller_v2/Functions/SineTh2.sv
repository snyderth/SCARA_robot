/***************************************************
*	File: 		SineTh2
*	Author: 		Thomas Snyder
*	Date:			2/19/2020
*	Description:Module to calculate the sine of theta 2
*					for a SCARA robot
*	Latency: 	59 Clock cycles
*
*	Parameters:
*				None
*	Dependencies:
*				SRLatch.sv
*				DoubleMultiply.sv
*				ClockTimer.sv
*				DoubleAdder.sv
*				SquareRoot.sv
*
*	NOTE: This module must be simulated with the
*			220model_ver and lpm_ver library.
***************************************************/
module SineTh2(input logic [63:0] CosTh2,
					input logic clk,
					input logic reset,
					input logic enable,
					output logic [63:0] SinTh2,
					output logic dataReady);
				
				typedef enum logic [1:0]{Square, Subtract, Root, Init} StateType;
				
				StateType state, nextstate;
				logic SquareEn, SquareRes, SquareDone;
				logic SubEn,	SubRes,	SubDone;
				logic RootEn,	RootRes,	RootDone;
				
				/*			State Transition Logic 			 */
				always_ff@(posedge clk) begin
					if(reset) begin
						nextstate 		<= Init;
						
						SquareRes 		<= 1;
						SquareEn			<= 0;
						
						SubEn				<= 0;
						SubRes			<= 1;
						
						RootEn			<= 0;
						RootRes			<= 1;
						
					end
					else if (state == Init) begin
						if(enable) begin
							nextstate 	<= Square;
						end
					end
					
					else if (state == Square) begin
						if(SquareDone) begin 
							nextstate 	<= Subtract;
							SquareEn 	<= 0;
							SquareRes	<= 1;
						end
						else begin
							nextstate 	<= Square;
							SquareEn 	<= 1;
							SquareRes 	<=	0;
						end
					end
					
					else if (state == Subtract) begin
						if(SubDone) begin
							nextstate 	<= Root;
							SubEn			<= 0;
							SubRes		<= 1;
						end
						else begin
							nextstate 	<= Subtract;
							SubEn			<= 1;
							SubRes		<= 0;
						end
					end
				
					else if (state == Root) begin
						if (RootDone) begin
							nextstate 	<= Init;
							RootEn		<= 0;
							RootRes		<= 1;
						end
						else begin
							nextstate 	<= Root;
							RootEn		<= 1;
							RootRes		<= 0;
						end
					end
				
					state <= nextstate;
				end

				logic [63:0] cosSquared;
				logic [4:0] cnt;
				
				DoubleMultiply SquareCos(
												.in_ready(SquareEn),
												.dataa(CosTh2),
												.datab(CosTh2),
												.result(cosSquared),
												.data_ready(SquareDone),
												.count(cnt),
												.reset(SquareRes),
												.clk(clk)
												);
				
				logic [63:0] oneMinusCosSquared;
				
				DoubleAdder	OneSubSquare(
												.in_ready(SubEn),
												.dataa(64'b0011111111110000000000000000000000000000000000000000000000000000),
												.datab({~cosSquared[63], cosSquared[62:0]}),
												.result(oneMinusCosSquared),
												.data_ready(SubDone),
												.reset(SubRes),
												.clk(clk)
												);
												
				
				 SquareRoot sqroot(
										.data(oneMinusCosSquared),
										.clk_en(RootEn),
										.clk(clk),
										.result(SinTh2),
										.dataReady(RootDone),
										.reset(RootRes)
										);
										
				SRLatch done(.set(RootDone),
								.reset(reset | SquareEn),
								.q(dataReady));
				
				
endmodule

