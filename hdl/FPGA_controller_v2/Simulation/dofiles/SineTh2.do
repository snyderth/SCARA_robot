vlog -work work ../Arithmetic/SqRoot/SquareRoot.sv

vlog -work work ../Functions/SineTh2.sv

vsim -L lpm_ver -L 220model_ver work.SineTh2

add wave -radix float64 CosTh2
add wave clk
add wave reset
add wave enable
add wave dataReady
add wave -radix float64 SinTh2
add wave state
add wave nextstate
add wave SquareEn
add wave SquareDone
add wave SquareRes
add wave cnt

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15 
force reset 1 @ 0, 0 @ 15

force CosTh2 64'b1011111111101001100000011101111000100110100100010110010001000000 @ 0

run 5000