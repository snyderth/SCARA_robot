# Fixed13BitToFloat simulation
# Author: Thomas Snyder
# Date: 02/05/2020


vlog -work work ../Conversions/Fixed13BitToFloat.v

vsim -L lpm_ver work.Fixed13BitToFloat

radix define fixed13 -fixed -signed -fraction 10

add wave -radix fixed13 dataa
add wave -radix float32 result
add wave clock
add wave clk_en


force clk_en 1 @ 0
force clock 0 @ 0, 1 @ 5 -r 10

force dataa 13'b1100110111010 @ 0

run 500