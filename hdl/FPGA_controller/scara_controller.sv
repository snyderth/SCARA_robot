module scara_controller(input logic [13:0] 	x_target,
								input	logic	[13:0]	y_target,
								input logic [4:0]		control_state_reg,
								input signed [7:0]	th1,
								input signed [7:0]	th2,
								input logic 			clk,
								input logic 			reset,
								output	logic	[13:0] th1_steps,
								output	logic [13:0] th2_steps);

	
	logic [63:0] x_current;
	logic [13:0] y_current;
	
	logic [13:0] l1_inch;
	logic [13:0] l2_inch;
	assign l2_inch = 7447; // Arm length, inches converted to integers
	assign l1_inch = 8936; // Arm length, inches converted to integers
	logic [13:0] l1_mm;
	logic [13:0] l2_mm;
	
	
	typedef enum logic [2:0] {FK, J, JI, MULT, CONV} compute_state;
	compute_state next_state;
	compute_state state;
	
	assign state = FK;
	assign next_state = J;
	
	// Initialize the arm to the current location
	always_ff@(posedge clk)
		if(state == FK) begin
			
		
		end
	
	
	ForwardKinematics x (
								.th1(th1),
								.th2(th2),
								.l1(l1_inch),
								.l2(l2_inch),
								.clk(clk),
								.pos(x_current)
								);

		
		
endmodule
