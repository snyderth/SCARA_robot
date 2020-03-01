module ScaraController(input logic [4:0] controlStateReg,
								input signed [13:0] xTarget,
								input signed [13:0] yTarget,
								input logic stepperReady,
								input logic enable,
								input logic clk,
								input logic reset,
								output logic [7:0] steps1,
								output logic [7:0] steps2,
								output logic dir1,
								output logic dir2,
								output logic endEffectorState,
								output logic dataReady,
								output logic readyForNewData);
								
		/* For receiving new data and moving data through from stepper motors */
		logic newDataReceived;
		always_ff@(posedge clk)
		begin
			if(stepperReady && !newDataReceived)
			begin
				readyForNewData <= 1;
			end
			else if(newDataReceived)
			begin
				readyForNewData <= 0;
				
			end
		end
//		SRLatch newDataLatch(.set(stepperReady),
//									.reset(newDataReceived),
//									.q(readyForNewData));
		
		/**********************************************************************/
		
		logic [63:0] l2 = 64'b0100000010111100010111010001011101000101110100010111010001011101;//64'b0100000011000111010001011101000101110100010111001100100100101110;
		logic [63:0] l1 = 64'b0100000010110000001001010011110101110000101000111101011100001010; //64'b0100000011000000101110100010111010001011101000101110000011101011;
		logic [63:0] l1Squared = 64'b0100000101110000010010101100111110101101011001110010100101100010;//64'b0100000110010001011111001101001110010001111110111100110100110101;
		logic [63:0] l2Squared = 64'b0100000110001001001000111111011110001001100001010100101000001101;//64'b0100000110100000111011001111010101101011111001100110011001100110;
		
		
		logic [13:0] xCurrent, yCurrent, xTarg, yTarg;
		
		logic [12:0] th1Current, th2Current, th1Target, th2Target;
		
		logic FKEn, FKDone;
		logic AnglesEn, AnglesDone;
		logic StepsEn, StepsDone;
		logic WaitEn, WaitDone;
		
		
		typedef enum logic [3:0] {FK, Angles, Steps, Wait, Init} statetype;
		statetype state, nextstate;
		
		
		/* Separate logic for end effector */
		always_ff@(posedge clk) begin
			if(reset) begin
				endEffectorState <= 0;
			end
			else if(controlStateReg[3] | controlStateReg[4]) endEffectorState <= 1;
			else endEffectorState <= 0;
			
		end
		
		/* Main state machine transition logic */
		always_ff@(posedge clk) begin
			if(reset) begin
//				th1Current <= 13'b000_1100100100;
//				th2Current <= 13'b000_1100100100; //pi/4 start
				nextstate <= Init;
				FKEn <= 0;
				AnglesEn <= 0;
				StepsEn <= 0;
				WaitEn <= 0;
			end
			else if(state == Init) begin
				newDataReceived <= 0;
				FKEn <= 0;
				AnglesEn <= 0;
				StepsEn <= 0;
				WaitEn <= 0;
				if(enable) begin
					
					if(controlStateReg[4]) nextstate <= Wait;
					else if(controlStateReg[2] & controlStateReg[0] & stepperReady) nextstate <= FK;
					else if(controlStateReg[0] & stepperReady) nextstate <= Angles;
					
				end
			
			end
			else if(state == FK) begin
				if(FKDone) begin
					FKEn <= 0;
					nextstate <= Angles;
				end
				else begin 
					newDataReceived <= 1;

					FKEn <= 1;
				end 
			end
			else if(state == Angles) begin
				if(AnglesDone) begin
					AnglesEn <= 0;
					nextstate <= Steps;
//					th1Current <= th1Target;
//					th2Current <= th2Target;
				end
				else AnglesEn <= 1;
			end
			else if (state == Steps) begin
				if(StepsDone) begin
					StepsEn <= 0;
					nextstate <= Init;
				end
				else StepsEn <= 1;
			end
		
			else if(state == Wait) begin
				if(WaitDone) begin
					WaitEn <= 0;
					//endEffectorState <= 0;
					nextstate <= Init;
				end
				else begin
					WaitEn <= 1;
					//endEffectorState <= 1;
				end
		
			end
			state <= nextstate;
		
		end
		
		
		ForwardKinematics FKine (.theta1(th1Current),
										.theta2(th2Current),
										.clk(clk),
										.enable(FKEn),
										.reset(~FKEn | reset),
										.l1(l1),
										.l2(l2),
										.x(xCurrent),
										.y(yCurrent),
										.dataReady(FKDone));
										
		always_comb begin
			if(controlStateReg[2]) begin
				xTarg = xTarget + xCurrent;
				yTarg = yTarget + yCurrent;
			end
			else begin
				xTarg = xTarget;
				yTarg = yTarget;
			end
		end
		
		
		CalculateAngles anglesCalc(
							.yTarget(yTarg),
							.xTarget(xTarg),
							.l1(l1),
							.l2(l2),
							.l1Squared(l1Squared),
							.l2Squared(l2Squared),
							.clk(clk),
							.enable(AnglesEn),
							.reset(~AnglesEn | reset),
							.relative(controlStateReg[2]),
							.dataReady(AnglesDone),
							.th1(th1Target),
							.th2(th2Target)
							);
							
							
		logic [12:0] theta1Diff, theta2Diff;
		always_ff@(posedge clk) begin
			if(reset) begin 
				th1Current <= 13'b000_1100100100;
				th2Current <= 13'b000_1100100100; //pi/4 start
			end
			else if(AnglesDone) begin
			
				//Update with new angles
				th1Current <= th1Target;
				th2Current <= th2Target;

			end			
		end
		
		always_comb begin
			
			//Update input for steps
			theta1Diff = th1Target - th1Current;
			theta2Diff = th2Target - th2Current;

		end
		
		
		logic [8:0] steps1int, steps2int;
		
		CalculateSteps stepsCalc(
							.th1(theta1Diff),
							.th2(theta2Diff),
							.clk(clk),
							.enable(StepsEn),
							.reset(~StepsEn | reset),
							.dataReady(StepsDone),
							.dir1(dir1),
							.dir2(dir2),
							.steps1(steps1int),
							.steps2(steps2int)
							);
		always_comb begin
			if(reset) begin
				steps1 = 0;
				steps2 = 0;
			end
			else begin
				steps1 = steps1int[7:0];
				steps2 = steps2int[7:0];

			end
		end
		
		assign dataReady = StepsDone;

		
		ClockTimer #(13, 200) WaitState (.en(WaitEn), 
													.reset(~WaitEn | reset),
													.expire(WaitDone),
													.clk(clk)); 
		
endmodule
