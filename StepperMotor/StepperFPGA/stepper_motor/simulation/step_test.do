vsim work.stepper_motor

add wave /stepper_motor/*

force /stepper_motor/clk_50 0 @ 0, 1 @ 10 -r 20
force /stepper_motor/reset_n 0 @ 0, 1 @ 100
force /stepper_motor/new_in 0 @ 0, 1 @ 140, 0 @ 200
force /stepper_motor/num_steps 0 @ 0, 8 @ 60
force /stepper_motor/direction 1
force /stepper_motor/enable 1

run 10 ms

force /stepper_motor/num_steps 4
force /stepper_motor/direction 0

run 10 ms

force /stepper_motor/new_in 1

run 100

force /stepper_motor/new_in 0

run 10 ms