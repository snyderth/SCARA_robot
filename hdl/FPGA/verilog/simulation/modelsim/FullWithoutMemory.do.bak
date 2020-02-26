#vlog -work work ../../../../FPGA_controller_v2/Atan2/simulation/submodules/*.v

vlog -work work ControllerInterfaceToControllerTestbench.sv
vcom -work work ../../../../FPGA_controller_v2/Atan2/simulation/submodules/dspba_library_package.vhd
vcom -work work ../../../../FPGA_controller_v2/Atan2/simulation/submodules/dspba_library.vhd
vcom -work work ../../../../FPGA_controller_v2/Atan2/simulation/submodules/Atan2_CORDIC_0.vhd

vsim work.Testbench -L altera_mf_ver -L lpm_ver 

#add wave cmd
#add wave -radix signed x_value
#add wave -radix signed y_value
#add wave memory_ready
#add wave initEnable
#add wave CLOCK_50
#add wave GPIO_0
#add wave /Testbench/controller/*
add wave /Testbench/joint1/*
add wave /Testbench/joint2/*
add wave *
force CLOCK_50 0 @ 0, 1 @ 5 -r 10
force initEnable 0 @ 0, 1 @ 20


force cmd 4'd0  
force x_value 14'd3838
force y_value 14'd4567

force memory_ready 0 @ 0, 1 @ 5 -r 10

run 10000