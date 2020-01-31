module inverse_kinematics(input logic [13:0] x_pos,
									input logic [13:0] y_pos,
									input logic clk,
									input logic res,
									output logic [13:0] th1,
									output logic [13:0] th2);
	real init_th <= 0.7853981634;
	real theta1, theta2;
	real unit_conv_mm;
	real unit_conv_in;
	
	always@ff(posedge clk, posedge res)
		if(res)
			th1 <= 0;
			th2 <= 0;
		else
			// Create
			

									
									
endmodule