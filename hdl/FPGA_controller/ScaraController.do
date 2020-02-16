vlog -work work MatMult.sv
vlog -work work Jacobian.sv
vlog -work work JacobianInverse.sv
vlog -work work ForwardKinematics.sv
vlog -work work DegToSteps.sv
vlog -work work scara_controller.sv

vsim -L lpm_ver -L 220model -L altera_mf_ver work.scara_controller

