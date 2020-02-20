#vlog -work work Adder.v
#vlog -work work MuliplerFP.v
#vlog -work work DoubleDiv.v
vlog -work work ../Arithmetic/DoubleDivider/DoubleDivider.sv
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


add wave -radix float64 xTarget_d
add wave -radix float64 yTarget_d

add wave -radix float64 yTargSquared
add wave -format Logic ySquareDone

add wave -radix float64 xTargSquared
add wave -format Logic xSquareDone

add wave -radix float64 l1l2
add wave -format Logic l1l2Done




add wave -radix float64 l1l2SquaredSum
add wave -radix float64 xySquaredSum
add wave -radix float64 twicel1l2
add wave -radix float64 divisor

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15

force l1 64'b0100000011000001011101000101110100010111010001011101000011011110 @ 0
force l1Squared 64'b0100000110010011000010101001010000011001011000110110111000101110 @ 0
force l2 64'b0100000010111101000101110100010111010001011101000101100111110111 @ 0
force l2Squared 64'b0100000110001010011100100011111101111000100110000101010010001010 @ 0

force xTarget_d 64'b0100000010001111010000000000000000000000000000000000000000000000 @ 0
force yTarget_d 64'b0100000010011111010000000000000000000000000000000000000000000000 @ 0

run 1000