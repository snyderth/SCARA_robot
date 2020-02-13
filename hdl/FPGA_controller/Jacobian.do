vlog -work work Jacobian.sv
vlog -work work ClockTimer.sv
vlog -work work DoubleMultiply.sv
vlog -work work MultiplierFP.v
vlog -work work Adder.v
vlog -work work DoubleAdder.sv
vlog -work work CosDeg.sv
vlog -work work SinDeg.sv
vlog -work work IntToDouble.v

#vsim -L "C:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.Jacobian
vsim -L "Z:/home/thomas/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/220model" work.Jacobian


add wave -radix float64 dx_dth1
add wave -radix float64 dx_dth2
add wave -radix float64 dy_dth1
add wave -radix float64 dy_dth2

add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic reset
add wave -format Logic data_ready

add wave -radix Decimal l1
add wave -radix Decimal l2
# Two's Complement representation
add wave -radix Signed th1
add wave -radix Signed th2  

add wave -Logic addR1
add wave -Logic addR2
add wave MultComplete

add wave ready1
add wave ready2
add wave ready3
add wave ready4

add wave ConvComplete

add wave -radix float64 L1Double
add wave -radix float64 L2Double

add wave -radix float64 l1Cos
add wave -radix float64 l2CosSum
add wave -radix float64 l1Sin
add wave -radix float64 l2SinSum

add wave -radix float64 cos_th1
add wave -radix float64 sin_th1
add wave -radix float64 sin_th12
add wave -radix float64 cos_th12

add wave -Logic en
add wave -Logic ConvStart

add wave -radix Decimal count

# Perform Simulation

force clk 0 @ 0, 1 @ 5 -r 10

force th1 9'd45 @ 20
force th2 9'd45 @ 20

force enable 0 @ 0, 1 @ 20, 0 @ 40
force reset 1 @ 0, 0 @ 12

force l1 32'd8936 @ 0
force l2 32'd7447 @ 0

run 2000