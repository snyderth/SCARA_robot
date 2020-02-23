module Fake_Controller(
	input logic clk,
	input logic reset,
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
	reg set_ready_prev;
	always_ff@(posedge clk or posedge reset)
	begin
		if(reset)
		begin
			set_ready_prev <= 0;
			controller_ready <= 0;
		end
		else
		begin
			if(controller_ready && controller_interface_out_ready)
			begin
				controller_ready <= 0;		
				cmd_word_1 <= cmd[3:0];
				cmd_word_2[0] <= cmd[4:4];
			
				x_value_word_1 <= x_value[3:0];
				x_value_word_2 <= x_value[7:4];
			
				y_value_word_1 <= y_value[3:0];
				y_value_word_2 <= y_value[7:4];

			end

			if(set_ready && ~set_ready_prev)
			begin
				controller_ready <= 1;
				set_ready_prev <= 1;
			end
			
			if(~set_ready && set_ready_prev)
			begin
				set_ready_prev <= 0;
			end
		end
		
	end
	

endmodule
