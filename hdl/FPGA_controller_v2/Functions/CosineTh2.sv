/***************************************************
*	File: 		CosineTh2
*	Author: 		Thomas Snyder
*	Date:			2/19/2020
*	Description:Module to calculate the cosine of theta 2
*					for a SCARA robot
*	Latency: 	52 Clock cycles
*
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
module CosineTh2(input logic [13:0] xTarget, 
						input logic [13:0] yTarget,
						input logic [63:0] l1Squared,
						input logic [63:0] l2Squared,
						input logic [63:0] l1,
						input logic [63:0] l2,
						input logic clk,
						input logic enable,
						input logic reset,
						output logic [63:0] CosTh2,
						output logic dataReady);
						
						
				/******************* Convert targets to double *****************/
				
				logic convBegin, convDone;
				logic [63:0] xTarget_d, yTarget_d;
						
				SRLatch ConversionLatch(
												.set(enable),
												.reset(reset | convDone),
												.q(convBegin));
												
				ClockTimer #(3, 6) conversionTimer(
													.en(convBegin),
													.clk(clk),
													.reset(reset),
													.expire(convDone)
													);
				
				//NOTE: Conversions are 15 bit even though
				// x and y are 14 bit because the converters
				// take in two's complement, so if MSb is set,
				// it thinks its negative
				Int15BitToDouble xtarget(
												.clk_en(convBegin),
												.clock(clk),
												.result(xTarget_d),
												.dataa({1'b0, xTarget}));
												
				Int15BitToDouble ytarget(
												.clk_en(convBegin),
												.clock(clk),
												.result(yTarget_d),
												.dataa({1'b0, yTarget}));
												
				/************************************************/
				

				/*	Square x and y once conversions are finished */
				
				logic mult1Done, mult1Begin, xSquareDone, ySquareDone;
				logic [63:0] xTargSquared, yTargSquared;
//				
//				SRLatch multStage1 (.set(convDone),
//											.reset(reset | mult1Done),
//											.q(mult1Begin)
//											);
											
				DoubleMultiply xSquared(
												.in_ready(convDone),
												.reset(reset),
												.dataa(xTarget_d),
												.datab(xTarget_d),
												.result(xTargSquared),
												.data_ready(xSquareDone),
												.clk(clk)
												);
				
				DoubleMultiply ySquared(
												.reset(reset),
												.in_ready(convDone),
												.dataa(yTarget_d),
												.datab(yTarget_d),
												.result(yTargSquared),
												.data_ready(ySquareDone),
												.clk(clk)
												);
												
				
				
				// During this stage we can also multiply l1 and l2
				logic [63:0] l1l2;
				logic l1l2Done;
				
			  DoubleMultiply l1Timesl2(
												.reset(reset),
												.in_ready(convDone),
												.dataa(l1),
												.datab(l2),
												.result(l1l2),
												.data_ready(l1l2Done),
												.clk(clk));
				
				
				assign mult1Done = xSquareDone & ySquareDone & l1l2Done;
				
				/***********************************************/
				
				/*		Now add the lengths squared and targets squared and multiply l1l2 by two */
				
				
				logic [63:0] l1l2SquaredSum, xySquaredSum, twicel1l2;
				logic l1l2SumDone, xySumDone, l1l2Times2Done;
				
				
				DoubleAdder SumXYSquared(
												.reset(reset),
												.in_ready(mult1Done),
												.dataa(xTargSquared),
												.datab(yTargSquared),
												.result(xySquaredSum),
												.data_ready(xySumDone),
												.clk(clk)
												);
												
												
				DoubleAdder Suml1l2Squared(
												.reset(reset),
												.in_ready(mult1Done),
												.dataa(l1Squared),
												.datab(l2Squared),
												.result(l1l2SquaredSum),
												.data_ready(l1l2SumDone),
												.clk(clk)
												);
												
												
				DoubleMultiply l1l2doubled(
												.reset(reset),
												.in_ready(mult1Done),
												.dataa(l1l2),
												.datab(64'b0100000000000000000000000000000000000000000000000000000000000000), //2 in IEEE 754 double
												.result(twicel1l2),
												.data_ready(l1l2Times2Done),
												.clk(clk)
												);
												
				logic multLatchReset, l1l2Times2LatchDone;
				// necesssary because multiplication takes half the time
				// of addition
				SRLatch l1l2DoubledLatch(
												.set(l1l2Times2Done),
												.reset(reset | multLatchReset),
												.q(l1l2Times2LatchDone)
												);
				
				logic [63:0] divisor;
				// Register to hold the result of the multiplication.
				always_ff@(posedge l1l2Times2Done, posedge reset)
					if(reset) divisor <= 64'b0;	
					else divisor <= twicel1l2;
				
				/***********************************************/
				
				/** Subtract xy sum and l1l2 sum **/
				
				logic [63:0] xyMinl1l2;
				logic subtractionDone;
				
				DoubleAdder xysubl1l2 (
												.dataa(xySquaredSum),
												.datab({~l1l2SquaredSum[63], l1l2SquaredSum[62:0]}),
												.result(xyMinl1l2),
												.clk(clk),
												.reset(reset),
												.in_ready(l1l2SumDone & xySumDone),
												.data_ready(subtractionDone)
											);
											
				/************************************/
				
				/*********** Divide out everything ***********/
				
				DoubleDivider finalDiv(
									.dataa(xyMinl1l2),
									.datab(divisor),
									.result(CosTh2),
									.reset(reset),
									.clk(clk),
									.enable(subtractionDone),
									.data_ready(dataReady)
								);
								
				
				
endmodule 
