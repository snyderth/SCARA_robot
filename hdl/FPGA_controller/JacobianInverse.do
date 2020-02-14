vlog -work work DoubleMultiply.sv
vlog -work work DoubleDivider.sv
vlog -work work JacobianInverse.sv

vsim -L 220model -L lpm_ver -L altera_mf_ver  work.JacobianInverse

add wave -radix float64 a
add wave -radix float64 b
add wave -radix float64 c
add wave -radix float64 d

add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic data_ready
add wave -format Logic reset

add wave -radix float64 aOut
add wave -radix float64 bOut_n
add wave -radix float64 cOut_n
add wave -radix float64 dOut

add wave -format Logic DetMultReady


force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 40

force reset 1 @ 0, 0 @ 20

force a 64'b0100000010110000100101000000000000000000000000000000000000000000 @ 0
force b 64'b0100000010110000100101000000000000000000000000000000000000000000 @ 0
force c 64'b1011111111101011011011010010101000011101101001001001001010000111 @ 0
force d 64'b1011111111101011011011011110101000011101101111001001001010000111 @ 0

run 10000