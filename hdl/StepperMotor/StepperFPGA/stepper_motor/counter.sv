module counter #(parameter N = 8)
			(input  logic clk,
			 input  logic reset_n,
			 input  logic reset1_n,
			 input  logic en,
			 output logic [N-1:0] q);
	always_ff @(posedge clk, negedge reset_n, negedge reset1_n)
		if ((!reset_n)|(!reset1_n))	q <= 0;
		else if(en) 						q <= q + 1;
endmodule