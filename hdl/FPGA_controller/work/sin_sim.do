vsim work.SinDeg
add wave -decimal *

force data_in 8'd9 @ 0

force data_in 8'd90 @ 10

force data_in 8'd9 @ 20

force data_in 8'd45 @ 30

force data_in 8'd85 @ 40

run 50
