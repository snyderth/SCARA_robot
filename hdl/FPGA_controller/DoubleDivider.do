vlog -work work DoubleDiv.v
vlog -work work SRLatch.sv
vlog -work work DoubleDivider.sv
vlog -work work ClockTimer.sv
vlog -work work Counter.sv


#vsim -L lpm_ver -L altera_mf_ver -L "Z:/home/thomas/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.DoubleDivider
vsim -L 220model -L lpm_ver -L altera_mf_ver work.DoubleDivider

add wave -Logic clk
add wave -Logic enable
add wave -Logic reset
add wave -radix float64 dataa
add wave -radix float64 datab
add wave -radix float64 result
add wave -Logic data_ready


force clk 0 @ 0, 1 @ 5 -r 10
force reset 1 @ 0, 0 @ 20
force enable 0 @ 1, 1 @ 50
force dataa 64'b1011111111101111111000001101001110110011111011100100011100111110 @ 0
force datab 64'b1011111111101110000100011111011001000001101111000010111000111110 @ 0


run 1000

