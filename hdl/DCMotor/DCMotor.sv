module DCMotor(
			input logic clk_50,
			input logic reset_n,
			input logic enable,
			input logic [7:0] duty,
			input logic set_pen, // 0 = up, 1 = down
			input logic limit_switch, // 0 = down, 1 = up
			input logic fault_n,
			output logic pen_status, // 0 = up, 1 = down
			output logic pwm,
			output logic dir,
			output logic brake
			);
			
			assign pen_status = !limit_switch;