# Compile
vlog -work work IntToDouble.v

# Start simulator. Must include 220model library
vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.IntToDouble

# Add waves for display
add wave -format Logic clk_en
add wave -format Logic clock
add wave -radix signed dataa
add wave -radix float64 result

# Simulate
force clock 0 @ 0, 1 @ 5 -r 10
force clk_en 0 @ 0, 1 @ 100
force dataa 32'd43 @ 29, 32'b11111111111111111111111111001110 @ 200

run 400
