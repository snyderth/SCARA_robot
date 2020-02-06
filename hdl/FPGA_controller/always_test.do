vsim work.always_test

add wave clk
add wave always_test/multiplicand
add wave always_test/multiplier
add wave reset
add wave always_test/q
add wave out


force clk 0 @0, 1 @5 -r 10

force always_test/multiplcand 64'd4 @5
force always_test/multiplier 64'd5 @5

force reset 0 @0

