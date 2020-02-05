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
