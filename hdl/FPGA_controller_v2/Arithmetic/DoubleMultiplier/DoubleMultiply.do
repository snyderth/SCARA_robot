# Compile the necessary files
vlog -work work MultiplierFP.v
vlog -work work ClockTimer.sv
vlog -work work SRLatch.sv
vlog -work work Counter.sv
vlog -work work DoubleMultiply.sv

# Start simulator
#vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.DoubleMultiply
vsim -L "Z:/home/thomas/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.DoubleMultiply

# Add waves
add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -format Logic clk
add wave -format Logic in_ready
add wave -format Logic reset
add wave -format Logic underflow
add wave -format Logic overflow
add wave -format Logic data_ready
add wave -format Logic nan
add wave -format Logic zero
add wave count
add wave -format Logic clock_en
#add wave -format Logic clock_res

# Begin simulation
force clk 0 @ 0, 1 @ 5 -r 10
force dataa 64'b1011111111001110111101110100101111111001110010101010110011100000 @ 0
force datab 64'b1011111111001110111101110100101111111001110010101010110011100000 @ 0


force dataa 64'b0011111111001110111101110100101111111001110010101010110011100000 @ 400
force datab 64'b1011111111001110111101110100101111111001110010101010110011100001 @ 400

force reset 1 @ 0, 0 @ 20

force in_ready 1 @ 100, 0 @ 200, 1 @ 400

run 10000