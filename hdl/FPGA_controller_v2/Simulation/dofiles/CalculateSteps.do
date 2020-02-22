vlog -work work ../Conversions/*.v
vlog -work work ../Functions/CalculateSteps.sv

vsim -L lpm_ver work.CalculateSteps


radix define fixed13 -fixed -signed -fraction 10

add wave -radix fixed13 th1
add wave -radix fixed13 th2

add wave clk
add wave enable
add wave reset
add wave state
add wave dir1
add wave dir2
add wave dataReady

add wave -radix signed steps1
add wave -radix signed steps2


force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15
force th1 13'b1100110111010 @ 0
force th2 13'b0101110001101 @ 0

run 500
