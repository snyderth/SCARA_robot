vsim work.Multiplier

add wave *

force clk_en 1'b1 @ 0
force aclr 1'b1 @ 0 1'b0 @ 4

force clock 0 @ 0, 1 @ 5 -r 10

force dataa 64'd4 @ 5
force datab 64;d5 @ 5

run 100