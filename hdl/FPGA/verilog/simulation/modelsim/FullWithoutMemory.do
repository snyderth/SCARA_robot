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
add wave /Testbench/controller/anglesCalc/*
add wave /Testbench/controller/*
add wave /Testbench/joint1/*
#add wave /Testbench/joint1/*
add wave /Testbench/joint2/*
add wave *
force CLOCK_50 0 @ 0, 1 @ 1 -r 2
force initEnable 0 @ 0, 1 @ 3



force cmd 4'd5 @ 0
force cmd 4'd0 @ 10
force x_value 14'd7000 @20, 14'd7000 @ 2000
force y_value 14'd6000 @20, 14'd7000 @ 2000


force memory_ready 0 @ 0, 1 @ 20, 0 @ 200, 1 @ 1000

run 20000