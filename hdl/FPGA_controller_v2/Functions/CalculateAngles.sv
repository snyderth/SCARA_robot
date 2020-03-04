/***************************************************
*	File: 		CalculateAngles
*	Author: 		Thomas Snyder
*	Date:			2/21/2020
*	Description:Module to calculate the cosine of theta 2
*					for a SCARA robot
*	Latency: 	239 Clock cycles
*
*	Parameters:
*				None
*	Dependencies:
*				SRLatch.sv
*				ClockTimer.sv
*				Int15BitToDouble.sv
*				CosineTh2.sv
*				SineTh2.sv
*				k1.sv
*				DoubleMultiply.sv
*				Arctan2.sv
*
*	NOTE: This module must be simulated with the
*			lpm_ver and altera_mf_ver library.
***************************************************/
module CalculateAngles (
							input logic [13:0] yTarget,
							input logic [13:0] xTarget,
							input logic [63:0] l1,
							input logic [63:0] l2,
							input logic [63:0] l1Squared, // constant
							input logic [63:0] l2Squared,	// constant
							input logic clk,
							input logic enable,
							input logic reset,
							input logic relative,
							output logic dataReady,
							output signed [12:0] th1,
							output signed [12:0] th2);
					
				logic T2DEn, 	T2DDone;
				logic CosEn, 	CosDone;
				logic SinEn, 	SinDone;
				logic K1En,		K1Done;
				logic K2En,		K2Done;
				logic GammaEn, GammaDone;
				logic AtanXYEn,AtanXYDone;
				logic ThetaEn, ThetaDone;
							
				typedef enum logic [5:0] {Init, TargetToDouble, CosineTh2, SineTh2, K1Calc, K2Calc, Gamma, AtanXY, Thetas} statetype;
							
				statetype state, nextstate;
				
				always_ff@(posedge clk) begin
					if(reset) begin
					
						nextstate <= Init;
						T2DEn <= 0;
						CosEn <= 0;
						SinEn <= 0;
						K1En	<= 0;
						K2En	<= 0;
						GammaEn <= 0;
						AtanXYEn <= 0;
						ThetaEn <= 0;
						dataReady <= 0;
					
					end
					else if (state == Init) begin
						if(enable) begin
							nextstate <= TargetToDouble;
						end
							
						dataReady <= 0;

					end
					else if (state == TargetToDouble) begin
						if(T2DDone) begin
							nextstate <= CosineTh2;
							T2DEn <= 0;
						end
						else begin
							T2DEn <= 1;
						end

						
					end
					else if (state == CosineTh2) begin
						if(CosDone) begin
							nextstate <= SineTh2;
							CosEn <= 0;
						end
						else
							CosEn <= 1;
						
					end
					
					else if (state == SineTh2) begin
						if(SinDone) begin
							nextstate <= K1Calc;
							SinEn <= 0;
						end
						else
							SinEn <= 1;
					end
					
					else if (state == K1Calc) begin
						if(K1Done) begin
							nextstate <= K2Calc;
							K1En <= 0;
						end
						else
							K1En <= 1;
					end
					
					else if (state == K2Calc) begin
						if(K2Done) begin
							nextstate <= Gamma;
							K2En <= 0;
						end
						else 
							K2En <= 1;
					end
					
					else if (state == Gamma) begin
						if(GammaDone) begin
							nextstate <= AtanXY;
							GammaEn <= 0;
						end
						else GammaEn <= 1;
						
					end
					
					else if(state == AtanXY) begin
						if(AtanXYDone) begin
							nextstate <= Thetas;
							AtanXYEn <= 0;
						end
						else AtanXYEn <= 1;
					
					end
					
					else if(state == Thetas) begin
						if(ThetaDone) begin
							nextstate <= Init;
							ThetaEn <= 0;
							dataReady <= 1;
						end
						else ThetaEn <= 1;
					
					end
					
					state <= nextstate;
				end
					
					
		/******************* Convert targets to double *****************/
				
				logic [63:0] xTarget_d, yTarget_d;
				
			
				logic [14:0] xTargetConversionInput, yTargetConversionInput;
				
				always_comb begin
//					if(relative) begin
//						xTargetConversionInput = {xTarget[13], 1'b0, xTarget[12:0]};
//						yTargetConversionInput = {yTarget[13], 1'b0, yTarget[12:0]};
//					end
					//else begin
					
					//Extend sign

					xTargetConversionInput = {1'b0, xTarget};
					yTargetConversionInput = {1'b0, yTarget};
					
					//end
				end
		
				//NOTE: Conversions are 15 bit even though
				// x and y are 14 bit because the converters
				// take in two's complement, so if MSb is set,
				// it thinks its negative
				Int15BitToDouble xtarget(
												.clk_en(T2DEn),
												.clock(clk),
												.result(xTarget_d),
												.dataa(xTargetConversionInput)); // Moving the sign bit out
												
				Int15BitToDouble ytarget(
												.clk_en(T2DEn),
												.clock(clk),
												.result(yTarget_d),
												.dataa(yTargetConversionInput)); // Moving the sign bit out
												
				ClockTimer #(4, 6) convTimer(.en(T2DEn),
														.reset(~T2DEn),
														.expire(T2DDone),
														.clk(clk));
				
		/************************************************/
	
		/* CosineTh2 State */
		logic [63:0] CosTh2;
		
		CosineTh2 cosineCalculation(.xTarget_d(xTarget_d),
											.yTarget_d(yTarget_d),
											.l1Squared(l1Squared),
											.l2Squared(l2Squared),
											.l1(l1),
											.l2(l2),
											.clk(clk),
											.enable(CosEn),
											.reset(~CosEn),
											.CosTh2(CosTh2),
											.dataReady(CosDone)
											);
		
		
		/************************************************/
	
		/* SineTh2 State */
		
		logic [63:0] SinTh2;
		
		SineTh2 sineCalculation(
										.CosTh2(CosTh2),
										.clk(clk),
										.reset(~SinEn),
										.enable(SinEn),
										.SinTh2(SinTh2),
										.dataReady(SinDone)
										);
		
		/***********************************************/
	
		/* K1 Calculation State */
		
		logic [63:0] k1;
		
		K1 k1Calculation(
							.l1(l1),
							.l2(l2),
							.CosTh2(CosTh2),
							.enable(K1En),
							.reset(~K1En),
							.clk(clk),
							.dataReady(K1Done),
							.k1(k1)
							);
		
		/**********************************************/
		
		/* K2 Calculation State */
		logic [63:0] k2;
		
		
		DoubleMultiply k2Calculation(
											.dataa(l2),
											.datab(SinTh2),
											.clk(clk),
											.in_ready(K2En),
											.result(k2),
											.reset(~K2En),
											.data_ready(K2Done)
											);
		/***********************************************/
		
		
		/* Calculate Gamma */
		
		reg signed [12:0] gammaResult, gammaIntermediate;
//		
//		Arctan2 gammaCalculation(.arg1(k2),
//											.arg2(k1),
//											.clk(clk),
//											.enable(GammaEn),
//											.reset(~GammaEn),
//											.angle(gammaIntermediate),
//											.DataReady(GammaDone)
//										);
//		
		
										
		/**********************************************/
		
		
		/* Calculate AtanXY */
		logic [63:0] arg1Atan, arg2Atan;
		reg signed [12:0] resultAtan;
		logic atanDone;
		reg signed [12:0] arctanXY, arctanXYRes;
		
		
		reg signed [12:0] th1res;
		reg signed [12:0] th2res, th2hold;
		//Streamlining to cut down on resource usage
		// Selecting the inputs to go into the Arctan function
		always_comb begin
			if (GammaEn) begin
				arg1Atan <= k2;
				arg2Atan <= k1;
			end
			else if(AtanXYEn) begin
				arg1Atan <= yTarget_d;
				arg2Atan <= xTarget_d;
			end
			else if(ThetaEn) begin
				arg1Atan <= SinTh2;
				arg2Atan <= CosTh2;
			end
			else begin
				arg1Atan <= 0;
				arg2Atan <= 0;
			end
		end
		
		
		
		Arctan2 atanXYCalculation(
										.arg1(arg1Atan),
										.arg2(arg2Atan),
										.clk(clk),
										.enable(AtanXYEn | GammaEn | ThetaEn),
										.reset(~AtanXYEn & ~GammaEn & ~ThetaEn),
										.angle(resultAtan),
										.DataReady(atanDone)
										);
										
										
		// Selecting where the output to the arctan
		// function should go.
		always_ff@(posedge clk) begin
			if(atanDone) begin
				if(state == Gamma) begin
					gammaIntermediate <= resultAtan;
					GammaDone <= 1'b1;
					ThetaDone <= 1'b0;
				end
				else if (state == AtanXY) begin
					GammaDone <= 1'b0;
					arctanXYRes <= resultAtan;
					AtanXYDone <= 1'b1;
				end
				else if (state == Thetas) begin
					ThetaDone <= 1'b1;
					AtanXYDone <= 1'b0;
					th2res <= resultAtan;
				end
			end
		end
										
										
		
		// Latch onto the result		
		always_ff@(posedge clk) begin
			if(AtanXYDone) arctanXY <= arctanXYRes;
			if(GammaDone) gammaResult <= gammaIntermediate; 
			if(ThetaDone) begin
				th1res <= arctanXY - gammaResult;
				th2hold <= th2res;
			
			end
		end
//			
//		// Latch onto the result
//		always_ff@(posedge GammaDone)
//			gammaResult <= gammaIntermediate;
			
					/*	Calculate Thetas */
//		always_ff@(posedge ThetaDone) begin
//			th1res <= arctanXY - gammaResult;			
//			th2hold <= th2res;
//		end
//			
		/*********************************************/
		
		

		
		assign th1 = th1res;
		
		assign th2 = th2hold;
		
//		Arctan2 Theta2Calc(
//								.arg1(SinTh2),
//								.arg2(CosTh2),
//								.clk(clk),
//								.enable(ThetaEn),
//								.reset(~ThetaEn),
//								.angle(th2res),
//								.DataReady(ThetaDone)
//								);
	
			
			
		
		/********************************************/
		
endmodule

