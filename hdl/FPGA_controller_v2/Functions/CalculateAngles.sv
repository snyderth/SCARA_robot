module CalculateAngles (input logic [63:0] k1,
							input logic [63:0] k2,
							input logic [13:0] yTarget,
							input logic [13:0] xTarget,
							input logic [63:0] l1,
							input logic [63:0] l2,
							input logic [63:0] l1Squared, // constant
							input logic [63:0] l2Squared,	// constant
							input logic clk,
							input logic enable,
							input logic reset,
							output logic dataReady,
							output logic [63:0] th1,
							output logic [63:0] th2);
					
				logic T2DEn, 	T2DDone;
				logic CosEn, 	CosDone;
				logic SinEn, 	SinDone;
				logic K1En,		K1Done;
				logic 
							
				typedef enum logic [5:0] {Init, TargetToDouble, CosineTh2, SineTh2, K1Calc, K2Calc, Gamma, AtanXY, Thetas}
							
							
		/******************* Convert targets to double *****************/
				
				logic [63:0] xTarget_d, yTarget_d;
						
												
				//NOTE: Conversions are 15 bit even though
				// x and y are 14 bit because the converters
				// take in two's complement, so if MSb is set,
				// it thinks its negative
				Int15BitToDouble xtarget(
												.clk_en(T2DEn),
												.clock(clk),
												.result(xTarget_d),
												.dataa({1'b0, xTarget}));
												
				Int15BitToDouble ytarget(
												.clk_en(T2DEn),
												.clock(clk),
												.result(yTarget_d),
												.dataa({1'b0, yTarget}));
												
				/************************************************/
						
							
endmodule

