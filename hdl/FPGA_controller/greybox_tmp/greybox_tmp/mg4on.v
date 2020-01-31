//lpm_divide CBX_SINGLE_OUTPUT_FILE="ON" LPM_DREPRESENTATION="SIGNED" LPM_HINT="MAXIMIZE_SPEED=6,LPM_REMAINDERPOSITIVE=FALSE" LPM_NREPRESENTATION="SIGNED" LPM_PIPELINE=1 LPM_TYPE="LPM_DIVIDE" LPM_WIDTHD=14 LPM_WIDTHN=14 clock denom numer quotient remain
//VERSION_BEGIN 19.1 cbx_mgl 2019:09:22:09:26:20:SJ cbx_stratixii 2019:09:22:08:02:34:SJ cbx_util_mgl 2019:09:22:08:02:34:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2019  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.



//synthesis_resources = lpm_divide 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mg4on
	( 
	clock,
	denom,
	numer,
	quotient,
	remain) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   [13:0]  denom;
	input   [13:0]  numer;
	output   [13:0]  quotient;
	output   [13:0]  remain;

	wire  [13:0]   wire_mgl_prim1_quotient;
	wire  [13:0]   wire_mgl_prim1_remain;

	lpm_divide   mgl_prim1
	( 
	.clock(clock),
	.denom(denom),
	.numer(numer),
	.quotient(wire_mgl_prim1_quotient),
	.remain(wire_mgl_prim1_remain));
	defparam
		mgl_prim1.lpm_drepresentation = "SIGNED",
		mgl_prim1.lpm_nrepresentation = "SIGNED",
		mgl_prim1.lpm_pipeline = 1,
		mgl_prim1.lpm_type = "LPM_DIVIDE",
		mgl_prim1.lpm_widthd = 14,
		mgl_prim1.lpm_widthn = 14,
		mgl_prim1.lpm_hint = "MAXIMIZE_SPEED=6,LPM_REMAINDERPOSITIVE=FALSE";
	assign
		quotient = wire_mgl_prim1_quotient,
		remain = wire_mgl_prim1_remain;
endmodule //mg4on
//VALID FILE
