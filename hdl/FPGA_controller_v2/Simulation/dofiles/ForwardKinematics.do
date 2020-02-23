vlog -work work ../Conversions/*.v
vlog -work work ../Arithmetic/SinCos/Cosine.v
vlog -work work ../Arithmetic/SinCos/Sine.v
vlog -work work ../Arithmetic/FloatAdder/FloatAdder.v
vlog -work work ../Functions/ForwardKinematics.sv

vsim -L lpm_ver work.ForwardKinematics

radix define fixed13 -fixed -signed -fraction 10

add wave state
add wave clk
add wave enable
add wave reset
add wave -radix unsigned x
add wave -radix unsigned y
add wave -radix fixed13 theta1
add wave -radix fixed13 theta2

add wave -radix float64 l1
add wave -radix float64 l2
add wave dataReady

add wave ConvThToFloatEn
add wave ConvThToFloatDone
add wave -unsigned cnt
add wave -radix float32 Th1Float
add wave -radix float32 Th2Float

add wave -radix float32 SummedThetas

#add wave -radix float32 sinSum
#add wave -radix float32 cosineSum
#add wave -radix float32 sinth1
#add wave -radix float32 costh1 
#
#add wave -radix float64 sinSumDouble
#add wave -radix float64 cosineSumDouble
#add wave -radix float64 sinth1Double
#add wave -radix float64 costh1Double

add wave -radix float64 l1CosTh1
add wave -radix float64 l2CosThSum
add wave -radix float64 l1SinTh1
add wave -radix float64 l2SinThSum


add wave addxDone
add wave addyDone
add wave -radix float64 xDouble
add wave -radix float64 yDouble

add wave TrigFuncDone
add wave TrigFuncEn
add wave TrigState
add wave TrigFunctionDone
add wave -radix unsigned count
add wave -radix float32 CosInput
add wave -radix float32 SinInput
add wave -radix float32 SinResult
add wave -radix float32 CosResult

add wave Theta1TrigEn
add wave SummedTrigEn



force clk 0 @ 0, 1 @ 5 -r 10
force enable 0 @ 0, 1 @ 15
force reset 1 @ 0, 0 @ 15
force theta1 13'b1100110111010 @ 0
force theta2 13'b0101110001101 @ 0

force l2 64'b0100000011000111010001011101000101110100010111001100100100101110 @ 0
force l1 64'b0100000011000000101110100010111010001011101000101110000011101011 @ 0

run 2000