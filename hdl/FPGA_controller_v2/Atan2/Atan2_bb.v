
module Atan2 (
	areset,
	clk,
	en,
	q,
	x,
	y);	

	input		areset;
	input		clk;
	input	[0:0]	en;
	output	[12:0]	q;
	input	[31:0]	x;
	input	[31:0]	y;
endmodule
