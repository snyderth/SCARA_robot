/***************************************************
*	File: 		SquareRoot
*	Author: 		Thomas Snyder
*	Date:			2/19/2020
*	Description:Wrapper around Altera auto-generated
* 					SqRoot function to add sync signals.
*	Latency: 	30 Cycles
*
*	Parameters:
*				None
*	Dependencies:
*				ClockTimer.sv
*				SqRoot.v
*	NOTE: This module must be simulated with the
*			LPM_ver library.
***************************************************/
module SquareRoot(input logic [63:0] data,
						input logic clk,
						input logic clk_en,
						input logic reset,
						output logic [63:0] result,
						output logic dataReady);
			
	SqRoot root (.data(data),
					.clock(clk),
					.clk_en(clk_en),
					.result(result));
					
					
	ClockTimer #(6, 30) timer(.en(clk_en),
									  .reset(reset | ~clk_en),
									  .expire(dataReady),
									  .clk(clk));
			
						
						
endmodule
	