vlog -work work Counter.sv
vlog -work work ClockTimer.sv
vlog -work work DoubleTo32BitFixed.v
vlog -work work Atan2.v
vlog -work work ../Functions/Arctan2.sv


vsim -L 220model -L lpm_ver -L altera_mf_ver work.Arctan2


add wave -radix float64 arg1
add wave -radix float64 arg2

add wave angle
add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic reset
add wave -format Logic DataReady


force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 20
force reset 1 @ 0, 0 @ 15

force arg1 64'b0100000010111000010110001001110110001001101011010111101100001001 @ 0
force arg2 64'b0100000010010000010010100111100100000100101001111001000001001111 @ 0

run 1500