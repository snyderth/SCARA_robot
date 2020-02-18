vlog -work work Adder.v
vlog -work work DoubleAdder.sv
vlog -work work DoubleComparator.v
vlog -work work CheckFinished.sv

vsim -L 220model work.CheckFinished

add wave -format Logic clk
add wave -format Logic enable
add wave -format Logic reset
add wave -format Logic relative_target
 
add wave -radix float64 x_target
add wave -radix float64 y_target
add wave -radix float64 x_current
add wave -radix float64 y_current

add wave -format Logic AtTarget
add wave -format Logic ready

add wave state

add wave y_less_thresh_rel
add wave x_less_thresh_rel

add wave y_less_thresh_abs
add wave x_less_thresh_abs

add wave add_done_abs
add wave AbsCompReset

add wave out_abs_ready
add wave out_rel_ready

add wave -format Logic add_done_abs

force clk 0 @ 0, 1 @ 5 -r 10

force enable 0 @ 0, 1 @ 15, 0 @ 200
force reset 1 @ 0, 0 @ 15, 1 @ 200

force x_target 64'b0100000010110111011100000000000000000000000000000000000000000000 @ 0
force y_target 64'b0100000010110111011100000000000000000000000000000000000000000000 @ 0

force x_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 300
force y_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 300

force x_current 64'b0100000010110111101000100000000000000000000000000000000000000000 @ 0

force y_current 64'b0100000010110111101000100000000000000000000000000000000000000000 @ 0

force relative_target 0 @ 0

run 500