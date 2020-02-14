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
*				ForwardKinematics.sv
*				Jacobian.sv
*				JacobianInverse.sv
*				MatMult.sv
*
*	NOTE: For simulation, the MultiplierFP file needs
*			the library to be specified via 
*			-L 220model -L lpm_ver -L altera_mf_ver
*
***************************************************/
module scara_controller(input signed [13:0] 	x_target, // X value to go to (either abs. or rel.)
								input	signed [13:0]	y_target, // Y value to go to 		""
								input logic  [4:0]	control_state_reg, // State register input
								input signed [7:0]	th1, // Angle of the first joint: May be an internal variable
								input signed [7:0]	th2, // Angle of the second joint: may be an internal variable
								input logic 			clk, // INput clock
								input logic 			reset, // Reset pin. Resets state machine to init state (waiting)
								output	logic	[63:0] m1_steps, // Outputs number of steps
								output	logic [63:0] m2_steps,
								output 	logic dir1,
								output	logic dir2);

	
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

	
	typedef enum logic [2:0] {FK, J, JI, MULT, CONV, INIT} compute_state;
	compute_state next_state;
	compute_state state;
	
	initial begin
//		state 		= 	FK;
//		next_state 	= 	J;
		
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
		if(reset) begin
			state <= INIT;
		end
		
		
		if(state == INIT) begin
		// Init state
			if(control_state_reg[0]) next_state <= FK;
			else next_state <= INIT;
		end
		
		else if(state == FK) begin
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
	
	logic [63:0] dx_dth1, dx_dth2, dy_dth1, dy_dth2;
	
	Jacobian jk (
						.reset(JReset),
						.enable(JEnable),
						.clk(clk),
						.l1(l1_inch),
						.l2(l2_inch),
						.data_ready(JDone),
						.dx_dth1(dx_dth1),
						.dx_dth2(dx_dth2),
						.dy_dth1(dy_dth1),
						.dy_dth2(dy_dth2)
					);
					
	logic [63:0] aInv, bInv, cInv, dInv;

	JacobianInverse ji (
							.reset(JIReset),
							.enable(JIEnable),
							.clk(clk),
							.a(dx_dth1),
							.b(dx_dth2),
							.c(dy_dth1),
							.d(dy_dth2),
							.aOut(aInv),
							.bOut_n(bInv),
							.cOut_n(CInv),
							.dOut(dInv),
							.data_ready(JIDone)
						);
	
	
	/** Change in X and Y logic **/
	// We need to convert our current
	// Location to a value that is 
	// Conducive to our logic.
	
	reg signed [13:0] xInt, yInt;
	
	DoubleTo14BitInt x_curr(.dataa(x_current),
									.clk_en(JIEnable),
									.clock(clk),
									.result(xInt)
									);
									
									
	DoubleTo14BitInt y_curr(.dataa(y_current),
									.clk_en(JIEnable),
									.clock(clk),
									.result(yInt)
									);
	
	reg signed [13:0] dx, dy;
	
	always_comb
	begin
		if(control_state_reg[2])begin
		// Relative position
			dx <= x_target;
			dy <= y_target;
		end
		else begin
		// Absolute position
			dx <= x_target - xInt;
			dy <= y_target - yInt;
		end
	end
	
	logic [63:0] changeTh1, changeTh2;
						
	MatMult multiply (
						.reset(MULTReset),
						.enable(MULTEnable),
						.clk(clk),
						.invA(aInv),
						.invB(bInv),
						.invC(cInv),
						.invD(dInv),
						.dx(dx),
						.dy(dy),
						.dth1(changeTh1),
						.dth2(changeTh2),
						.data_ready(MULTDone)
						);
						
	DegToSteps d2s (
						.reset(CONVReset),
						.en(CONVEnable),
						.clk(clk),
						.dth1(changeTh1),
						.dth2(changeTh2),
						.dir1(dir1),
						.steps1(m1_steps),
						.dir2(dir2),
						.steps2(m2_steps),
						.data_ready(CONVDone)
						);
		
endmodule
