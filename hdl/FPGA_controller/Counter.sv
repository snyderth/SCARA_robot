/***************************************************
*	File: 		Counter
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Counts on clk. Increments D by one.
*					for counter functionality, connect D
*					and Q in higher level module.
*	Parameters:
*				1) Width: Width of counter bus
*
*	Dependencies:
*				None
*
***************************************************/
module Counter#(parameter width=32)(input logic 		clk,
					input  logic 		enable,
					input  logic 		reset,
					input  logic [(width-1):0] d,
					output logic [(width-1):0] q);

			always_ff@(posedge clk, posedge reset)
			begin
				if(reset) q <= 0;
				else if (enable) q <= q + 1;
			end
					
endmodule
