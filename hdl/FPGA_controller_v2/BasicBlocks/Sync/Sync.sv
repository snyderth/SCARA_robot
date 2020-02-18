module Sync(input logic d, clk, en, reset,
				output logic q);
				
				
		logic n1;
		
		always_ff@(posedge clk, posedge reset)
		begin
		
			if(reset) q <= 0;
			else if (en)
			begin
				n1 <= d;
				q <= n1;
			end
		
		end
				
endmodule
