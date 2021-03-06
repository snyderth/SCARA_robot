// Atan2.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module Atan2 (
		input  wire        areset, // areset.reset
		input  wire        clk,    //    clk.clk
		input  wire [0:0]  en,     //     en.en
		output wire [12:0] q,      //      q.q
		input  wire [31:0] x,      //      x.x
		input  wire [31:0] y       //      y.y
	);

	Atan2_CORDIC_0 cordic_0 (
		.clk    (clk),    //    clk.clk
		.areset (areset), // areset.reset
		.en     (en),     //     en.en
		.x      (x),      //      x.x
		.y      (y),      //      y.y
		.q      (q)       //      q.q
	);

endmodule
