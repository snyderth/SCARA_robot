vlog -work work MatMult.sv
vlog -work work Jacobian.sv
vlog -work work JacobianInverse.sv
vlog -work work ForwardKinematics.sv
vlog -work work DegToSteps.sv
vlog -work work scara_controller.sv
vlog -work work Int14BitToDouble.v
vlog -work work DoubleTo14BitInt.v
vlog -work work DoubleTo9BitInt.v

vsim -L lpm_ver -L 220model -L altera_mf_ver work.scara_controller

add wave -radix float64 x_current
add wave -radix float64 y_current
add wave -radix unsigned x_target
add wave -radix unsigned y_target
add wave -format Logic control_state_reg
add wave -radix signed th1
add wave -radix signed th2
add wave -format Logic clk
add wave -format Logic reset
add wave -radix float64 m1_steps
add wave -radix float64 m2_steps
add wave -format Logic dir1
add wave -format Logic dir2


add wave -radix float64 scara_controller/fk/costh1
add wave -radix float64 scara_controller/fk/cosineth12
add wave -radix float64 scara_controller/fk/sineth1
add wave -radix float64 scara_controller/fk/sineth12


add wave -radix float64 scara_controller/jk/cos_th1
add wave -radix float64 scara_controller/jk/cos_th12
add wave -radix float64 scara_controller/jk/sin_th1
add wave -radix float64 scara_controller/jk/sin_th12


add wave -radix float64 changeTh1
add wave -radix float64 changeTh2

add wave count
add wave state
add wave next_state

add wave CONVDone
add wave -radix signed dth2
add wave -radix signed dth1

add wave -format Logic MULTDone

force clk 0 @ 0, 1 @ 5 -r 10
force reset 1 @ 0, 0 @ 30

force x_target 14'd6000 @ 0, 14'd1362 @ 5000
force y_target 14'd14000 @ 0, 14'd14262 @ 5000

#force th1 9'd45 @ 0
#force th2 9'd45 @ 0

force stepper_ready 1 @ 1500
force control_state_reg 5'b00000 @ 0, 5'b00001 @ 50

run 100000