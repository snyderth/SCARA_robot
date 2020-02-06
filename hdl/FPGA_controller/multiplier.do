# Compile MultiplierFP.v into work library
vlog -work work MultiplierFP.v

# Simulate the multiplier, including the 220model library
vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.MultiplierFP

# Add inputs and outputs
add wave -format Logic clock
add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -format Logic nan
add wave -format Logic overflow
add wave -format Logic underflow
add wave -format Logic zero
add wave -format Logic clk_en

#Start the clock
force clock 0 @ 0, 1 @ 5 -r 10

force clk_en 1 @ 0, 0 @ 100

force dataa 64'b0000000000000000000000000000000000000000000000000000000000000000 @ 0
force dataa 64'b1011111000101110110101100000101000010001101001100010011000110011 @ 140

force datab 64'b0011111111100000000000000000000000000001011001000001000010000000 @ 5

run 1000000