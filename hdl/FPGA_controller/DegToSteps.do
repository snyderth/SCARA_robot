vlog -work work DoubleDivider.sv
vlog -work work DegToSteps.sv

vsim -L 220model -L altera_mf_ver -L lpm_ver work.DegToSteps

add wave -radix float64 dth1
add wave -radix float64 dth2
add wave -radix float64 steps1
add wave -radix float64 steps2
add wave -radix float64 s1Res
add wave -radix float64 s2Res

add wave -format Logic clk
add wave -format Logic en
add wave -format Logic reset
add wave -format Logic dir1
add wave -format Logic dir2


force clk 0 @ 0, 1 @ 5 -r 10
force en 0 @ 0, 1 @ 30
force reset 1 @ 0, 0 @ 20
force dth1 64'h3FFCCCCCCCCCCCCD @ 0
force dth2 64'hBFFCCCCCCCCCCCCD @ 0


run 500