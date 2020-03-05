# SRLatch simulation
# Author: Thomas Snyder
# Date: 02/05/2020


# Compile the necessary files
vlog -work work MultiplierFP.v
vlog -work work ClockTimer.sv
vlog -work work SRLatch.sv
vlog -work work Counter.sv


vsim work.SRLatch

add wave -format Logic set
add wave -format Logic reset
add wave -format Logic q
add wave -format Logic qn


force set 0 @ 0, 1 @ 10, 0 @ 20, 1 @ 30
force reset 1 @ 0, 0 @ 10, 0 @ 20, 1 @ 30

run 40