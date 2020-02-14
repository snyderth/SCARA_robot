vlog DoubleDiv.v

vsim -L lpm_ver -L altera_mf_ver work.DoubleDiv

add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -Logic clock
add wave -Logic clk_en


force clock 0 @ 0, 1 @ 5 -r 10
force clk_en 0 @ 0, 1 @ 40
force dataa 64'b1011111111101111111000001101001110110011111011100100011100111110 @ 0
force datab 64'b1011111111101110000100011111011001000001101111000010111000111110 @ 0

run 1000