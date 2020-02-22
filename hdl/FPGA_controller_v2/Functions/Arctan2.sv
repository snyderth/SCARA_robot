/***************************************************
*	File: 		Arctan2
*	Author: 		Thomas Snyder
*	Date:			2/18/2020
*	Description:Atan2 wrapper that accepts 64-bit floating
*					point numbers
*	Outputs: Fixed point 13 bit number:
					3 integer bits
					10 Fractional bits
*	Parameters:
*				None
*	Dependencies:
*				SRLatch.sv
*				DoubleTo32BitFixed.v
*				ClockTimer.sv
*				Atan2.v
*
*	NOTE: This module must be simulated with the
*			220model_ver library.
***************************************************/
module Arctan2(input logic [63:0] arg1,
					input logic [63:0] arg2,
					input logic clk,
					input logic enable,
					input logic reset,
					output signed [12:0] angle,
					output logic DataReady);
					
					/* 		Convert the numbers to fixed point  	*/
					
					logic convStart, convDone;
					logic [31:0] arg1FixedPoint, arg2FixedPoint;
					
					SRLatch convBegin(
										.set(enable),
										.reset(reset | convDone),
										.q(convStart));
					
					DoubleTo32BitFixed arg1Conv(
											.clock(clk),
											.clk_en(convStart),
											.dataa(arg1),
											.result(arg1FixedPoint)
										);
					
					DoubleTo32BitFixed arg2Conv(
											.clock(clk),
											.clk_en(convStart),
											.dataa(arg2),
											.result(arg2FixedPoint)
										);
										
					ClockTimer #(4, 6) convTimer(
												.clk(clk),
												.en(convStart),
												.reset(reset | ~convStart),
												.expire(convDone)
												);
										
					/***********************************************/
					
					/*				Actual arctan function					*/
					logic atanStart, atanDone;
					
					SRLatch atan2Begin(.set(convDone),
											.reset(reset | atanDone),
											.q(atanStart));
					
					Atan2 arctangent(.en(atanStart),
							.clk(clk),
							.areset(reset),
							.x(arg2FixedPoint),//arg2
							.y(arg1FixedPoint), //arg1
							.q(angle));
							
							
					logic [3:0] cnt;		
					
					ClockTimer #(5, 16) atanTimer(
															.clk(clk),
															.count(cnt),
															.en(atanStart),
															.reset(reset | ~atanStart),
															.expire(atanDone));
					/***********************************************/
					
					assign DataReady = atanDone;
					
endmodule 
