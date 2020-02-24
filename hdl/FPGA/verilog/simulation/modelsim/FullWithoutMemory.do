#vlog -work work ../../../../FPGA_controller_v2/Atan2/simulation/submodules/*.v

vsim work.Testbench -L altera_mf_ver -L lpm_ver 

add wave cmd
add wave -radix signed x_value
add wave -radix signed y_value
add wave memory_ready
add wave initEnable
add wave CLOCK_50
add wave GPIO_0
add wave /Testbench/controller/state
add wave /Testbench/controller/reset
add wave /Testbench/controller/steps1
add wave /Testbench/controller_interface/controller_state_reg
add wave /Testbench/controller/readyForNewData

force CLOCK_50 0 @ 0, 1 @ 5 -r 10
force initEnable 0 @ 0, 1 @ 20


force cmd 4'd0 @ 40, 4'd1 @ 60, 4'd2 @ 80, 4'd3 @ 100, 4'd4 @ 120, 4'd5 @ 140, 4'd7 @ 160, 4'd8 @ 180  
force x_value 14'd3838 @ 40, 14'd5913 @ 60, 14'd3 @ 160
force y_value 14'd4567 @ 40, 14'd1235 @ 60, 14'd0 @ 160


force memory_ready 0 @ 0, 1 @ 5 -r 10

run 10000