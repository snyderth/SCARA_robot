module Testbench (input [3:0] cmd,
	input [13:0] x_value,
	input [13:0] y_value,
	input memory_ready,
	input initEnable,
	input CLOCK_50,
	output [31:0] GPIO_0	
);

wire [13:0] ci2c_x_value;
wire [13:0] ci2c_y_value;
wire [4:0] ci2c_controller_state_reg;
wire c2ci_controller_ready;
wire controller_interface_out_ready;
wire controller_interface_in_ready;

Controller_Interface controller_interface (
	.clk(CLOCK_50),
	.block(~initEnable),
	.cmd(cmd),
	.x_value_in(x_value),
	.y_value_in(y_value),
	.memory_ready(memory_ready),
	.controller_ready(c2ci_controller_ready),
	.controller_interface_in_ready(controller_interface_in_ready),
	.controller_interface_out_ready(controller_interface_out_ready),
	.controller_state_reg(ci2c_controller_state_reg),
	.x_value(ci2c_x_value),
	.y_value(ci2c_y_value)


);

//TODO: this sucks. Make this an interface or something.
wire c2sm1_steps1;
wire c2sm1_dir1;
wire c2sm1_endEffectorState;
wire c2smALL_dataReady;

wire sm12c2_stepperReady;
wire sm22c2_stepperReady;
wire steppersReady;

assign steppersReady = sm12c2_stepperReady & sm22c2_stepperReady;

wire c2sm2_steps2;
wire c2sm2_dir2;

ScaraController controller (
	.controlStateReg(ci2c_controller_state_reg),
	.xTarget(ci2c_x_value),
	.yTarget(c12c_y_value),
	.stepperReady(steppersReady),	//TODO: Connect
	.enable(controller_interface_out_ready),
	.clk(CLOCK_50),
	.reset(~initEnable),
	.steps1(c2sm1_steps1), //TODO: Connect
	.steps2(c2sm2_steps2), //TODO: Connect
	.dir1(c2sm1_dir1), //TODO: Connect
	.dir2(c2sm2_dir2), //TODO: Connect
	.endEffectorState(), //TODO: Connect
	.dataReady(c2smALL_dataReady), //TODO: Connect
	.readyForNewData(c2ci_controller_ready)
);



stepper_motor joint1(
	.clk_50(CLOCK50),
	.reset_n(~initEnable),
	.new_in(c2smALL_dataReady),
	.num_steps(c2sm2_steps2),
	.fast(0),
	.direction(c2sm2_dir2),
	.enable(1),
	.step(GPIO_0[7]), //STEP1
	.dir(GPIO_0[9]), //DIR1
	.finished(sm22c2_stepperReady)
);
stepper_motor joint2(
	.clk_50(CLOCK50),
	.reset_n(~initEnable),
	.new_in(c2smALL_dataReady),
	.num_steps(c2sm2_steps2),
	.fast(0),
	.direction(c2sm2_dir2),
	.enable(1),
	.step(GPIO_0[13]), //STEP2
	.dir(GPIO_0[15]), //DIR2
	.finished(sm22c2_stepperReady)
);

endmodule