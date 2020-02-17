/***************************************************
*	File: 		ForwardKinematics
*	Author: 		Thomas Snyder
*	Date:			2/7/2020
*	Description:Implementation of the SCARA robot
*					forward kinematics.
*		x = l1 * cos(th1) + l2 * sin(th1 + th2)
*		y = l1 * sin(th1) + l2 * cos(th1 + th2)
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
module ForwardKinematics(input signed [8:0] th1,
								 input signed [8:0] th2,
								 input logic	[13:0] l1,
								 input logic 	[13:0] l2,
								 input logic	enable,
								 input logic 	clk,
								 input logic  reset,
								 output logic data_ready,
								 output logic [63:0] x,
								 output logic [63:0] y);
		

		logic MultBegin;

		// Ensure conversions do not trigger before clock
		// timer begins counting
		logic en;
		assign en = enable & ~reset;
		
		logic [63:0] L1Double;
		logic [63:0] L2Double;


/* Converting integer lengths to double lengths */													
				
		// 15 bits because it expects two's compelement
		Int15BitToDouble	l1conv (
												.clk_en ( en ),
												.clock ( clk ),
												.dataa ( {1'b0, l1} ),
												.result ( L1Double )
												);
										
		Int15BitToDouble	l2conv (
												.clk_en ( en ),
												.clock ( clk),
												.dataa ( {1'b0, l2} ),
												.result ( L2Double )
												);

	logic [9:0] cnt;
												
	//Six cycle latency for conversion (1 cycle latency on counter)
	ClockTimer #(10, 6) LConvTime (.clk(clk), .en(enable), .reset(reset), .expire(MultBegin));//, .count(cnt));

/******************************************************/

												
/* Sine/Cosine calculations */												
		logic [63:0] cosineth12, sineth12, sineth1, costh1;
							
		logic [8:0] th12;
		
		always_comb
		begin
			th12 = th1 + th2;
		end
	

		
		SinDeg sine(
							.data_in(th1),
							.data_out(sineth1)
							);

	
		SinDeg sinesum(
							.data_in(th12),
							.data_out(sineth12)
						);
		
		CosDeg cosine(
							.data_in(th1),
							.data_out(costh1)
							);
		
		CosDeg cosinesum(
							.data_in(th12),
							.data_out(cosineth12)
							);
							
/**************************/
		

/* Multiplying it all out */
/* Multiplies have 5 cycle latency */
		logic [63:0] l1Sine, l2CosSum, l1Cos, l2SinSum;
		logic [63:0] L1SineL2Cosfory, L1CosL2Sineforx;
		logic data1, data2, data3, data4;
		
		DoubleMultiply multL1Sine(.dataa(sineth1),
											.datab(L1Double),
											.clk(clk),
											.in_ready(MultBegin),
											.result(l1Sine),
											.data_ready(data1),
											.reset(reset));
											
		DoubleMultiply multL2CosSum(.dataa(cosineth12),
												.datab(L2Double),
												.clk(clk),
												.in_ready(MultBegin),
												.result(l2CosSum),
												.data_ready(data2),
												.reset(reset));
		
		DoubleMultiply multL1Cos(.dataa(costh1),
										  .datab(L1Double),
										  .clk(clk),
										  .in_ready(MultBegin),
										  .result(l1Cos),
										  .data_ready(data3),
										  .reset(reset));
		
		DoubleMultiply multL2SinSum(.dataa(sineth12),
											.datab(L2Double),
											.clk(clk),
											.in_ready(MultBegin),
											.result(l2SinSum),
											.data_ready(data4),
											.reset(reset));
		
		/* Add Everything together */
		
		logic add_begin;
		
		always_comb
			add_begin = data1 & data2 & data3 & data4;
		
		logic dataX, dataY;
		
		DoubleAdder addy(.dataa(l1Sine),
							 .datab(l2SinSum),
							 .clk(clk),
							 .in_ready(add_begin),
							 .reset(reset),
							 .result(y),
							 .data_ready(dataY));
		
		
		DoubleAdder addx(.dataa(l2CosSum),
							 .datab(l1Cos),
							 .clk(clk),
							 .in_ready(add_begin),
							 .reset(reset),
							 .result(x),
							 .data_ready(dataX));
							 
		always_comb
			data_ready = dataX & dataY;
			
		
endmodule
