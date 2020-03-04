/***************************************************
*	File: 		CalculateSteps
*	Author: 		Thomas Snyder
*	Date:			2/22/2020
*	Description:Module to calculate the cosine of theta 2
*					for a SCARA robot
*	Latency: 	28 Clock cycles
*
*	Parameters:
*				None
*	Dependencies:
*				DoubleToInt9Bit.v
*				ClockTimer.sv
*				DoubleMultiply.sv
*
*	NOTE: This module must be simulated with the
*			lpm_ver library.
***************************************************/
module CalculateSteps(input signed [12:0] th1,
							input signed [12:0] th2,
							input logic clk,
							input logic enable,
							input logic reset,
							output logic [8:0] steps1,
							output logic [8:0] steps2,
							output logic dir1,
							output logic dir2,
							output logic dataReady);
				//95.4930465147 //31.8310155049 steps/rad 
				logic [63:0] convRadToSteps = 64'b0100000001010111110111111000111000010010111110000000001011000101;//64'b0100000000111111110101001011110101101110101000000000001110110001;
							
				logic ConvThEn, ConvThDone;
				logic MultEn, MultDone;
				logic ConvStepEn, ConvStepDone;
				
				typedef enum logic [2:0] {Init, ConvertThetaToDouble, MultiplyConversion, ConvertToInt} statetype;
				statetype state, nextstate;
				
				
				always_ff@(posedge clk) begin
					if(reset) begin
						nextstate <= Init;
						ConvThEn <= 0;
						MultEn <= 0;
						ConvStepEn <= 0;
						
					end
					else if(state == Init) begin
						ConvThEn <= 0;
						MultEn <= 0;
						ConvStepEn <= 0;
						if(enable)
							nextstate <= ConvertThetaToDouble;
					end
					else if(state == ConvertThetaToDouble) begin
						if(ConvThDone) begin
							ConvThEn <= 0;
							nextstate <= MultiplyConversion;
						end
						else begin
							ConvThEn <= 1;
						end
					end
					else if(state == MultiplyConversion) begin
						if(MultDone) begin
							MultEn <= 0;
							nextstate <= ConvertToInt;
						end
						else begin
							MultEn <= 1;
						end
					end
					else if(state == ConvertToInt) begin
						if(ConvStepDone) begin
							ConvStepEn <= 0;
							nextstate <= Init;
						end	
						else begin
							ConvStepEn <= 1;
						end
					end
				
					state <= nextstate;
				end
							
				
				/*		Convert fixed point thetas to doubles */
							
				logic [63:0] th1Double, th2Double;
				
				Fixed13BitToDouble ConvertTheta1(
														.clock(clk),
														.clk_en(ConvThEn),
														.dataa(th1),
														.result(th1Double)
															);
				Fixed13BitToDouble ConvertTheta2(
														.clock(clk),
														.clk_en(ConvThEn),
														.dataa(th2),
														.result(th2Double)
															);
				ClockTimer #(3, 6) conversionTimer(
														.en(ConvThEn),
														.reset(~ConvThEn | reset),
														.clk(clk),
														.expire(ConvThDone)
															);
				
				/**********************************************/
				
				/*		Multiply by conversion 	*/
				logic [63:0] steps1Double, steps2Double;
				logic Mult1Done, Mult2Done;
				
				assign MultDone = Mult1Done & Mult2Done;
				
				DoubleMultiply steps1Converter(
											.dataa(th1Double),
											.datab(convRadToSteps),
											.result(steps1Double),
											.clk(clk),
											.in_ready(MultEn),
											.data_ready(Mult1Done),
											.reset(~MultEn | reset)
											);
				DoubleMultiply steps2Converter(
											.dataa(th2Double),
											.datab(convRadToSteps),
											.result(steps2Double),
											.clk(clk),
											.in_ready(MultEn),
											.data_ready(Mult2Done),
											.reset(~MultEn | reset)
											);			
											
				/***********************************************/
				
				/* Convert 64 bit double precision to integer. */
				
				assign dir1 = ~steps1Double[63]; // 1 means positive rotation
				assign dir2 = ~steps2Double[63]; // 0 means negative rotation
				
				
				DoubleToInt9Bit StepsConversion1 (
															.dataa({steps1Double[63] ^ steps1Double[63], steps1Double[62:0]}),
															.clk_en(ConvStepEn),
															.clock(clk),
															.result(steps1)
															);
				
				DoubleToInt9Bit StepsConversion2(
															.dataa({steps2Double[63] ^ steps2Double[63],steps2Double[62:0]}),
															.clk_en(ConvStepEn),
															.clock(clk),
															.result(steps2)
															);
															
				ClockTimer #(3, 6) StepsConversionTimer(
															.en(ConvStepEn),
															.reset(~ConvStepEn | reset),
															.clk(clk),
															.expire(ConvStepDone)
															);
															
				assign dataReady = ConvStepDone;											
				
				
				/************************************************/
				
							
							
endmodule
							