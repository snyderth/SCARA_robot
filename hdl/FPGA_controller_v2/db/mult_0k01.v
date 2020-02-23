//lpm_mult CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEDICATED_MULTIPLIER_CIRCUITRY="NO" DEVICE_FAMILY="Cyclone V" DSP_BLOCK_BALANCING="Auto" INPUT_A_IS_CONSTANT="NO" INPUT_B_IS_CONSTANT="NO" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTHA=5 LPM_WIDTHB=18 LPM_WIDTHP=23 LPM_WIDTHS=1 MAXIMIZE_SPEED=5 dataa datab result CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48
//VERSION_BEGIN 18.1 cbx_cycloneii 2018:09:12:13:04:24:SJ cbx_lpm_add_sub 2018:09:12:13:04:24:SJ cbx_lpm_mult 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ cbx_nadder 2018:09:12:13:04:24:SJ cbx_padd 2018:09:12:13:04:24:SJ cbx_stratix 2018:09:12:13:04:24:SJ cbx_stratixii 2018:09:12:13:04:24:SJ cbx_util_mgl 2018:09:12:13:04:24:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2018  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details.




//adder CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone V" WIDTH=22 dataa datab datac result
//VERSION_BEGIN 18.1 cbx_mgl 2018:09:12:13:10:36:SJ cbx_stratixii 2018:09:12:13:04:24:SJ cbx_util_mgl 2018:09:12:13:04:24:SJ  VERSION_END


//lpm_add_sub CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48 CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone V" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=19 dataa datab result
//VERSION_BEGIN 18.1 cbx_cycloneii 2018:09:12:13:04:24:SJ cbx_lpm_add_sub 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ cbx_nadder 2018:09:12:13:04:24:SJ cbx_stratix 2018:09:12:13:04:24:SJ cbx_stratixii 2018:09:12:13:04:24:SJ  VERSION_END


//lpm_add_sub CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48 CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" DEVICE_FAMILY="Cyclone V" LPM_REPRESENTATION="UNSIGNED" LPM_WIDTH=19 dataa datab result
//VERSION_BEGIN 18.1 cbx_cycloneii 2018:09:12:13:04:24:SJ cbx_lpm_add_sub 2018:09:12:13:04:24:SJ cbx_mgl 2018:09:12:13:10:36:SJ cbx_nadder 2018:09:12:13:04:24:SJ cbx_stratix 2018:09:12:13:04:24:SJ cbx_stratixii 2018:09:12:13:04:24:SJ  VERSION_END

//synthesis_resources = lut 82 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  mult_0k01
	( 
	dataa,
	datab,
	result) /* synthesis synthesis_clearbox=1 */;
	input   [4:0]  dataa;
	input   [17:0]  datab;
	output   [22:0]  result;

	wire	[21:0]	wire_add2_result;
	wire	[18:0]	wire_sum_adder1aa_0dataa;
	wire	[18:0]	wire_sum_adder1aa_0datab;
	wire	[18:0]	wire_sum_adder1aa_0result;
	wire	[18:0]	wire_sum_adder1aa_1dataa;
	wire	[18:0]	wire_sum_adder1aa_1datab;
	wire	[18:0]	wire_sum_adder1aa_1result;
	wire  [21:0]   wire_sft3a_in;
	wire  [21:0]   wire_sft3a_out;
	wire  [21:0]   wire_sft4a_in;
	wire  [21:0]   wire_sft4a_out;
	wire  [21:0]   wire_sft5a_in;
	wire  [21:0]   wire_sft5a_out;
	wire  [21:0]   wire_sft6a_in;
	wire  [21:0]   wire_sft6a_out;
	wire  [17:0]  dataa_node;
	wire  [4:0]  datab_node;
	wire  [22:0]  final_result_node;
	wire  w147w;
	wire  [23:0]  w237w;
	wire  [89:0]  w_decoder_node9w;
	wire  [4:0]  w_le_datab_node8w;
	wire  [17:0]  w_lone_sum_node11w;
	wire  [39:0]  w_sum_node10w;

	assign
		wire_add2_result = wire_sft3a_out + wire_sft4a_out + wire_sft5a_out;
	assign
		wire_sum_adder1aa_0result = wire_sum_adder1aa_0dataa + wire_sum_adder1aa_0datab;
	assign
		wire_sum_adder1aa_0dataa = {1'b0, w_decoder_node9w[35:18]},
		wire_sum_adder1aa_0datab = {{2{1'b0}}, w_decoder_node9w[17:1]};
	assign
		wire_sum_adder1aa_1result = wire_sum_adder1aa_1dataa + wire_sum_adder1aa_1datab;
	assign
		wire_sum_adder1aa_1dataa = {1'b0, w_decoder_node9w[71:54]},
		wire_sum_adder1aa_1datab = {{2{1'b0}}, w_decoder_node9w[53:37]};
	soft   sft3a_0
	( 
	.in(wire_sft3a_in[0:0]),
	.out(wire_sft3a_out[0:0]));
	soft   sft3a_1
	( 
	.in(wire_sft3a_in[1:1]),
	.out(wire_sft3a_out[1:1]));
	soft   sft3a_2
	( 
	.in(wire_sft3a_in[2:2]),
	.out(wire_sft3a_out[2:2]));
	soft   sft3a_3
	( 
	.in(wire_sft3a_in[3:3]),
	.out(wire_sft3a_out[3:3]));
	soft   sft3a_4
	( 
	.in(wire_sft3a_in[4:4]),
	.out(wire_sft3a_out[4:4]));
	soft   sft3a_5
	( 
	.in(wire_sft3a_in[5:5]),
	.out(wire_sft3a_out[5:5]));
	soft   sft3a_6
	( 
	.in(wire_sft3a_in[6:6]),
	.out(wire_sft3a_out[6:6]));
	soft   sft3a_7
	( 
	.in(wire_sft3a_in[7:7]),
	.out(wire_sft3a_out[7:7]));
	soft   sft3a_8
	( 
	.in(wire_sft3a_in[8:8]),
	.out(wire_sft3a_out[8:8]));
	soft   sft3a_9
	( 
	.in(wire_sft3a_in[9:9]),
	.out(wire_sft3a_out[9:9]));
	soft   sft3a_10
	( 
	.in(wire_sft3a_in[10:10]),
	.out(wire_sft3a_out[10:10]));
	soft   sft3a_11
	( 
	.in(wire_sft3a_in[11:11]),
	.out(wire_sft3a_out[11:11]));
	soft   sft3a_12
	( 
	.in(wire_sft3a_in[12:12]),
	.out(wire_sft3a_out[12:12]));
	soft   sft3a_13
	( 
	.in(wire_sft3a_in[13:13]),
	.out(wire_sft3a_out[13:13]));
	soft   sft3a_14
	( 
	.in(wire_sft3a_in[14:14]),
	.out(wire_sft3a_out[14:14]));
	soft   sft3a_15
	( 
	.in(wire_sft3a_in[15:15]),
	.out(wire_sft3a_out[15:15]));
	soft   sft3a_16
	( 
	.in(wire_sft3a_in[16:16]),
	.out(wire_sft3a_out[16:16]));
	soft   sft3a_17
	( 
	.in(wire_sft3a_in[17:17]),
	.out(wire_sft3a_out[17:17]));
	soft   sft3a_18
	( 
	.in(wire_sft3a_in[18:18]),
	.out(wire_sft3a_out[18:18]));
	soft   sft3a_19
	( 
	.in(wire_sft3a_in[19:19]),
	.out(wire_sft3a_out[19:19]));
	soft   sft3a_20
	( 
	.in(wire_sft3a_in[20:20]),
	.out(wire_sft3a_out[20:20]));
	soft   sft3a_21
	( 
	.in(wire_sft3a_in[21:21]),
	.out(wire_sft3a_out[21:21]));
	assign
		wire_sft3a_in = {w147w, {w147w, {w_sum_node10w[39], {w_sum_node10w[38], {w_sum_node10w[19], {w_sum_node10w[18], {w_sum_node10w[17], {w_sum_node10w[16], {w_sum_node10w[15], {w_sum_node10w[14], {w_sum_node10w[13], {w_sum_node10w[12], {w_sum_node10w[11], {w_sum_node10w[10], {w_sum_node10w[9], {w_sum_node10w[8], {w_sum_node10w[7], {w_sum_node10w[6], {w_sum_node10w[5], {w_sum_node10w[4], {w_sum_node10w[3:2]}}}}}}}}}}}}}}}}}}}}};
	soft   sft4a_0
	( 
	.in(wire_sft4a_in[0:0]),
	.out(wire_sft4a_out[0:0]));
	soft   sft4a_1
	( 
	.in(wire_sft4a_in[1:1]),
	.out(wire_sft4a_out[1:1]));
	soft   sft4a_2
	( 
	.in(wire_sft4a_in[2:2]),
	.out(wire_sft4a_out[2:2]));
	soft   sft4a_3
	( 
	.in(wire_sft4a_in[3:3]),
	.out(wire_sft4a_out[3:3]));
	soft   sft4a_4
	( 
	.in(wire_sft4a_in[4:4]),
	.out(wire_sft4a_out[4:4]));
	soft   sft4a_5
	( 
	.in(wire_sft4a_in[5:5]),
	.out(wire_sft4a_out[5:5]));
	soft   sft4a_6
	( 
	.in(wire_sft4a_in[6:6]),
	.out(wire_sft4a_out[6:6]));
	soft   sft4a_7
	( 
	.in(wire_sft4a_in[7:7]),
	.out(wire_sft4a_out[7:7]));
	soft   sft4a_8
	( 
	.in(wire_sft4a_in[8:8]),
	.out(wire_sft4a_out[8:8]));
	soft   sft4a_9
	( 
	.in(wire_sft4a_in[9:9]),
	.out(wire_sft4a_out[9:9]));
	soft   sft4a_10
	( 
	.in(wire_sft4a_in[10:10]),
	.out(wire_sft4a_out[10:10]));
	soft   sft4a_11
	( 
	.in(wire_sft4a_in[11:11]),
	.out(wire_sft4a_out[11:11]));
	soft   sft4a_12
	( 
	.in(wire_sft4a_in[12:12]),
	.out(wire_sft4a_out[12:12]));
	soft   sft4a_13
	( 
	.in(wire_sft4a_in[13:13]),
	.out(wire_sft4a_out[13:13]));
	soft   sft4a_14
	( 
	.in(wire_sft4a_in[14:14]),
	.out(wire_sft4a_out[14:14]));
	soft   sft4a_15
	( 
	.in(wire_sft4a_in[15:15]),
	.out(wire_sft4a_out[15:15]));
	soft   sft4a_16
	( 
	.in(wire_sft4a_in[16:16]),
	.out(wire_sft4a_out[16:16]));
	soft   sft4a_17
	( 
	.in(wire_sft4a_in[17:17]),
	.out(wire_sft4a_out[17:17]));
	soft   sft4a_18
	( 
	.in(wire_sft4a_in[18:18]),
	.out(wire_sft4a_out[18:18]));
	soft   sft4a_19
	( 
	.in(wire_sft4a_in[19:19]),
	.out(wire_sft4a_out[19:19]));
	soft   sft4a_20
	( 
	.in(wire_sft4a_in[20:20]),
	.out(wire_sft4a_out[20:20]));
	soft   sft4a_21
	( 
	.in(wire_sft4a_in[21:21]),
	.out(wire_sft4a_out[21:21]));
	assign
		wire_sft4a_in = {w147w, {w147w, {w_lone_sum_node11w[17], {w_lone_sum_node11w[16], {w_sum_node10w[37], {w_sum_node10w[36], {w_sum_node10w[35], {w_sum_node10w[34], {w_sum_node10w[33], {w_sum_node10w[32], {w_sum_node10w[31], {w_sum_node10w[30], {w_sum_node10w[29], {w_sum_node10w[28], {w_sum_node10w[27], {w_sum_node10w[26], {w_sum_node10w[25], {w_sum_node10w[24], {w_sum_node10w[23], {w_sum_node10w[22], {w_sum_node10w[21:20]}}}}}}}}}}}}}}}}}}}}};
	soft   sft5a_0
	( 
	.in(wire_sft5a_in[0:0]),
	.out(wire_sft5a_out[0:0]));
	soft   sft5a_1
	( 
	.in(wire_sft5a_in[1:1]),
	.out(wire_sft5a_out[1:1]));
	soft   sft5a_2
	( 
	.in(wire_sft5a_in[2:2]),
	.out(wire_sft5a_out[2:2]));
	soft   sft5a_3
	( 
	.in(wire_sft5a_in[3:3]),
	.out(wire_sft5a_out[3:3]));
	soft   sft5a_4
	( 
	.in(wire_sft5a_in[4:4]),
	.out(wire_sft5a_out[4:4]));
	soft   sft5a_5
	( 
	.in(wire_sft5a_in[5:5]),
	.out(wire_sft5a_out[5:5]));
	soft   sft5a_6
	( 
	.in(wire_sft5a_in[6:6]),
	.out(wire_sft5a_out[6:6]));
	soft   sft5a_7
	( 
	.in(wire_sft5a_in[7:7]),
	.out(wire_sft5a_out[7:7]));
	soft   sft5a_8
	( 
	.in(wire_sft5a_in[8:8]),
	.out(wire_sft5a_out[8:8]));
	soft   sft5a_9
	( 
	.in(wire_sft5a_in[9:9]),
	.out(wire_sft5a_out[9:9]));
	soft   sft5a_10
	( 
	.in(wire_sft5a_in[10:10]),
	.out(wire_sft5a_out[10:10]));
	soft   sft5a_11
	( 
	.in(wire_sft5a_in[11:11]),
	.out(wire_sft5a_out[11:11]));
	soft   sft5a_12
	( 
	.in(wire_sft5a_in[12:12]),
	.out(wire_sft5a_out[12:12]));
	soft   sft5a_13
	( 
	.in(wire_sft5a_in[13:13]),
	.out(wire_sft5a_out[13:13]));
	soft   sft5a_14
	( 
	.in(wire_sft5a_in[14:14]),
	.out(wire_sft5a_out[14:14]));
	soft   sft5a_15
	( 
	.in(wire_sft5a_in[15:15]),
	.out(wire_sft5a_out[15:15]));
	soft   sft5a_16
	( 
	.in(wire_sft5a_in[16:16]),
	.out(wire_sft5a_out[16:16]));
	soft   sft5a_17
	( 
	.in(wire_sft5a_in[17:17]),
	.out(wire_sft5a_out[17:17]));
	soft   sft5a_18
	( 
	.in(wire_sft5a_in[18:18]),
	.out(wire_sft5a_out[18:18]));
	soft   sft5a_19
	( 
	.in(wire_sft5a_in[19:19]),
	.out(wire_sft5a_out[19:19]));
	soft   sft5a_20
	( 
	.in(wire_sft5a_in[20:20]),
	.out(wire_sft5a_out[20:20]));
	soft   sft5a_21
	( 
	.in(wire_sft5a_in[21:21]),
	.out(wire_sft5a_out[21:21]));
	assign
		wire_sft5a_in = {w147w, {w147w, {w147w, {w147w, {w_lone_sum_node11w[15], {w_lone_sum_node11w[14], {w_lone_sum_node11w[13], {w_lone_sum_node11w[12], {w_lone_sum_node11w[11], {w_lone_sum_node11w[10], {w_lone_sum_node11w[9], {w_lone_sum_node11w[8], {w_lone_sum_node11w[7], {w_lone_sum_node11w[6], {w_lone_sum_node11w[5], {w_lone_sum_node11w[4], {w_lone_sum_node11w[3], {w_lone_sum_node11w[2], {w_lone_sum_node11w[1], {w_lone_sum_node11w[0], {2{w147w}}}}}}}}}}}}}}}}}}}}}};
	soft   sft6a_0
	( 
	.in(wire_sft6a_in[0:0]),
	.out(wire_sft6a_out[0:0]));
	soft   sft6a_1
	( 
	.in(wire_sft6a_in[1:1]),
	.out(wire_sft6a_out[1:1]));
	soft   sft6a_2
	( 
	.in(wire_sft6a_in[2:2]),
	.out(wire_sft6a_out[2:2]));
	soft   sft6a_3
	( 
	.in(wire_sft6a_in[3:3]),
	.out(wire_sft6a_out[3:3]));
	soft   sft6a_4
	( 
	.in(wire_sft6a_in[4:4]),
	.out(wire_sft6a_out[4:4]));
	soft   sft6a_5
	( 
	.in(wire_sft6a_in[5:5]),
	.out(wire_sft6a_out[5:5]));
	soft   sft6a_6
	( 
	.in(wire_sft6a_in[6:6]),
	.out(wire_sft6a_out[6:6]));
	soft   sft6a_7
	( 
	.in(wire_sft6a_in[7:7]),
	.out(wire_sft6a_out[7:7]));
	soft   sft6a_8
	( 
	.in(wire_sft6a_in[8:8]),
	.out(wire_sft6a_out[8:8]));
	soft   sft6a_9
	( 
	.in(wire_sft6a_in[9:9]),
	.out(wire_sft6a_out[9:9]));
	soft   sft6a_10
	( 
	.in(wire_sft6a_in[10:10]),
	.out(wire_sft6a_out[10:10]));
	soft   sft6a_11
	( 
	.in(wire_sft6a_in[11:11]),
	.out(wire_sft6a_out[11:11]));
	soft   sft6a_12
	( 
	.in(wire_sft6a_in[12:12]),
	.out(wire_sft6a_out[12:12]));
	soft   sft6a_13
	( 
	.in(wire_sft6a_in[13:13]),
	.out(wire_sft6a_out[13:13]));
	soft   sft6a_14
	( 
	.in(wire_sft6a_in[14:14]),
	.out(wire_sft6a_out[14:14]));
	soft   sft6a_15
	( 
	.in(wire_sft6a_in[15:15]),
	.out(wire_sft6a_out[15:15]));
	soft   sft6a_16
	( 
	.in(wire_sft6a_in[16:16]),
	.out(wire_sft6a_out[16:16]));
	soft   sft6a_17
	( 
	.in(wire_sft6a_in[17:17]),
	.out(wire_sft6a_out[17:17]));
	soft   sft6a_18
	( 
	.in(wire_sft6a_in[18:18]),
	.out(wire_sft6a_out[18:18]));
	soft   sft6a_19
	( 
	.in(wire_sft6a_in[19:19]),
	.out(wire_sft6a_out[19:19]));
	soft   sft6a_20
	( 
	.in(wire_sft6a_in[20:20]),
	.out(wire_sft6a_out[20:20]));
	soft   sft6a_21
	( 
	.in(wire_sft6a_in[21:21]),
	.out(wire_sft6a_out[21:21]));
	assign
		wire_sft6a_in = wire_add2_result;
	assign
		dataa_node = {datab[17:0]},
		datab_node = {dataa[4:0]},
		final_result_node = {w237w[22:0]},
		result = {final_result_node[22:0]},
		w147w = 1'b0,
		w237w = {wire_sft6a_out[21:20], wire_sft6a_out[19:18], wire_sft6a_out[17:16], wire_sft6a_out[15:14], wire_sft6a_out[13:12], wire_sft6a_out[11:10], wire_sft6a_out[9:8], wire_sft6a_out[7:6], wire_sft6a_out[5:4], wire_sft6a_out[3:2], wire_sft6a_out[1:0], w_sum_node10w[1], w_sum_node10w[0]},
		w_decoder_node9w = {({dataa_node[17:0]} & {18{w_le_datab_node8w[4]}}), ({dataa_node[17:0]} & {18{w_le_datab_node8w[3]}}), ({dataa_node[17:0]} & {18{w_le_datab_node8w[2]}}), ({dataa_node[17:0]} & {18{w_le_datab_node8w[1]}}), ({dataa_node[17:0]} & {18{w_le_datab_node8w[0]}})},
		w_le_datab_node8w = {datab_node[4:0]},
		w_lone_sum_node11w = {w_decoder_node9w[89:72]},
		w_sum_node10w = {wire_sum_adder1aa_1result[18:0], w_decoder_node9w[36], wire_sum_adder1aa_0result[18:0], w_decoder_node9w[0]};
endmodule //mult_0k01
//VALID FILE
