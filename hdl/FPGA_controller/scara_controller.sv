/***************************************************
*	File: 		ScaraController
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Implementation of Jacobian Inverse 
*					control algorithm
*
*				The latency of this block is 138 cycles
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
								input logic  			stepper_ready,
//								input signed [8:0]	th1, // Angle of the first joint: May be an internal variable
//								input signed [8:0]	th2, // Angle of the second joint: may be an internal variable
								input logic 			clk, // INput clock
								input logic 			reset, // Reset pin. Resets state machine to init state (waiting)
								output	logic	[63:0] m1_steps, // Outputs number of steps
								output	logic [63:0] m2_steps,
								output 	logic dir1,
								output	logic dir2,
								output 	logic controller_ready);

	
	reg signed [8:0] th1;
	reg signed [8:0] th2;
	reg signed [8:0] dth1;
	reg signed [8:0] dth2;

	// Local x- y- targets: keep track of absolute position of target
	logic [13:0] x_target_loc;
	logic [13:0] y_target_loc;
	
	// Keep track of when our target has been reached
	logic target_reached;
	
	
	logic [63:0] x_current;
	logic [63:0] y_current;
	
	logic [13:0] l1_inch;
	logic [13:0] l2_inch;
	assign l2_inch = 14'd7447; // Arm length, inches converted to integers
	assign l1_inch = 14'd8936; // Arm length, inches converted to integers
//	assign l1_inch = 14'd6;
//	assign l2_inch = 14'd5;
	logic [13:0] l1_mm;
	logic [13:0] l2_mm;
	
	
	/* State variables for each state */
	logic FKEnable, 	FKReset, 	FKDone; 	/* Forward Kinematics 	*/
	logic JEnable, 	JReset, 		JDone;	/* Jacobian 				*/
	logic JIEnable, 	JIReset, 	JIDone;	/* Jacobian Inverse 		*/
	logic MULTEnable, MULTReset, 	MULTDone;/* Multiply Out			*/
	logic CONVEnable, CONVReset, 	CONVDone;/* Convert Result			*/
	logic ChkFinEn, 	ChkFinRes,	ChkFinDone; /* Forward Kinematics 	*/
	logic ACCUMEnable, 	ACCUMReset,	ACCUMDone;/* Accumulate Steps */

	
	typedef enum logic [4:0] {
								FK, 
								J, 
								JI, 
								MULT, 
								CONV, 
								INIT, 
								CheckFinished, 
								ACCUMULATE
							} compute_state;
							
							
	compute_state next_state;
	compute_state state;
	
//	initial begin
////		state 		= 	FK;
////		next_state 	= 	J;
//		
//		FKReset 		= 	1'b1;
//		FKEnable 	= 	1'b0;
//		FKdone 		= 	1'b0;
//		
//		JDone 		= 	1'b0;
//		JReset 		= 	1'b1;
//		JEnable		= 	1'b0;
//		
//		JIDone 		= 	1'b0;
//		JIEnable 	= 	1'b0;
//		JIReset 		=	1'b1;
//		
//		MULTDone 	= 	1'b0;
//		MULTReset 	= 	1'b1;
//		MULTEnable 	= 	1'b0;
//	end
	logic [31:0] count;
	
	Counter #(32) cnt (
							.clk(clk),
							.enable(~reset),
							.reset(reset),
							.q(count),
							.d(count)
							);
	/* State Transition Logic */
	
	// Initialize the arm to the current location
	always_ff@(posedge clk) begin
		state <= next_state;
		if(reset) begin
			state <= INIT;
			th1 <= 9'd45;
			th2 <= 9'd45;
		end
		
		
		if(state == INIT) begin
		// Init state
			if(control_state_reg[0]) next_state <= FK;
			else 
			begin
				next_state 	<= 	INIT;
				FKReset 	  	<= 	1'b1;
				FKEnable		<= 	1'b0;
		
				JReset 		<= 	1'b1;
				JEnable		<= 	1'b0;
	
				JIEnable 	<= 	1'b0;
				JIReset 		<=		1'b1;
		
				MULTReset 	<= 	1'b1;
				MULTEnable 	<= 	1'b0;
				
				CONVReset 	<=		1'b1;
				CONVEnable	<=		1'b0;
				
				ChkFinRes	<= 	1'b1;
				ChkFinEn		<= 	1'b0;
			end
		end
		
		else if(state == FK) begin
			// Forward Kinematics
			if(FKDone) begin
			// Transition to jacobian state
				FKReset <= 1;
				FKEnable <= 0;
				next_state <= CheckFinished;
			end
			else begin
			// start/contine FK state
				FKEnable <= 1;
				FKReset <= 0;
				next_state <= FK;
			end
		end
		else if(state == CheckFinished)begin
			if(ChkFinDone)begin
				ChkFinRes <= 1;
				ChkFinEn <= 0;
				
				next_state <= J;
				// Enable output
				// wait for stepper motors
				// Reset output numbers when finished.
			end
			else begin
				ChkFinRes <= 0;
				ChkFinEn <= 1;
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
		else if(state == ACCUMULATE) begin
			// Accumulator state. Keep record
			// Of the direction and magnitude 
			// Of stepper motor steps until we've
			// reached the target
			if(ACCUMDone) begin
				ACCUMEnable <= 0;
				ACCUMReset <= 1;
				
				next_state <= FK;
				
			end
			else begin
				ACCUMEnable <= 1;
				ACCUMReset <= 0;
				
				next_state <= ACCUMULATE;
			end
			
		end
		
	end
	
	
	/* State Logic */
	
	ForwardKinematics fk (
								.reset(FKReset | reset),
								.enable(FKEnable),
								.th1(th1),
								.th2(th2),
								.l1(l1_inch),
								.l2(l2_inch),
								.clk(clk),
								.x(x_current),
								.y(y_current),
								.data_ready(FKDone)
								);
								
	logic target_converted, checkFinishedEnable;
	logic [63:0] convX, convY;
	
	// The CheckFinished block compairs the xtarget and ytarget
	// with the current state. We get it in as a 14-bit unsigned
	// integer. The comparison blocks are 15-bit to double because
	// they receive a signed integer input, meaning if it were 14-bit
	// and the value was such that the most significant bit was flipped
	// then the value would be considered negative. After the conversion
	// happens, then the target converts.
	ClockTimer #(10,6) convXYTarget(
											.clk(clk),
											.en(ChkFinEn),
											.expire(target_converted),
											.reset(ChkFinRes | reset)); 
											
											
	Int15BitToDouble xTarget(
									.clock(clk),
									.clk_en(ChkFinEn),
									.dataa({1'b0, x_target_loc}),
									.result(convX)
									);
									
									
	Int15BitToDouble yTarget(
									.clock(clk),
									.clk_en(ChkFinEn),
									.dataa({1'b0, y_target_loc}),
									.result(convY)
									);
	
	SRLatch latchCheckFinEn(.reset(ChkFinRes | reset),
									.set(target_converted),
									.q(checkFinishedEnable));
	
	
	CheckFinished cf (
							.reset(ChkFinRes | reset),
							.enable(checkFinishedEnable),
							.x_current(x_current),
							.y_current(y_current),
							.x_target(convX),
							.y_target(convY),
							.AtTarget(target_reached),
							.relative_target(1'b0),
							.ready(ChkFinDone),
							.clk(clk)
							);
	
	/**********************************************************/
	
	/********************* Take the Jacobian ********************/
	
	logic [63:0] dx_dth1, dx_dth2, dy_dth1, dy_dth2;
	
	Jacobian jk (
						.reset(JReset | reset),
						.enable(JEnable),
						.clk(clk),
						.l1(l1_inch),
						.l2(l2_inch),
						.th1(th1),
						.th2(th2),
						.data_ready(JDone),
						.dx_dth1(dx_dth1),
						.dx_dth2(dx_dth2),
						.dy_dth1(dy_dth1),
						.dy_dth2(dy_dth2)
					);
					
	/************************************************************/
	
	/********************* Invert the Jacobian *****************/
	logic [63:0] aInv, bInv, cInv, dInv;

	JacobianInverse ji (
							.reset(JIReset | reset),
							.enable(JIEnable),
							.clk(clk),
							.a(dx_dth1),
							.b(dx_dth2),
							.c(dy_dth1),
							.d(dy_dth2),
							.aOut(aInv),
							.bOut_n(bInv),
							.cOut_n(cInv),
							.dOut(dInv),
							.data_ready(JIDone)
						);
	
	/*************************************************************/
	
	
	/***********************Multiply Logic**************/
	/** Change in X and Y logic **/
	// We need to convert our current
	// Location to a value that is 
	// Conducive to our logic.
	
	logic [14:0] xInt, yInt;
	
	/* We do not need to time this because
		It will not take longer than other states */
	DoubleTo15BitInt x_curr(.dataa(x_current),
									.clk_en(JIEnable),
									.clock(clk),
									.result(xInt)
									);
									
									
	DoubleTo15BitInt y_curr(.dataa(y_current),
									.clk_en(JIEnable),
									.clock(clk),
									.result(yInt)
									);
	
	reg signed [13:0] dx, dy;
	
	always_comb
	begin
		if(control_state_reg[2])begin
		// Relative position
//			dx <= x_target;
//			dy <= y_target;
		// If relative, add to the current position
		// The delta in x
			x_target_loc = xInt[13:0] + x_target; 
			y_target_loc = yInt[13:0] + y_target;
		end
		else begin
		// Absolute position
		// If absolute, our target is simply our target
			x_target_loc = x_target;
			y_target_loc = y_target;
		end
		
	
		dx <= x_target_loc - xInt[13:0];
		dy <= y_target_loc - yInt[13:0];
		
	end
	
	logic [63:0] changeTh1, changeTh2;
						
	MatMult multiply (
						.reset(MULTReset | reset),
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
						.dth1NineBit(dth1),
						.dth2NineBit(dth2),
						.data_ready(MULTDone)
						);
					
					
	always_ff@(posedge MULTDone) begin
		//Update the thetas after mult
		//through
		th1 <= th1 + dth1;
		th2 <= th2 + dth2;
	end
						
						
	DegToSteps d2s (
						.reset(CONVReset | reset),
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
	
	assign controller_ready = target_reached;
	
	
	
	
	
endmodule
