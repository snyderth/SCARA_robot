vlog -work work ../Arithmetic/SqRoot/SqRoot.v
vlog -work work ../Arithmetic/SqRoot/SquareRoot.sv

vsim -L lpm_ver work.SquareRoot


add wave -radix float64 data
add wave -radix float64 result
add wave clk
add wave clk_en
add wave reset
add wave dataReady


force clk 0 @ 0, 1 @ 5 -r 10
force reset 1 @ 0, 0 @ 15
force clk_en 0 @ 0, 1 @ 15
force data 64'b0100000000010000000000000000000000000000000000000000000000000000 @ 0

run 500