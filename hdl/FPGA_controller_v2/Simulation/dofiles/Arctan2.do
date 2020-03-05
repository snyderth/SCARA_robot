# Arctan2 simulation
# Author: Thomas Snyder
# Date: 02/05/2020

vlog -work work Counter.sv
vlog -work work ClockTimer.sv
vlog -work work DoubleTo32BitFixed.v
vlog -work work Atan2.v
vlog -work work ../Functions/Arctan2.sv

vsim -L 220model_ver work.Arctan2

# define new radixes for modelsim to display fixed
# point numbers
radix define fixed32 -fixed -signed -fraction 15
radix define fixed13 -fixed -signed -fraction 10


add wave -radix float64 arg1
add wave -radix float64 arg2

add wave -radix fixed32 arg1FixedPoint
add wave -radix fixed32 arg2FixedPoint

add wave -unsigned cnt

add wave -radix fixed13 angle
add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic reset
add wave -format Logic DataReady
add wave -format Logic atanStart

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 20, 0 @ 40, 1 @ 320, 0 @ 340
force reset 1 @ 0, 0 @ 15


## 64-bit double precision numbers
force arg1 64'b0100000010111000010110001001110110001001101011010111101100001001 @ 0
force arg2 64'b0100000010010000010010100111100100000100101001111001000001001111 @ 0


force arg1 64'b0100000010001000010110001001110110001001101011010111101100001001 @ 300
force arg2 64'b1100000010111000010010100111100100000100101001111001000001001111 @ 300

run 1500