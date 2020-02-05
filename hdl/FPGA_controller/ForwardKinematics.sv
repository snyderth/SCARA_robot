module ForwardKinematics(input signed [7:0] th1,
								 input signed [7:0] th2,
								 input logic	[14:0] l1,
								 input logic 	[14:0] l2,
								 input logic 	clk,
								 input logic  reset,
								 output logic [63:0] x,
								 output logic [63:0] y);
		
		/* counter to keep track of clocks */
		logic res;
		logic [31:0] count;
		
		
		Counter #(32) cnt(
								.q(count),
								.clk(clk),
								.reset(reset),
								.enable(1)
								);
		
		
		
		logic [63:0] L1Double;
		logic [63:0] L2Double;
		
		/* No latency */
		IntToDouble	l1conv (
												.clk_en ( 1 ),
												.clock ( clk ),
												.dataa ( l1 ),
												.result ( L1Double )
												);
/* Converting integer lengths to double lengths */													
												
		IntToDouble	l2conv (
												.clk_en ( 1 ),
												.clock ( clk),
												.dataa ( l2 ),
												.result ( L2Double )
												);

/* Sine/Cosine calculations */												
		logic [63:0] cosineth12;
		logic [63:0] sineth1;
		
	
		
		SinDeg sine(
							.data_in(th1),
							.data_out(sineth1)
							);
							
		logic [7:0] th12;
		
		always_comb
		begin
			th12 = th1 + th2;
		end
		
		CosDeg cosine(
							.data_in(th12),
							.data_out(cosineth12)
							);
		

/* Multiplying it all out */
		
		
		Multiplier	Multiplier_l1sine (
													.aclr ( res ),
													.clk_en ( 1 ),
													.clock ( clk ),
													.dataa ( ),
													.datab ( datab_sig ),
													.result ( result_sig )
													);
	
		Multiplier	Multiplier_i (
													.aclr ( res ),
													.clk_en ( 1 ),
													.clock ( clk ),
													.dataa ( ),
													.datab ( datab_sig ),
													.result ( result_sig )
													);
	
		Multiplier	Multiplier_ins (
													.aclr ( res ),
													.clk_en ( 1 ),
													.clock ( clk ),
													.dataa ( ),
													.datab ( datab_sig ),
													.result ( result_sig )
													);
	
		Multiplier	Multiplier_int (
													.aclr ( res ),
													.clk_en ( 1 ),
													.clock ( clk ),
													.dataa ( ),
													.datab ( datab_sig ),
													.result ( result_sig )
													);

										
endmodule
