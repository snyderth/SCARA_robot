module Fake_Controller(
	output logic controller_ready,
	input logic set_ready,
	input logic controller_interface_out_ready,
	input logic [4:0] cmd,
	input logic [13:0] x_value,
	input logic [13:0] y_value,
	output logic [3:0] cmd_word_1,
	output logic [3:0] cmd_word_2,
	output logic [3:0] x_value_word_1,
	output logic [3:0] x_value_word_2,
	output logic [3:0] y_value_word_1,
	output logic [3:0] y_value_word_2
);

	
	always@(posedge set_ready)
	begin
		controller_ready <= 1;
	end
	
	assign begin_command = controller_interface_out_ready & controller_ready;
	
	always@(posedge begin_command) 
	begin
		controller_ready <= 0;
		
		cmd_word_1 <= cmd[3:0];
		cmd_word_2[0] <= cmd[4:3];
		
		x_value_word_1 <= x_value[3:0];
		x_value_word_2 <= x_value[7:3];
		
		y_value_word_1 <= y_value[3:0];
		y_value_word_2 <= y_value[7:3];
		
	end

endmodule
