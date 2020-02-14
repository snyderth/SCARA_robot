module DegToSteps (input logic [63:0] dth1,
						 input logic [63:0] dth2,
						 input logic clk,
						 input logic en,
						 input logic reset,
						 output logic data_ready,
						 output logic [63:0] steps1,
						 output logic dir1,
						 output logic [63:0] steps2,
						 output logic dir2
						 );
						
					logic [63:0] onePointEight = 64'h3FFCCCCCCCCCCCCD;
					
					logic [63:0] s1Res, s2Res;
					logic s1Ready, s2Ready;
					
					/*		Divide by degrees per step of motor	*/
					DoubleDivider Th1ToSteps(
													.dataa(dth1),
													.datab(onePointEight),
													.clk(clk),
													.enable(en),
													.data_ready(s1Ready),
													.result(s1Res)
													);
													
													
					DoubleDivider Th2ToSteps(
													.dataa(dth2),
													.datab(onePointEight),
													.clk(clk),
													.enable(en),
													.data_ready(s2Ready),
													.result(s2Res)
													);
													
					always_comb begin
					// Check sign for direction
						if(s1Res[63]) begin
							steps1 = {1'b0, s1Res[62:0]};
							dir1 = 1;
						end
						else begin
							steps1 = s1Res;
							dir1 = 0;
						end
					// Check sign for direction
						if(s2Res[63]) begin
							steps2 = {1'b0, s2Res[62:0]};
							dir2 = 1;
						end
						else begin 
							dir2 = 0;
							steps2 = s2Res;
						end
						
					end

					assign data_ready = s1Ready & s2Ready;
endmodule
