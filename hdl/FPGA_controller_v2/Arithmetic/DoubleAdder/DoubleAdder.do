#Compile adder
vlog -work work DoubleAdder.sv
vlog -work work Adder.v
vlog -work work Sync.sv

#Start simulation, loading 220model library because adder is from altera IP
#vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.DoubleAdder
vsim -L "Z:/home/thomas/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.DoubleAdder

#Add waves for display
add wave -format Logic clk
add wave -format Logic in_ready
add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -format Logic data_ready
add wave -radix unsigned count
add wave -format Logic reset


force clk 0 @ 0, 1 @ 5 -r 10
force in_ready 0 @ 0, 1 @ 100
force dataa 64'b0000000000000000000000000000000000000000000000000000000000000000 @ 0
force dataa 64'b0011111011100000000000000000000000000001011001000001000010000000 @ 140
force reset 1 @ 0, 0 @ 12
force datab 64'b0011111111100000000000000000000000000001011001000001000010000000 @ 5

run 4000