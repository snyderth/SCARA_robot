/***************************************************
*	File: 		Jacobian
*	Author: 		Thomas Snyder
*	Date:			2/7/2020
*	Description:A module to compute the jacobian
*					of the SCARA forward kinematics.
*					This module has a latency of 
*					28 clock cycles.
*
*	Parameters:
*				None
*
*	Dependencies:
*				ClockTimer.sv
*				DoubleAdder.sv
*				DoubleMultiplier.sv
*				IntToDouble.v
*				
*
*	NOTE: For simulation, the file needs
*			the library to be specified via 
*			-L <path_to_model220-lib>
*
***************************************************/
module Jacobian(input	logic 	[31:0] l1,
					 input	logic 	[31:0] l2,
					 input	logic		[8:0]	th1,
					 input	logic		[8:0]	th2,
					 input	logic 	clk,
					 input 	logic		enable,
					 input 	logic		reset,
					 output 	logic 	data_ready,
					 output  logic 	[63:0] dx_dth1,
					 output  logic 	[63:0] dx_dth2,
					 output  logic 	[63:0] dy_dth1,
					 output  logic 	[63:0] dy_dth2);
					 
	/* Convert l1, l2 into 64 bit floating point */
	logic [63:0] L1Double, L2Double;
	logic en, ConvComplete, ConvStart;
	
	logic [9:0] count;
	
	assign en = enable & ~reset;
	
	// Need to latch the enable for the converters
	// and the ClockTimer
	SRLatch ConvLatch(
							.set(en),
							.reset(ConvComplete | reset),
							.q(ConvStart)
							);
	
	IntToDouble len1(
						.clk_en(ConvStart),
						.clock(clk),
						.dataa(l1),
						.result(L1Double)
					);
					
					
	IntToDouble len2(
						.clk_en(ConvStart),
						.clock(clk),
						.dataa(l2),
						.result(L2Double)
					);
					
					
	// To time the conversion, which takes 6 cycles
	ClockTimer #(10, 6) ConvTime (
										.en(ConvStart),
										.reset(reset),
										.clk(clk),
										.count(count),
										.expire(ConvComplete)
										);
	/**********************************************/
	
	
	/*	Perform sin/cos operations */
	logic [63:0] sin_th1, sin_th12, cos_th1, cos_th12;
	logic [8:0] th12;
	
	always_comb begin
		th12 = th1 + th2;
	end	
	
	CosDeg cos1(
					.data_in(th1),
					.data_out(cos_th1)
					);
					
	CosDeg cos12(
					.data_in(th12),
					.data_out(cos_th12)
					);
					
	SinDeg sin1(
					.data_in(th1),
					.data_out(sin_th1)
					);
					
	SinDeg sin12(
					.data_in(th12),
					.data_out(sin_th12)
					);
	
	/******************************/
						
	/*	Perform Multiplications */
	
	logic [63:0] l2SinSum; 	// l2 * sin(th1 + th2)
	logic [63:0] l1Sin; 		// l1 * sin(th1)
	logic [63:0] l2CosSum; 	// l2 * cos(th1 + th2)
	logic [63:0] l1Cos;	 	// l1 * cos(th1)
	
	logic ready1, ready2, ready3, ready4;
	
	DoubleMultiply c1(
						.dataa(cos_th1),
						.datab(L1Double),
						.clk(clk),
						.reset(reset),
						.in_ready(ConvComplete),
						.result(l1Cos),
						.data_ready(ready1)
						);
						
	DoubleMultiply c12(
						.dataa(cos_th12),
						.datab(L2Double),
						.clk(clk),
						.reset(reset),
						.in_ready(ConvComplete),
						.result(l2CosSum),
						.data_ready(ready2)
						);
	
	DoubleMultiply s1(
						.dataa(sin_th1),
						.datab(L1Double),
						.clk(clk),
						.reset(reset),
						.in_ready(ConvComplete),
						.result(l1Sin),
						.data_ready(ready3)
						);
						
	DoubleMultiply s12(
						.dataa(sin_th12),
						.datab(L2Double),
						.clk(clk),
						.reset(reset),
						.in_ready(ConvComplete),
						.result(l2SinSum),
						.data_ready(ready4)
						);
	
	assign MultComplete = ready1 & ready2 & ready3 & ready4; // Mult done sig
	
	/*********************************/

	
	/*	Add the negatives (just like subtraction) */
	logic addR1, addR2; // For signaling finished
	
	DoubleAdder xth1(
							.dataa({~l2SinSum[63], l2SinSum[62:0]}),
							.datab({~l1Sin[63], l1Sin[62:0]}), // Negate the operands for Calculation purposes
							.in_ready(MultComplete),
							.clk(clk),
							.result(dx_dth1),
							.reset(reset),
							.data_ready(addR1)
							);
							
	DoubleAdder yth1(
							.dataa(l1Cos),
							.datab(l2CosSum),
							.in_ready(MultComplete),
							.clk(clk),
							.result(dy_dth1),
							.reset(reset),
							.data_ready(addR2)
							);
							
	assign data_ready = addR1 & addR2;
	
	assign dx_dth2 = {~l2SinSum[63], l2SinSum[62:0]};
	assign dy_dth2 = l2CosSum;
	
endmodule
