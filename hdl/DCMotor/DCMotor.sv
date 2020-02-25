module DCMotor(
			input logic clk_50,
			input logic reset_n,
			input logic enable,
			input logic [15:0] duty,
			input logic set_pen, // 0 = up, 1 = down
			input logic limit_switch, // 0 = down, 1 = up
			input logic fault_n,
			output logic pen_status, // 0 = up, 1 = down
			output logic pwm,
			output logic dir,
			output logic brake
			);
	
	logic [15:0] clock_c;
	logic [15:0] clock_cutoff;
	logic [15:0] pwm_c;
	logic reset_clock_n;
	logic reset_pwm_n;
	logic done;
	
	
	assign clock_cutoff = 50000;
	assign reset_clock_n = !((clock_c >= clock_cutoff)|(!reset_n));
	assign reset_pwm_n = !((pwm_c == 255)|(!reset_n));
	assign done = (pen_status == set_pen);
	
	
	assign pen_status = !limit_switch;
	assign brake = 1;
	assign dir = set_pen;
	assign pwm = ((pwm_c > duty) & !done);
			
	dc_cnt #(16) clock_count(
		.clk(clk_50),
		.reset_n(reset_clock_n),
		.en(enable),
		.q(clock_c));
		
	dc_cnt #(8) pwm_count(
		.clk(clk_50),
		.reset_n(reset_pwm_n),
		.en(enable),
		.q(pwm_c));
		
endmodule
