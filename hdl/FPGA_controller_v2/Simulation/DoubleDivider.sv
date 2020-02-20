/***************************************************
*	File: 		DoubleDivider
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Divider wrapper for altera IP that 
*					adds enable signals and data ready
*					signals to the IP.
*
*	Parameters:
*				None
*	Dependencies:
*				None
*
***************************************************/
module DoubleDivider(input logic [63:0] dataa,
							input logic [63:0] datab,
							input logic clk,
							input logic enable,
							input logic reset,
							output logic [63:0] result,
							output logic data_ready,
							output logic divByZero
							);
		/** For timing the division: takes 10 cycles **/
			logic enDiv, clockExp;			
				
		
			SRLatch enLatch(.set(enable),
								.reset(reset),
								.q(enDiv),
								.qn()
								);
								
			ClockTimer #(4, 10) divCount(.en(enDiv),
													.reset(reset),
													.expire(clockExp),
													.clk(clk));
			assign data_ready = clockExp;
			
			/******************************************/
			
			/* Actual Division */
			DoubleDiv divider(
										.dataa(dataa),
										.datab(datab),
										.clock(clk),
										.clk_en(enDiv),
										.result(result),
										.division_by_zero(divByZero)
										);
			

endmodule
