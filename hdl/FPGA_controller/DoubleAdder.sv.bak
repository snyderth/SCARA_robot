module DoubleAdder(input logic [63:0] datab,
						input logic  [63:0] dataa,
						input logic  clk,
						input logic in_ready,
						input logic reset,
						output logic [63:0] result,
						output logic [4:0] count,
						output logic data_ready);
						
			logic res;
			logic en1; // For the intermediate enable between latch and adder
			logic dsync, n1; // For the sync
			
			SRLatch lat(.set(in_ready),
							.reset(reset | res),
							.q(en1),
							.qn());
			
						
			Adder addy(.datab(datab),
							.dataa(dataa),
							.clock(clk),
							.clk_en(en1),
							.result(result));
						
			/* 14 cycle latency on the adder*/
			ClockTimer #(5, 14) ct(.en(en1),
											.clk(clk),
											.reset(res),
											.expire(dsync),
											.count(count));
			
			/* Sync */
			Sync sn(.d(dsync),
						.q(data_ready),
						.clk(clk),
						.en(1'b1),
						.reset(1'b0));
			
			/* Reset after output logic */
			always@(data_ready)
			begin
				if(data_ready) res <= 1;
				else res <= 0;
			end
			

endmodule						
