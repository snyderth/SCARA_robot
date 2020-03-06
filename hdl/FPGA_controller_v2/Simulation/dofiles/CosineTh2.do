# CosineTh2 simulation
# Author: Thomas Snyder
# Date: 02/05/2020


#vlog -work work Adder.v
#vlog -work work MuliplerFP.v
#vlog -work work DoubleDiv.v
#vlog -work work ../Arithmetic/DoubleDivider/DoubleDivider.sv
vlog -work work ../Arithmetic/Inverter/Inverter.v
#vlog -work work DoubleMultiply.sv
#vlog -work work DoubleAdder.sv
#vlog -work work SRLatch.sv
#vlog -work work Int15BitToDouble.v
#vlog -work work ClockTimer.sv

vlog -work work ../Functions/CosineTh2.sv

vsim -L lpm_ver -L altera_mf_ver work.CosineTh2

add wave -radix float64 l1Squared
add wave -radix float64 l2Squared

add wave -radix float64 l1
add wave -radix float64 l2

add wave -radix float64 xTarget_d
add wave -radix float64 yTarget_d

add wave -format Logic clk
add wave -format Logic enable 
add wave -format Logic reset

add wave -radix float64 CosTh2
add wave -format Logic dataReady

add wave MultState
add wave -radix float64 xTarget_d
add wave -radix float64 yTarget_d

add wave -radix float64 yTargSquared
#add wave -format Logic ySquareDone

add wave -radix float64 xTargSquared
#add wave -format Logic xSquareDone

add wave -radix float64 l1l2
#add wave -format Logic l1l2Done

add wave -radix float64 xyMinl1l2

add wave invEnable

#add wave underflow
#add wave overflow
#add wave divByZero
#add wave zero
#add wave NaN
add wave XSquareEn
add wave YSquareEn
add wave l1l2En


add wave -radix float64 l1l2SquaredSum
add wave -radix float64 xySquaredSum
add wave -radix float64 twicel1l2
add wave -radix float64 twicel1l2Inv
add wave -radix float64 divisor

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15

force l1Squared 64'b0100000110010001011111001101001110010001111110111100110100110101 @ 0
force l1 64'b0100000011000000101110100010111010001011101000101110000011101011 @ 0
force l2Squared 64'b0100000110100000111011001111010101101011111001100110011001100110 @ 0
force l2 64'b0100000011000111010001011101000101110100010111001100100100101110 @ 0

force xTarget_d 64'b0100000010101111010000000000000000000000000000000000000000000000 @ 0, 64'b0100000010100101110110100000000000000000000000000000000000000000 @ 1000
force yTarget_d 64'b0100000010101111110000000000000000000000000000000000000000000000 @ 0, 64'b0100000010100101110110100000000000000000000000000000000000000000 @ 1000

run 4000