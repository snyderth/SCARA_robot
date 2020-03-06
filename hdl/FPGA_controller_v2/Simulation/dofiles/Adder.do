# Adder simulation
# Author: Thomas Snyder
# Date: 02/05/2020

#Compile adder
vlog -work work Adder.v

#Start simulation, loading 220model library because adder is from altera IP
vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.Adder

#Add waves for display
add wave -format Logic clock
add wave -format Logic clk_en
add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -format logic overflow


force clock 0 @ 0, 1 @ 5 -r 10
force clk_en 0 @ 0, 1 @ 100
force dataa 64'b0000000000000000000000000000000000000000000000000000000000000000 @ 0
force dataa 64'b0011111011100000000000000000000000000001011001000001000010000000 @ 140

force datab 64'b0011111111100000000000000000000000000001011001000001000010000000 @ 5

run 400