

module Controller_Interface(
	input logic clk,
	input logic block,
   	input logic [3:0] cmd,
	input logic [13:0] x_value_in,
	input logic [13:0] y_value_in,
	input logic memory_ready,
	input logic controller_ready,
	output logic controller_interface_in_ready,
	output logic controller_interface_out_ready,
	output logic [4:0] controller_state_reg,
	output logic [13:0] x_value,
	output logic [13:0] y_value

);

enum {G00, G01, G20, G21, G90, G91, M2, M6, M72} Command_Code;

//assign send_new_data = memory_ready & controller_ready & ~block;

reg linear;
reg inches;
reg absolute;
reg raise_tool;
reg tool_change;


assign controller_state_reg = {tool_change, raise_tool, absolute, inches, linear};

//The controller has new information when the memory does
assign controller_interface_out_ready = memory_ready;

//The controller is ready for new information when the controller is ready
assign controller_interface_in_ready = controller_ready;


always_ff @(posedge clk) 
begin	
	if(block) 
	begin
		linear <= 0;
		inches <= 1;
		absolute <= 1;
		raise_tool <= 0;
		tool_change <= 0;
	end
	if(memory_ready & controller_ready & ~block)
	begin
		case (cmd)
			G00:
				begin
					linear <= 0; //Nonlinear move
					tool_change <= 0;
					raise_tool <= 0;
					x_value <= x_value_in;
					y_value <= y_value_in;
				end
			G01: 			
				begin
					linear <= 1; //Linear move
					tool_change <= 0;
					raise_tool <= 0;
					x_value <= x_value_in;
					y_value <= y_value_in;
				end
			G20: inches <= 1; //Set Inches
			G21: inches <= 0; //Set millimeters
			G90: absolute <= 1;	
			G91: absolute <= 0;
			M6: 
				begin
					tool_change <= 1;
					x_value <= x_value_in;
				end
			
			M72: raise_tool <= 1;
		endcase
	end
			
end

endmodule