/***************************************************
*	File: 		DoubleMultiply
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Wrapper around altera double precision
*					floating point multiplier to add signal
*					circuitry for when output can be read.
*	Parameters:
*				None
*
*	Dependencies:
*				SRLatch.sv
*				MultiplierFP.v
*				ClockTimer.sv
*
*	NOTE: For simulation, the MultiplierFP file needs
*			the library to be specified via 
*			-L <path_to_model220-lib>
*
***************************************************/
module DoubleMultiply(input logic [63:0] dataa,
							input logic [63:0] datab,
							input logic clk,
							input logic in_ready,
							input logic reset,
							output logic underflow,
							output logic overflow,
							output logic nan,
							output logic zero,
							output logic data_ready,
							output logic [4:0] count,
							output logic [63:0] result);

		logic clock_en, out;
							
		/* Make sure we start the mult and the clock time simult.*/
		SRLatch InCtrl(.set(in_ready),
							.reset(reset | out),
							.q(clock_en),
							.qn());
							
							
		MultiplierFP mult(.clock(clk),
							 .clk_en(clock_en & ~data_ready),
							 .dataa(dataa),
							 .datab(datab),
							 .result(result),
							 .underflow(underflow),
							 .overflow(overflow),
							 .nan(nan),
							 .zero(zero));
		
		
		logic dsync, n1; // For sync

		
		/* Once the multiplier starts, count to 5, then output
			Signalling the multiplication is done and the data
			can be read
		*/
		ClockTimer #(5, 5) MultTime(.en(clock_en),
											.clk(clk),
											.reset(data_ready),
											.expire(data_ready));
											
		
//		/* Sync */
//		
//		always_ff@(posedge clk)
//		begin
//			n1 <= dsync;
//			data_ready <= n1;
//		end
//		
		/* REset after output */
		always@(data_ready)
		begin
			if(data_ready) out<=1;
			else out<=0;
		end
endmodule

