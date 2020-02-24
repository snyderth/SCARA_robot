/***************************************************
*	File: 		K1
*	Author: 		Thomas Snyder
*	Date:			2/19/2020
*	Description:A module that calculates:
*					K1 = l1 + l2*cosTh2
*	Latency: 	26 Clock cycles
*
*	Parameters:
*				None
*	Dependencies:
*				DoubleMultiply.sv
*				DoubleAdder.sv
*
*	NOTE: This module must be simulated with the
*			lpm_ver library.
***************************************************/
module K1(input logic [63:0] l1,
				input logic [63:0] l2,
				input logic [63:0] CosTh2,
				input logic enable,
				input logic reset,
				input logic clk,
				output logic dataReady,
				output logic [63:0] k1);
				

			typedef enum logic [1:0] {Add, Mult, Init} statetype;
			statetype state, nextstate;
			
			logic AddEn, AddDone;
			logic MultEn, MultDone;
			
			
			always_ff@(posedge clk) begin
				if(reset) begin
					AddEn 	<= 0;
					MultEn	<= 0;
					dataReady <= 0;
					nextstate <= Init;
				end
				else if(state == Init) begin
					if(enable) begin
						nextstate <= Mult;
						dataReady <= 0;
					end				
				end
				else if(state == Mult) begin
					if(MultDone) begin
						MultEn <= 0;
						
						nextstate <= Add;
					end
					else begin
						MultEn <= 1;
					end
				end
				else if(state == Add) begin
					if(AddDone) begin
						nextstate <= Init;
						dataReady <= 1;
						AddEn <= 0;
					end
					else
						AddEn <= 1;
					
				end
			
				state <= nextstate;
			end
			
			logic [63:0] MultResult;
			
			DoubleMultiply l2TimesCosTh2(
												.dataa(l2),
												.datab(CosTh2),
												.in_ready(MultEn),
												.reset(~MultEn),
												.clk(clk),
												.data_ready(MultDone),
												.result(MultResult)
												);
												
			DoubleAdder addl1andl2CosTh2(
												.dataa(MultResult),
												.datab(l1),
												.in_ready(AddEn),
												.data_ready(AddDone),
												.result(k1),
												.reset(~AddEn),
												.clk(clk)
												);
				
endmodule

