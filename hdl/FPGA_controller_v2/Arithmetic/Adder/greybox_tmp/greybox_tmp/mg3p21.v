//altsyncram ADDRESS_ACLR_A="NONE" CBX_SINGLE_OUTPUT_FILE="ON" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" INIT_FILE="UNUSED" INTENDED_DEVICE_FAMILY=""Cyclone V"" NUMWORDS_A=65536 OPERATION_MODE="ROM" OUTDATA_ACLR_A="NONE" OUTDATA_REG_A="CLOCK0" WIDTH_A=0 WIDTH_B=1 WIDTH_BYTEENA_A=1 WIDTH_BYTEENA_B=1 WIDTH_ECCSTATUS=3 WIDTHAD_A=16 WIDTHAD_B=1 address_a clock0 q_a
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



//synthesis_resources = altsyncram 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mg3p21
	( 
	address_a,
	clock0,
	q_a) /* synthesis synthesis_clearbox=1 */;
	input   [15:0]  address_a;
	input   clock0;
	output   q_a;

	wire  wire_mgl_prim1_q_a;

	altsyncram   mgl_prim1
	( 
	.address_a(address_a),
	.clock0(clock0),
	.q_a(wire_mgl_prim1_q_a));
	defparam
		mgl_prim1.address_aclr_a = "NONE",
		mgl_prim1.clock_enable_input_a = "BYPASS",
		mgl_prim1.clock_enable_output_a = "BYPASS",
		mgl_prim1.intended_device_family = ""Cyclone V"",
		mgl_prim1.numwords_a = 65536,
		mgl_prim1.operation_mode = "ROM",
		mgl_prim1.outdata_aclr_a = "NONE",
		mgl_prim1.outdata_reg_a = "CLOCK0",
		mgl_prim1.width_a = 0,
		mgl_prim1.width_b = 1,
		mgl_prim1.width_byteena_a = 1,
		mgl_prim1.width_byteena_b = 1,
		mgl_prim1.width_eccstatus = 3,
		mgl_prim1.widthad_a = 16,
		mgl_prim1.widthad_b = 1;
	assign
		q_a = wire_mgl_prim1_q_a;
endmodule //mg3p21
//VALID FILE
