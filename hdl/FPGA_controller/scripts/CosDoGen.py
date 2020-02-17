bin9 = lambda x : ''.join(reversed( [str((x >> i) & 1) for i in range(9)] ) )

with open("CosDeg.do", "w+") as dofile:
    dofile.write("vlog -work work CosDeg.sv\n")
    dofile.write("vsim work.CosDeg\n")
    dofile.write("add wave -radix signed data_in\nadd wave -radix float64 data_out\n")
    dofile.write("force data_in ")
    for i in range(-180,180,1):
        if(i >= 0 and i < 180):
            dofile.write("9'b{:09b} @ {}, ".format(i, (i + 180) * 10))
        elif i < 0:
            dofile.write("9'b{} @ {}, ".format(bin9(i), (i + 180) * 10))
        
    dofile.write("9'b{:09b} @ {}\n".format(180, (180+180)*10))
    dofile.write("\nrun 5000")


with open("SinDeg.do", "w+") as dofile:
    dofile.write("vlog -work work SinDeg.sv\n")
    dofile.write("vsim work.SinDeg\n")
    dofile.write("add wave -radix signed data_in\nadd wave -radix float64 data_out\n")
    dofile.write("force data_in ")
    for i in range(-180,180,1):
        if(i >= 0 and i < 180):
            dofile.write("9'b{:09b} @ {}, ".format(i, (i + 180) * 10))
        elif i < 0:
            dofile.write("9'b{} @ {}, ".format(bin9(i), (i + 180) * 10))
        
    dofile.write("9'b{:09b} @ {}\n".format(180, (180+180)*10))
    dofile.write("\nrun 5000")