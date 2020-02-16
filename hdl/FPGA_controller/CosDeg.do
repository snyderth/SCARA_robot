vlog -work work CosDeg.sv

vsim work.CosDeg

add wave -radix float64 data_out
add wave -radix signed data_in

force data_in 'b101001100 @ 0, 'b101001101 @ 10

run 500