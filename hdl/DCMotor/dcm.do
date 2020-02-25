vsim work.DCMotor

add wave *

force clk_50 0 @ 0, 1 @ 10 -r 20
force reset_n 1 @ 0, 0 @ 15, 1 @ 55
force duty 8'd127
force limit_switch 1 @ 300, 0 @ 100000, 1 @ 200000
force set_pen 0 @ 0, 1 @ 100, 0 @ 150000
force enable 1
force fault_n 1

run 400