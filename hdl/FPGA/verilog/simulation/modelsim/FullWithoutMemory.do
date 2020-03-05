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
#add wave /Testbench/controller/anglesCalc/*
add wave /Testbench/controller/*
add wave /Testbench/controller_interface/*
#add wave /Testbench/joint1/*
#add wave /Testbench/joint1/*
#add wave /Testbench/joint2/*
add wave *
force CLOCK_50 0 @ 0, 1 @ 1 -r 2
force initEnable 0 @ 0, 1 @ 3



force cmd 4'd8 @ 100
force /Testbench/endEffector/limit_switch 1 @ 0, 0 @ 150, 1 @ 200
force cmd 4'd8 @ 160
#force cmd 4'd8 @ 140
#force cmd 4'd6 @ 180
#force cmd 4'd8 @ 200
#force x_value 14'd7000 @20, 14'd7000 @ 2000
#force y_value 14'd6000 @20, 14'd7000 @ 2000


force memoryReady 0 @ 0, 1 @ 100, 0 @ 110, 1 @ 160, 0 @ 170
#, 1 @ 120, 0 @ 130, 1 @ 140,0 @ 150, 1 @ 180, 0 @ 190, 1 @ 200, 0 @ 210
#when {/Testbench/controller_interface_in_ready = 0} {force -deposit /Testbench/memory_ready 0}
#when {/Testbench/controller_interface_in_ready = 1} {force -deposit /Testbench/memory_ready 1}
run 2000