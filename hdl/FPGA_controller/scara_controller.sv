module scara_controller(input logic [13:0] 	x_target,
								input	logic	[13:0]	y_target,
								input logic [4:0]		control_state_reg,
								input logic 			clk,
								input logic 			reset,
								output	logic	[13:0] th1_steps,
								output	logic [13:0] th2_steps);

	// Storing the units state and abs/rel state
	typedef enum logic [1:0] {abs_inch, abs_mm, rel_inch, rel_mm} unit_state;
	typedef enum logic [1:0] {tool_chng, move, wait_init} scara_state;
	
	logic [13:0] l1_inch;
	logic [13:0] l2_inch;
	assign l2_inch = 7447; // Arm length, inches converted to integers
	assign l1_inch = 8936; // Arm length, inches converted to integers
	logic [13:0] l1_mm;
	logic [13:0] l2_mm;
	
	// Initialize the arm to the current location
	
	
	logic state_ready;
	assign state_ready = 0; // Begin with a ready state and only 
									// transition once state is ready
	scara_state [1:0] state, nextstate;
	
	logic [13:0] dx;
	logic [13:0] dy;
	
	// state register: logic within state is executed here
	always@ff(posedge clk, posedge reset)
		if(reset) state <= wait_init;
		else if(state_ready) state <= nextstate;
		
		
	//next state logic
	always_comb
		case(state)
			move:
			
				if(control_state_reg[2])
				begin
					dx = x_target;
					dy = y_target;
				end
				else
				begin
					dx = x_target - x_current;
					dy = y_target - y_current;
				end
				Move(clk, 
		endcase
endmodule
