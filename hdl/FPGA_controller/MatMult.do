vlog -work work DoubleMultiply.sv
vlog -work work DoubleAdder.sv
vlog -work work MatMult.sv

vsim -L 220model work.MatMult

add wave -radix float64 invA
add wave -radix float64 invB
add wave -radix float64 invC
add wave -radix float64 invD
add wave -radix Decimal dx
add wave -radix Decimal dy


add wave -radix float64 dth1
add wave -radix float64 dth2

add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic reset
add wave -format Logic data_ready


add wave -format Logic aMultDone
add wave -format Logic bMultDone
add wave -format Logic cMultDone
add wave -format Logic dMultDone

add wave -radix float64 dxDinv
add wave -radix float64 dyAinv
add wave -radix float64 dxBinv
add wave -radix float64 dyCinv

add wave -radix float64 dxConv
add wave -radix float64 dyConv

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 40
force reset 1 @ 0, 0 @ 30


force invA 64'b1011111111001000011011000110110111011001001101110101111100000011 @ 0
force invB 64'b1011111111001000011011000110110111011001001101110101111100000011 @ 0
force invC 64'b1011111111001000011011000110110111011001001101110101111100000011 @ 0
force invD 64'b1011111111001000011011000110110111011001001101110101111100000011 @ 0


force dx 14'd8483 @ 0
force dy 14'd2993 @ 0

run 10000