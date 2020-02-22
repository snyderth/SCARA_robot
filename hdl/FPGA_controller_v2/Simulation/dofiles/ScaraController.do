vlog -work work ../Functions/ForwardKinematics.sv
vlog -work work ../Functions/CalculateAngles.sv
vlog -work work ../Functions/CalculateSteps.sv
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


force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15
force xTarget 14'd2797 @ 0
force yTarget 14'd2797 @ 0
force controlStateReg 5'b00001 @ 0

run 10000