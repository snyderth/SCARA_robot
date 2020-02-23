/***************************************************
*	File: 		ForwardKinematics
*	Author: 		Thomas Snyder
*	Date:			2/22/2020
*	Description:Module to calculate the cosine of theta 2
*					for a SCARA robot
*	Latency: 	114 Clock cycles
*
*	Parameters:
*				None
*	Dependencies:
*				FloatAdder.v
*				FloatToDouble.v
*				Sine.v
*				Cosine.v
*				DoubleMultiply.sv
*				DoubleToInt15Bit.v
*				ClockTimer.sv
*
*	NOTE: This module must be simulated with the
*			lpm_ver library.
***************************************************/
module ForwardKinematics(
								input signed [12:0] theta1,
								input signed [12:0] theta2,
								input logic clk,
								input logic enable,
								input logic reset,
								input logic [63:0] l1,
								input logic [63:0] l2,
								output logic [13:0] x,
								output logic [13:0] y,
								output logic dataReady);
								
			/*	State Transition logic */
			
			logic ConvThToFloatEn, ConvThToFloatDone;
			logic AddThetasEn, AddThetasDone;
			logic TrigFuncEn, TrigFuncDone;
			logic ConvTrigToDoubleEn, ConvTrigToDoubleDone;
			logic MultEn, MultDone;
			logic AddEn, AddDone;
			logic ConvToIntEn, ConvToIntDone;
			
			typedef enum logic [4:0] {ConvThToFloat, AddThetas, TrigCalcs, ConvTrigToDouble, MultTrig, AddTrig, ConvertToInt, Init} statetype;
			statetype state, nextstate;
			
			always_ff@(posedge clk, posedge reset) begin
				if(reset) begin
					nextstate <= Init;
					ConvThToFloatEn <= 0;
					AddThetasEn <= 0;
					TrigFuncEn <= 0;
					MultEn <= 0;
					AddEn <= 0;
					ConvToIntEn <= 0;
					ConvTrigToDoubleEn <= 0;
				end
				else if(state == Init) begin
					ConvThToFloatEn <= 0;
					AddThetasEn <= 0;
					TrigFuncEn <= 0;
					MultEn <= 0;
					AddEn <= 0;
					ConvToIntEn <= 0;
					ConvTrigToDoubleEn <= 0;
					if(enable)
						nextstate <= ConvThToFloat;
				end
				else if(state == ConvThToFloat) begin
					if(ConvThToFloatDone) begin
						ConvThToFloatEn <= 0;
						nextstate <= AddThetas;
					end
					else begin
						ConvThToFloatEn <= 1;
					end
				
				end
				else if(state == AddThetas) begin
					if(AddThetasDone) begin
						nextstate <= TrigCalcs;
						AddThetasEn <= 0;
					end
					else
						AddThetasEn <= 1;
				
				end
				else if(state == TrigCalcs) begin
					if(TrigFuncDone) begin
						TrigFuncEn <= 0;
						nextstate <= ConvTrigToDouble;
					
					end
					else 
						TrigFuncEn <= 1;
				end
				else if(state == ConvTrigToDouble) begin
					if(ConvTrigToDoubleDone) begin
						ConvTrigToDoubleEn <= 0;
						nextstate <= MultTrig;
						
					
					end
					else 
						ConvTrigToDoubleEn <= 1;
				
				end
				else if(state == MultTrig) begin
					if(MultDone) begin
						MultEn <= 0;
						nextstate <= AddTrig;
					end
					else 
						MultEn <= 1;
				end
				else if(state == AddTrig) begin
					if(AddDone) begin
						AddEn <= 0;
						nextstate <= ConvertToInt;
						
					end
					else
						AddEn <= 1;
				end
				else if(state == ConvertToInt) begin
					if(ConvToIntDone) begin
						ConvToIntEn <= 0;
						nextstate <= Init;
					
					end
					else
						ConvToIntEn <= 1;
				end
				state <= nextstate;
			end
			
			
			
			
			/* 	Converting thetas state		*/
			
			logic [31:0] Th1Float, Th2Float;
			
			Fixed13BitToFloat th1ToFloat(.dataa(theta1),
														.clock(clk),
														.clk_en(ConvThToFloatEn),
														.result(Th1Float));
														
			Fixed13BitToFloat th2ToFloat(.dataa(theta2),
														.clock(clk),
														.clk_en(ConvThToFloatEn),
														.result(Th2Float));
													
														
			logic [2:0] cnt;
			ClockTimer #(3,6) ConvertingThetasToFloatTimer(.en(ConvThToFloatEn),
																			.reset(~ConvThToFloatEn | reset),
																			.clk(clk),
																			.expire(ConvThToFloatDone)
																			);
			/*****************************************/
		
			/**** Add thetas state ***/
		
			logic [31:0] SummedThetas;
			
			FloatAdder summer(
									.dataa(Th1Float),
									.datab(Th2Float),
									.result(SummedThetas),
									.clock(clk),
									.clk_en(AddThetasEn)
									);
									
									
			ClockTimer #(4, 15) additionTimer(.clk(clk),
														.en(AddThetasEn),
														.reset(~AddThetasEn | reset),
														.expire(AddThetasDone));
													
				
			/*****************************************/
			
			/*** Trigonometry Functions (state machine for
					Switching arguments in sine and cosine for
					space optimization) **/
			logic [31:0] sinSum, cosineSum, sinth1, costh1;
			logic [31:0] SinInput, CosInput;
			logic [31:0] SinResult, CosResult;
			typedef enum logic [1:0] {InitTrig, Theta1Trig, SummedTrig} TrigStateType;
			logic [6:0] count;
			TrigStateType TrigState, TrigNextState;
			
			logic Theta1TrigEn, TrigFunctionDone;
			logic SummedTrigEn;
			// Both states use the same done wire
			always_ff@(posedge clk) begin
			
				if(reset | (state != TrigCalcs)) begin
					TrigFuncDone <= 0;
					TrigNextState <= InitTrig;
					Theta1TrigEn <= 0;
					SummedTrigEn <= 0;
					TrigFuncDone <= 0;
				end
				else if((TrigState == InitTrig) & (state == TrigCalcs)) begin
//						TrigFuncDone <= 0;
					TrigNextState <= Theta1Trig;
					Theta1TrigEn <= 0;
					SummedTrigEn <= 0;
//						CosInput <= Th1Float;
//						SinInput <= Th1Float;
				end
				// Trig for theta 1 state.
				else if (TrigState == Theta1Trig) begin
					if(TrigFunctionDone) begin
						TrigNextState <= SummedTrig;
						Theta1TrigEn <= 0;
						sinth1 <= SinResult;
						costh1 <= CosResult; // save the outputs
						
					end
					else begin
						Theta1TrigEn <= 1;
						SinInput <= Th1Float;
						CosInput <= Th1Float;
					end
				end
				// Trig for Summed thetas
				else if(TrigState == SummedTrig) begin
					if(TrigFunctionDone) begin
						TrigNextState <= InitTrig;
						sinSum <= SinResult;
						cosineSum <= CosResult;// Save the outputs
						SummedTrigEn <= 0;
						TrigFuncDone <= 1; // Inidicate to higher machine it is done
					end
					else begin
						SinInput <= SummedThetas;
						CosInput <= SummedThetas;
						SummedTrigEn <= 1;
					end
				end
				else begin
					Theta1TrigEn <= 0;
					SummedTrigEn <= 0;
				
				end
				TrigState <= TrigNextState;

				
			end
			
			Sine sineFunction(.data(SinInput),
									.clock(clk),
									.clk_en(Theta1TrigEn | SummedTrigEn),
									.result(SinResult));
									
			Cosine cosineFunction(.data(CosInput),
										.clock(clk),
										.clk_en(Theta1TrigEn | SummedTrigEn),
										.result(CosResult));
			
											
			ClockTimer #(7, 35) TrigFunctionTimer(.clk(clk),
																.en(Theta1TrigEn | SummedTrigEn),
																.reset((~Theta1TrigEn & ~SummedTrigEn) | reset),
																.expire(TrigFunctionDone),
																.count(count));
			
//			Sine sineOfSummedThetas(
//											.data(SummedThetas),
//											.clock(clk),
//											.clk_en(TrigFuncEn),
//											.result(sinSum)
//											);
//											
//			Sine sinOfTh1(
//							.data(Th1Float),
//							.clock(clk),
//							.clk_en(TrigFuncEn),
//							.result(sinth1)
//							);
//							
//			Cosine cosineOfTh1(
//							.data(Th1Float),
//							.clock(clk),
//							.clk_en(TrigFuncEn),
//							.result(costh1)
//							);
//			
//			
//			Cosine cosineOfSummedThetas(
//			
//											.data(SummedThetas),
//											.clock(clk),
//											.clk_en(TrigFuncEn),
//											.result(cosineSum)
//											);
																
			/**********************************************/
			/* Convert trig to double state */
			
			logic [63:0] sinSumDouble, cosineSumDouble, sinth1Double, costh1Double;
			
			FloatToDouble sinSumToDouble(.dataa(sinSum),
													.result(sinSumDouble),
													.clock(clk),
													.clk_en(ConvTrigToDoubleEn));
			FloatToDouble cosineSumToDouble(.dataa(cosineSum),
													.result(cosineSumDouble),
													.clock(clk),
													.clk_en(ConvTrigToDoubleEn));
			FloatToDouble sinth1ToDouble(.dataa(sinth1),
													.result(sinth1Double),
													.clock(clk),
													.clk_en(ConvTrigToDoubleEn));
			FloatToDouble costh1ToDouble(.dataa(costh1),
													.result(costh1Double),
													.clock(clk),
													.clk_en(ConvTrigToDoubleEn));
			
			ClockTimer #(3, 7) convertTrigToDoubleTimer(.en(ConvTrigToDoubleEn),
																		.clk(clk),
																		.reset(~ConvTrigToDoubleEn | reset),
																		.expire(ConvTrigToDoubleDone),
																		.count(cnt));
			/**********************************************/
			
			
			/*	Multiply everything out */
			
			logic [63:0] l1CosTh1, l2CosThSum, l1SinTh1, l2SinThSum;
			logic mult1Done, mult2Done, mult3Done, mult4Done;
			assign MultDone = mult1Done & mult2Done & mult3Done & mult4Done;
		
			DoubleMultiply l1costh1Mult(.dataa(l1),
												.datab(costh1Double),
												.result(l1CosTh1),
												.clk(clk),
												.in_ready(MultEn),
												.data_ready(mult1Done),
												.reset(~MultEn | reset)
												);
												
			DoubleMultiply l1sinth1Mult(.dataa(l1),
												.datab(sinth1Double),
												.result(l1SinTh1),
												.clk(clk),
												.in_ready(MultEn),
												.data_ready(mult2Done),
												.reset(~MultEn | reset)
												);
												
			
			
			DoubleMultiply l2sinSumMult(.dataa(l2),
												.datab(sinSumDouble),
												.result(l2SinThSum),
												.clk(clk),
												.in_ready(MultEn),
												.data_ready(mult3Done),
												.reset(~MultEn | reset)
												);
												
			DoubleMultiply l2cosSumMult(.dataa(l2),
												.datab(cosineSumDouble),
												.result(l2CosThSum),
												.clk(clk),
												.in_ready(MultEn),
												.data_ready(mult4Done),
												.reset(~MultEn | reset)
												);
			/******************************************************/
			
			
			/* Add everything together */
			
			logic [63:0] xDouble, yDouble;
			logic addxDone, addyDone;
			
			assign AddDone = addxDone & addyDone;
			
			DoubleAdder xAddition(.dataa(l1CosTh1),
										.datab(l2CosThSum),
										.reset(~AddEn | reset),
										.result(xDouble),
										.in_ready(AddEn),
										.clk(clk),
										.data_ready(addxDone));
										
										
			DoubleAdder yAddition(.dataa(l1SinTh1),
										.datab(l2SinThSum),
										.reset(~AddEn | reset),
										.result(yDouble),
										.in_ready(AddEn),
										.clk(clk),
										.data_ready(addyDone));
										
			/********************************************************/
			
			
			/* Convert to integers */
			
			logic [14:0] xConv, yConv;
			// 15 bit not 14 bit because the conversion
			// is signed, so to get all the range necessary
			// the 15 bit must be added and then chopped off.
			
			assign x = xConv[13:0];
			assign y = yConv[13:0];
			
			DoubleToInt15Bit xConverter(.dataa(xDouble),	
													.result(xConv),
													.clock(clk),
													.clk_en(ConvToIntEn));
													
			DoubleToInt15Bit yConverter(.dataa(yDouble),	
													.result(yConv),
													.clock(clk),
													.clk_en(ConvToIntEn));
													
			ClockTimer #(4, 6) ConvertToIntTimer(.en(ConvToIntEn),
																.reset(~ConvToIntEn | reset),
																.clk(clk),
																.expire(ConvToIntDone));
			
			assign dataReady = ConvToIntDone;
			/**********************************************************/
			
			
								
endmodule
								