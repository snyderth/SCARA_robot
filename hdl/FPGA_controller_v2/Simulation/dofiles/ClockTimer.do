# ClockTimer simulation
# Author: Thomas Snyder
# Date: 02/05/2020


# Compile the necessary files
vlog -work work MultiplierFP.v
vlog -work work ClockTimer.sv
vlog -work work SRLatch.sv
vlog -work work Counter.sv

# Simulate the Clock timer
vsim work.ClockTimer

# Add inputs
add wave -format Logic clk
add wave -format Logic expire
add wave -format Logic reset
add wave -format Logic en
add wave -radix Unsigned count


force clk 0 @ 0, 1 @ 5 -r 10
force reset 1 @ 0, 0 @ 15
force en 1 @ 20


run 5000
