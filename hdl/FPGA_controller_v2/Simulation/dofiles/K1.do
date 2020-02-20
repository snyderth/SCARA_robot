vlog -work work ../Functions/K1.sv

vsim -L lpm_ver work.K1

add wave -radix float64 CosTh2
add wave -radix float64 l1
add wave -radix float64 l2
add wave -radix float64 k1
add wave enable
add wave clk
add wave reset
add wave state
add wave nextstate
add wave dataReady


force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15

force reset 1 @ 0, 0 @ 15

force CosTh2 64'b1011111111101001100000011101111000100110100100010110010001000000 @ 0

force l1 64'b0100000011000001011101000101110100010111010001011101000011011110 @ 0
force l2 64'b0100000010111101000101110100010111010001011101000101100111110111 @ 0

run 500