vlog -work work ../Functions/K1.sv
vlog -work work ../Functions/Arctan2.sv
vlog -work work ../Functions/CosineTh2.sv
vlog -work work ../Functions/SineTh2.sv
vlog -work work ../Functions/CalculateAngles.sv

vsim -L lpm_ver -L altera_mf_ver work.CalculateAngles


radix define fixed13 -fixed -signed -fraction 10
radix define fixed32 -fixed -signed -fraction 15

#add wave -radix float64 k1
#add wave -radix float64 k2
add wave -radix float64 l1
add wave -radix float64 l2
add wave -radix float64 l1Squared
add wave -radix float64 l2Squared 
add wave -radix fixed13 th1
add wave -radix fixed13 th2
add wave -radix unsigned yTarget
add wave -radix unsigned xTarget
add wave state
add wave nextstate

add wave -radix fixed32 CalculateAngles/Theta2Calc/arg1FixedPoint
add wave -radix fixed32 CalculateAngles/Theta2Calc/arg2FixedPoint

add wave -radix float64 CosTh2
add wave -radix float64 SinTh2

add wave clk
add wave enable
add wave reset
add wave dataReady

add wave -radix fixed13 gammaResult
add wave -radix fixed13 arctanXY
add wave -radix float64 k1
add wave -radix float64 k2

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15

force l2 64'b0100000011000111010001011101000101110100010111001100100100101110 @ 0
force l1 64'b0100000011000000101110100010111010001011101000101110000011101011 @ 0

force l1Squared 64'b0100000110010001011111001101001110010001111110111100110100110101 @ 0
force l2Squared 64'b0100000110100000111011001111010101101011111001100110011001100110 @ 0

force xTarget 14'd2979 @ 0
force yTarget 14'd2979 @ 0

run 3000