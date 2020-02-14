/***************************************************
*	File: 		ScaraController
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Implementation of Jacobian Inverse 
*					control algorithm
*	Parameters:
*				None
*
*	Dependencies:
*				SRLatch.sv
*				MultiplierFP.v
*				ClockTimer.sv
*				DoubleAdder.sv
*				DoubleMultiplier.sv
*				Adder.v
*				IntToDouble.v
*				
*
*	NOTE: For simulation, the MultiplierFP file needs
*			the library to be specified via 
*			-L <path_to_model220-lib>
*
***************************************************/
module scara_controller(input signed [13:0] 	x_target, // X value to go to (either abs. or rel.)
								input	signed [13:0]	y_target, // Y value to go to 		""
								input logic  [4:0]	control_state_reg, // State register input
								input signed [7:0]	th1, // Angle of the first joint: May be an internal variable
								input signed [7:0]	th2, // Angle of the second joint: may be an internal variable
								input logic 			clk, // INput clock
								input logic 			reset, // Reset pin. Resets state machine to init state (waiting)
								output	logic	[8:0] th1_steps, // Outputs number of steps
								output	logic [8:0] th2_steps);

	
	logic [63:0] x_current;
	logic [13:0] y_current;
	
	logic [13:0] l1_inch;
	logic [13:0] l2_inch;
	assign l2_inch = 14'd7447; // Arm length, inches converted to integers
	assign l1_inch = 14'd8936; // Arm length, inches converted to integers
	logic [13:0] l1_mm;
	logic [13:0] l2_mm;
	
	
	/* State variables for each state */
	logic FKEnable, 	FKReset, 	FKdone; 	/* Forward Kinematics 	*/
	logic JEnable, 	JReset, 		JDone;	/* Jacobian 				*/
	logic JIEnable, 	JIReset, 	JIDone;	/* Jacobian Inverse 		*/
	logic MULTEnable, MULTReset, 	MULTDone;/* Multiply Out			*/
	logic CONVEnable, CONVReset, 	CONVDone;/* Convert Result			*/

	
	typedef enum logic [2:0] {FK, J, JI, MULT, CONV} compute_state;
	compute_state next_state;
	compute_state state;
	
	initial begin
		state 		= 	FK;
		next_state 	= 	J;
		
		FKReset 		= 	1'b1;
		FKEnable 	= 	1'b0;
		FKdone 		= 	1'b0;
		
		JDone 		= 	1'b0;
		JReset 		= 	1'b1;
		JEnable		= 	1'b0;
		
		JIDone 		= 	1'b0;
		JIEnable 	= 	1'b0;
		JIReset 		=	1'b1;
		
		MULTDone 	= 	1'b0;
		MULTReset 	= 	1'b1;
		MULTEnable 	= 	1'b0;
	end
	
	
	/* State Transition Logic */
	
	// Initialize the arm to the current location
	always_ff@(posedge clk) begin
		state <= next_state;
		if(state == FK) begin
			// Forward Kinematics
			if(FKdone) begin
			// Transition to jacobian state
				FKReset <= 1;
				FKEnable <= 0;
				next_state <= J;
			end
			else begin
			// start/contine FK state
				FKEnable <= 1;
				FKReset <= 0;
				next_state <= FK;
			end
		end
		else if(state == J) begin
		// Jacobian
			if(JDone) begin
			// Transition to jac inv
				JEnable <= 0;
				JReset <= 1;
				next_state <= JI;
			end
			else begin
			// Start/continue jacobian state
				JEnable <= 1;
				JReset <= 0;
				next_state <= J;
			end
		end
		else if(state == JI) begin
		// Inverting Jacobian
			if(JIDone) begin
			// Transition to Multiply out state
				JIEnable <= 0;
				JIReset <= 1;
				next_state <= MULT;
			end
			else begin
			// Starting/continue JI state
				JIEnable <= 1;
				JIReset <= 0;
				next_state <= JI;
			end
		end
		else if(state == MULT) begin
		// Multiply out state
			if(MULTDone) begin
			//transition to conversion state
				MULTEnable <= 0;
				MULTReset <= 1;
				next_state <= CONV;
			end
			else begin
			// Begin/continue MULT state
				MULTEnable <= 1;
				MULTReset <= 0;
				next_state <= MULT;
			end
		end
		else if(state == CONV) begin
		// Convert degrees to steps
			if(CONVDone) begin
			//Transition to (either sum or FK)
				CONVEnable <= 0;
				CONVReset <= 1;
				next_state <= FK;
			end
			else begin
			// Continue/begin convert
				CONVEnable <= 1;
				CONVReset <= 0;
				next_state <= CONV;
			end
		end
		
	end
	
	
	/* State Logic */
	
	ForwardKinematics fk (
								.reset(FKReset),
								.enable(FKEnable),
								.th1(th1),
								.th2(th2),
								.l1(l1_inch),
								.l2(l2_inch),
								.clk(clk),
								.x(x_current),
								.y(y_current),
								.data_ready(FKdone)
								);
								
	Jacobian jk (
						.reset(JReset),
						.enable(JEnable),
						.clk(clk),
						.l1(l1_inch),
						.l2(l2_inch),
						.data_ready(JDone),
						.dx_dth1(),
						.dx_dth2(),
						.dy_dth1(),
						.dy_dth2()
					);

		
		
endmodule
