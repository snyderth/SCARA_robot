/***************************************************
*	File: 		SRLatch
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Rudimentary SR Latch.
*
*	Parameters:
*				None
*	Dependencies:
*				None
*
***************************************************/
module SRLatch(input logic set,
					input logic reset,
					output logic q,
					output logic qn);
		
//		logic qstate;
		
		always_ff@(posedge set, posedge reset)
		begin
			if(reset)
			begin
				q <= 0;
				qn <= 1;
			end
			else if(set)
			begin
				q <= 1;
				qn <= 0;
			end
		end
					
					
					
endmodule
