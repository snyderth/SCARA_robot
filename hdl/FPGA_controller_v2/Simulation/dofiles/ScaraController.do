#vlog -work work ../Conversions/*v
#vlog -work work ../Arithmetic/FloatAdder/FloatAdder.v
#vlog -work work ../Arithmetic/SinCos/Sine.v
#vlog -work work ../Arithmetic/SinCos/Cosine.v
#vlog -work work ../Arithmetic/SqRoot/*v
#vlog -work work ../Functions/CosineTh2.sv
#vlog -work work ../Functions/SineTh2.sv
#vlog -work work ../Arithmetic/Inverter/Inverter.v
#vlog -work work ../Functions/ForwardKinematics.sv
#vlog -work work ../Functions/CalculateAngles.sv
#vlog -work work ../Functions/CalculateSteps.sv
vlog -work work ../ScaraController.sv


vsim -L lpm_ver -L altera_mf_ver work.ScaraController

radix define fixed13 -fixed -signed -fraction 10

add wave state

add wave controlStateReg
add wave -radix signed xTarget
add wave -radix signed yTarget
add wave stepperReady
add wave enable
add wave clk
add wave reset

add wave -radix unsigned steps1
add wave -radix unsigned steps2

add wave -radix fixed13 th1Target
add wave -radix fixed13 th2Target

add wave -radix fixed13 theta1Diff
add wave -radix fixed13 theta2Diff

add wave -radix fixed13 th1Current
add wave -radix fixed13 th2Current


add wave dir1
add wave dir2

add wave endEffectorState
add wave dataReady

add wave AnglesDone
add wave AnglesEn

force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15, 0 @ 40, 1 @ 2900, 0 @ 3000, 1 @ 10100, 0 @ 10200
force reset 1 @ 0, 0 @ 15
force xTarget 14'd7222 @ 0
force yTarget 14'd8340 @ 0
force controlStateReg 5'b00001 @ 0, 5'b01001 @ 4000, 5'b00001 @ 4500, 5'b10000 @ 10000



run 3500