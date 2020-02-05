vsim work.SinDeg
add wave /SinDeg/data_in
add wave /SinDeg/data_out

force data_in 8'd90 @ 0

force data_in 01001011 @ 10

force data_in 10111111 @ 20

force data_in 00010101 @ 30

force data_in 8'd85 @ 40

run 50
