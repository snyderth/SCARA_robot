/***************************************************
*	File: 		JacobianInverse
*	Author: 		Thomas Snyder
*	Date:			2/7/2020
*	Description:A module to invert the 2 x 2 jacobian
*					matrix:
*		
*				| a	b |
*		A = 	| c 	d |
*
*		A^-1 = |  d	-b |
				 | -c  a |	/ (ad-bc)
*
*	Parameters:
*				None
*
*	Dependencies:
*				ClockTimer.sv
*				DoubleAdder.sv
*				DoubleMultiplier.sv
*				IntToDouble.v
*				
*
*	NOTE: For simulation, the file needs
*			the library to be specified via 
*			-L <path_to_model220-lib>
*
***************************************************/
module JacobianInverse(input logic [63:0] a,
							  input logic [63:0] b,
							  input logic [63:0] c,
							  input logic [63:0] d,
							  input logic enable,
							  input logic clk,
							  input logic reset,
							  output logic data_ready,
							  output logic [63:0] aOut,
							  output logic [63:0] bOut_n,
							  output logic [63:0] cOut_n,
							  output logic [63:0] dOut);
							  
			/* Computing the Determinant: 1 / ad- bc */
			logic DetMultReady, ADReady, BCReady;
			logic [63:0] ADResult, BCResult;
			logic [63:0] det;
		
			DoubleMultiply aTimesd(
								.enable(enable),
								.reset(reset),
								.clk(clk),
								.in_ready(data_ready),
								.data_ready(ADReady),
								.result(ADResult),
								.dataa(a),
								.datab(d)
								);
								
			DoubleMultiply bTimesc(
								.enable(enable),
								.reset(reset),
								.clk(clk),
								.in_ready(data_ready),
								.data_ready(BCReady),
								.result(BCResult),
								.dataa(b),
								.datab(c)
								);
			
			
			assign DetMultReady = BCReady & ADReady;
			
			logic DetReady;
			
			DoubleAdder subAD_BC(
									.dataa(ADResult),
									.datab({~BCResult[63], BCResult[62:0]}),// Invert sign bit to negate for sub
									.clk(clk),
									.data_ready(DetReady),
									.reset(reset),
									.in_ready(DetMultReady),
									.result(det),
								);
								
			/******************************************/
			
			/* Divide all elements of the array by the determinant */
			
			logic [63:0] aDivDet, bDivDet, cDivDet, dDivDet;
			logic aDivReady, bDivReady, cDivReady, dDivReady;
			
			DoubleDiv aDiv(.enable(DetReady),
								.clk(clk),
								.reset(reset),
								.dataa(a),
								.datab(det),
								.result(aDivDet),
								.data_ready(aDivReady)
								);
								
			DoubleDiv bDiv(.enable(DetReady),
								.clk(clk),
								.reset(reset),
								.dataa(b),
								.datab(det),
								.result(bDivDet),
								.data_ready(bDivReady)
								);
								
			DoubleDiv cDiv(.enable(DetReady),
								.clk(clk),
								.reset(reset),
								.dataa(c),
								.datab(det),
								.result(cDivDet),
								.data_ready(cDivReady)
								);
			
			DoubleDiv dDiv(.enable(DetReady),
								.clk(clk),
								.reset(reset),
								.dataa(d),
								.datab(det),
								.result(dDivDet),
								.data_ready(dDivReady)
								);
							
			
			
			/*******************************************************/
			
			/******** Output Stage ********/
			
			assign aOut = aDivDet;
			assign bOut_n = {~bDivDet[63], bDivDet[62:0]};// Inverting sign
			assign cOut_n = {~cDivDet[63], cDivDet[62:0]};// Invert sign
			assign dOut = dDivDet;
			
			assign data_ready = aDivReady & bDivReady & cDivReady & dDivReady;
			
			/******************************/

endmodule
