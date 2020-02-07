vlog -work work DoubleMultiply.sv
vlog -work work MultiplierFP.v
vlog -work work Counter.sv
vlog -work work ClockTimer.sv
vlog -work work Adder.v
vlog -work work Sync.sv
vlog -work work SRLatch.sv
vlog -work work IntToDouble.v
vlog -work work ForwardKinematics.sv

vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.ForwardKinematics
#vsim -L "Z:/home/thomas/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.ForwardKinematics

add wave -radix signed th1
add wave -radix signed th2
add wave -radix unsigned l1
add wave -radix unsigned l2
add wave enable
add wave clk
add wave reset
add wave data_ready
add wave -radix float64 x
add wave -radix float64 y
add wave -radix float64 L1Double
add wave -radix float64 L2Double
add wave MultBegin
#add wave -radix float64 cosineth12
#add wave -radix float64 sineth12
#add wave -radix float64 costh1
#add wave -radix float64 sineth1


force clk 0 @ 0, 1 @ 5 -r 10
force th1 9'b000101101 @ 20
force th2 9'b000101101 @ 20

force l1 32'd7447 @ 0
force l2 32'd8936 @ 0

force reset 1 @ 0, 0 @ 15

force enable 1 @ 0


run 500