/***************************************************
*	File: 		MatMult
*	Author: 		Thomas Snyder
*	Date:			2/5/2020
*	Description:Multiplying out the 2x2 inverted 
*					jacobian matrix with the changes in
*					X and Y to produce the desired 
*					changes in theta 1 and theta 2.
*
*					| d_inv 	c_inv ||dx| =  |dth1|
*					| b_inv	a_inv ||dy|		|dth2|
*
*
*	Parameters:
*				None
*
*	Dependencies:
*			DoubleMultiply.sv
*
*	NOTE: For simulation, the MultiplierFP file needs
*			the library to be specified via 
*			-L <path_to_model220-lib>
*
***************************************************/
module MatMult(input logic [63:0] invA,
					input logic [63:0] invB,
					input logic [63:0] invC,
					input logic [63:0] invD,
					input signed [13:0] dx,
					input signed [13:0] dy,
					input logic clk,
					input logic enable,
					input logic reset,
					output logic data_ready,
					output logic [63:0] dth1,
					output logic [63:0] dth2
					);
		
		logic [17:0] filler;
		assign filler = 18'd0;
		
		
		/*	Conversion of the integer inputs	*/
		logic [63:0] dxConv, dyConv;
		logic convDone;
		
		IntToDouble x (
							.dataa({filler, dx}),
							.result(dxConv),
							.clk_en(enable),
							.clock(clk)
							);
		
		IntToDouble y (
							.dataa({filler, dy}),
							.result(dyConv),
							.clk_en(enable),
							.clock(clk)
							);
		
		ClockTimer #(3, 6) convTimer(
							.en(enable),
							.reset(reset),
							.clk(clk),
							.expire(convDone));
		
		/*		Multiply out the matrices 	*/
		
		logic dMultDone, cMultDone, bMultDone, aMultDone, allMultDone;
		logic [63:0] dxDinv, dyCinv, dxBinv, dyAinv;
		
		DoubleMultiply dxTimesDInv(
											.in_ready(convDone),
											.dataa(dxConv), 
											.datab(invD),
											.clk(clk),
											.reset(reset),
											.data_ready(dMultDone),
											.result(dxDinv)
											);
											
		DoubleMultiply dyTimesCInv(
											.in_ready(convDone),
											.dataa(dyConv), 
											.datab(invC),
											.clk(clk),
											.reset(reset),
											.data_ready(cMultDone),
											.result(dyCinv)
											);
		
		
		DoubleMultiply dxTimesBInv(
											.in_ready(convDone),
											.dataa(dxConv), 
											.datab(invB),
											.clk(clk),
											.reset(reset),
											.data_ready(bMultDone),
											.result(dxBinv)
											);
											
		DoubleMultiply dyTimesAInv(
											.in_ready(convDone),
											.dataa(dyConv), 
											.datab(invA),
											.clk(clk),
											.reset(reset),
											.data_ready(aMultDone),
											.result(dyAinv)
											);
		
		assign allMultDone = dMultDone & cMultDone & bMultDone & aMultDone;
		
		/*********************************/
		
		/*			Add all the results   	*/
		
		logic th1AddDone, th2AddDone;
		
		DoubleAdder dth1Add(
								.in_ready(allMultDone),
								.reset(reset),
								.dataa(dxDinv),
								.datab(dyCinv),
								.clk(clk),
								.data_ready(th1AddDone),
								.result(dth1)
								);
		
		DoubleAdder dth2Add(
								.in_ready(allMultDone),
								.reset(reset),
								.dataa(dyAinv),
								.datab(dxBinv),
								.clk(clk),
								.data_ready(th2AddDone),
								.result(dth2)
								);
		
		
		/*********************************/

		assign data_ready = th1AddDone & th2AddDone;
		
		
endmodule