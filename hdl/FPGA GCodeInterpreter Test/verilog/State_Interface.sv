
module Controller_Interface(
	input command command_in,
	input logic memory_ready,
	input logic controller_ready,
	output logic controller_interface_in_ready,
	output logic controller_interface_out_ready,
	output logic [4:0] controller_state_reg,
	output logic [13:0] x_value,
	output logic [13:0] y_value

);

enum {G00, G01, G20, G21, G90, G91, M2, M6, M72} Command_Code;

assign send_new_data = memory_ready & controller_ready;

wire linear;
wire inches;
wire absolute;
wire raise_tool;
wire tool_change;

assign controller_state_reg = {tool_change, raise_tool, absolute, inches, linear};

//The controller has new information when the memory does
assign controller_interface_out_ready = memory_ready;

//The controller is ready for new information when the controller is ready
assign controller_interface_in_ready = controller_ready;


always @(posedge send_new_data) 
begin	
	case (command_in.cmd)
		G00:
			begin
				linear <= 0; //Nonlinear move
				tool_change <= 0;
				raise_tool <= 0;
				x_value <= command_in.x_value;
				y_value <= command_in.y_value;
			end
		G01: 			
			begin
				linear <= 1; //Linear move
				tool_change <= 0;
				raise_tool <= 0;
				x_value <= command_in.x_value;
				y_value <= command_in.y_value;
			end
		G20: inches <= 1; //Set Inches
		G21: inches <= 0; //Set millimeters
		G90: absolute <= 1;	
		G91: absolute <= 0;
		M2: // Should not recive
		M6: 
			begin
				tool_change <= 1;
				x_value <= command_in.x_value;
			end
		
		M72: raise_tool <= 1;
	endcase
			
end

endmodule