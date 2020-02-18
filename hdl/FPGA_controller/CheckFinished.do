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

add wave -radix float64 x_added
add wave -radix float64 y_added
add wave -radix float64 x_added_temp
add wave -radix float64 y_added_temp


add wave AbsCompReset

add wave add_done_y
add wave add_done_x

#add wave out_abs_ready
#add wave out_rel_ready

add wave compReadyAbs

add wave -format Logic add_done_abs

force clk 0 @ 0, 1 @ 5 -r 10

force enable 0 @ 0, 1 @ 15, 0 @ 250, 1 @ 260, 0 @ 600, 1 @ 650, 0 @ 900, 1 @ 1000
force reset 1 @ 0, 0 @ 15, 1 @ 250, 0 @ 260, 1 @ 600, 0 @ 650, 1 @ 900, 0 @ 1000

force x_target 64'b0100000010110111011100000000000000000000000000000000000000000000 @ 0
force y_target 64'b0100000010110111011100000000000000000000000000000000000000000000 @ 0

force x_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 250
force y_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 250

force x_target 64'b0100000001001001000000000000000000000000000000000000000000000000 @ 650
force y_target 64'b0100000001001001000000000000000000000000000000000000000000000000 @ 650

force x_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 1000
force y_target 64'b0100000010111000001110000000000000000000000000000000000000000000 @ 1000

force x_current 64'b0100000010110111101000100000000000000000000000000000000000000000 @ 0

force y_current 64'b0100000010110111101000100000000000000000000000000000000000000000 @ 0

force relative_target 0 @ 0, 1 @ 650

run 1500