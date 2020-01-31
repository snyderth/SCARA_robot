vsim work.counter

add wave *

force clk 0 @ 0, 1 @ 10 -r 20
force reset_n 0 @ 0, 1 @ 40
force en 1

run 1000