module scara_controller(input logic [13:0] 	x_pos,
								input	logic	[13:0]	y_pos,
								input logic [4:0]		state_inputs,
								input logic 			clk,
								input logic 			reset,
								output	logic	[13:0] th1_steps,
								output	logic [13:0] th2_steps);

	// Storing the units state and abs/rel state
	typedef enum logic [1:0] {abs_inch, abs_mm, rel_inch, rel_mm} unit_state;
	typedef enum logic [1:0] {tool_chng, move, wait_init} scara_state;
	
	scara_state [1:0] state, nextstate;
	
	// state register: logic within state is executed here
	always@ff(posedge clk, posedge reset)
		if(reset) state <= wait_init;
		else state <= nextstate;
		
		
	//next state logic
	always_comb
		case(state)
			
		endcase
endmodule
