
module Atan2 (
	clk,
	areset,
	x,
	y,
	q,
	en);	

	input		clk;
	input		areset;
	input	[31:0]	x;
	input	[31:0]	y;
	output	[10:0]	q;
	input	[0:0]	en;
endmodule
