module jacobian(input	logic 	[13:0] l1,
					 input	logic 	[13:0] l2,
					 input	real		curr_theta1,
					 input	real		curr_theta2,
					 input	logic 	clk,
					 input 	logic		enable,
					 input 	logic		reset,
					 output  signed 	[14:0] dx_dth1,
					 output  signed 	[14:0] dx_dth2,
					 output  signed 	[14:0] dy_dth1,
					 output  signed 	[14:0] dy_dth2)
					 
			real theta_sum;
			logic counter_val;
			real cos_sum, sin_sum, cos, sin;
			always_ff@(posedge clk)
				if(enable)
				begin
					assign theta_sum = curr_theta1 + curr_theta2;
					SIN(theta_sum, clk, sin_sum);
				end
			
			// Counter
			always_ff@(posedge clk)
				if(~reset) counter_val <= counter_val + 1;
				else if(reset)	 counter_val <= 0;
					 
endmodule
