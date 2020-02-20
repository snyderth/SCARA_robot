/***************************************************
*	File: 		ClockTimer
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Counts on clk to a number and outputs
*					high for two clocks.
*	Parameters:
*				1) Width: Width of counter bus
*				2) Trigger: Number to trigger output high
*
*	Dependencies:
*				Counter.sv
*
***************************************************/
module ClockTimer #(parameter Width=10, Trigger=10)
						(input logic clk,
						input logic en,
						input logic reset,
						output logic [(Width-1):0] count,
						output logic expire);

	/* For sync */
	logic n1;
	logic dsync;
	/************/				
		
	/* Counter */

	logic res;
	logic [(Width-1):0] n2;
	
	assign count = n2;
	// Reset on expire
	always@(expire)
		if(expire) res <= 1;
		else if(~expire) res <= 0;
	
	Counter #(Width) c1 (.clk(clk),
							.enable(en),
							.reset(reset | res),
							.q(n2),
							.d(n2));
		
	/***************/
	
	/* comparator */
	
	
	logic [(Width-1):0] a, b; // Storage bus
	logic gt; // Goes high when a > b
	
	assign b = Trigger - 1; //Account for FF delay
	
	assign a = n2; // connect comparator and q
	
	always_comb
		if(a >= b) dsync <= 1'b1;
		else dsync <= 1'b0;
	
	/****************/
	
	
	
	/* Synchronizer */
	
	 
	
	always_ff@(posedge clk)
	begin
		n1 <= dsync; // Data in goes in
		expire <= n1; // expire goes out
	end


		
endmodule
