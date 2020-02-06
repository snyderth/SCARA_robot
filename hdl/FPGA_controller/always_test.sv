module always_test(input logic clk,
		input logic [63:0] multiplcand,
		input logic [63:0] multiplier,
	  	input logic reset,
		output logic [63:0] out,
	  	output logic q);
	

	logic [63:0] result;

	
	Multiplier mult_inst(.aclr(1'b0), 
			     	.clk_en(1'b1),
				.clock(clk),
				.dataa(multiplicand),
				.datab(multiplier),
				.result(result));

	always@(result)
	begin

		out<=result;
		q <= 1'b1;

	end
endmodule