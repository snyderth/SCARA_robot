// megafunction wizard: %ALTFP_CONVERT%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_CONVERT 

// ============================================================
// File Name: DoubleTo14BitInt.v
// Megafunction Name(s):
// 			ALTFP_CONVERT
//
// Simulation Library Files(s):
// 			lpm
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Lite Edition
// ************************************************************

//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.

module DoubleTo14BitInt (
	clk_en,
	clock,
	dataa,
	overflow,
	result,
	underflow)/* synthesis synthesis_clearbox = 1 */;

	input	  clk_en;
	input	  clock;
	input	[63:0]  dataa;
	output	  overflow;
	output	[13:0]  result;
	output	  underflow;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone V"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_convert"
// Retrieval info: CONSTANT: OPERATION STRING "FLOAT2INT"
// Retrieval info: CONSTANT: ROUNDING STRING "TO_NEAREST"
// Retrieval info: CONSTANT: WIDTH_DATA NUMERIC "64"
// Retrieval info: CONSTANT: WIDTH_EXP_INPUT NUMERIC "11"
// Retrieval info: CONSTANT: WIDTH_EXP_OUTPUT NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_INT NUMERIC "14"
// Retrieval info: CONSTANT: WIDTH_MAN_INPUT NUMERIC "52"
// Retrieval info: CONSTANT: WIDTH_MAN_OUTPUT NUMERIC "23"
// Retrieval info: CONSTANT: WIDTH_RESULT NUMERIC "14"
// Retrieval info: USED_PORT: clk_en 0 0 0 0 INPUT NODEFVAL "clk_en"
// Retrieval info: CONNECT: @clk_en 0 0 0 0 clk_en 0 0 0 0
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: USED_PORT: dataa 0 0 64 0 INPUT NODEFVAL "dataa[63..0]"
// Retrieval info: CONNECT: @dataa 0 0 64 0 dataa 0 0 64 0
// Retrieval info: USED_PORT: overflow 0 0 0 0 OUTPUT NODEFVAL "overflow"
// Retrieval info: CONNECT: overflow 0 0 0 0 @overflow 0 0 0 0
// Retrieval info: USED_PORT: result 0 0 14 0 OUTPUT NODEFVAL "result[13..0]"
// Retrieval info: CONNECT: result 0 0 14 0 @result 0 0 14 0
// Retrieval info: USED_PORT: underflow 0 0 0 0 OUTPUT NODEFVAL "underflow"
// Retrieval info: CONNECT: underflow 0 0 0 0 @underflow 0 0 0 0
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt.inc FALSE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL DoubleTo14BitInt.cmp FALSE TRUE
// Retrieval info: LIB_FILE: lpm