from HPS_to_FPGA.CommandCodeStreamer import *
from GCode.gcodeParser import *

if __name__ == "__main__":
    #gcodeFile = open("test.gcode", "r")

    gcode = "G01 X15.0 Y15.0"#gcodeFile.read()

    commands = gcodeToCommands(gcode)

    streamProcess(commands, lambda x: print(commandToGcode(x, 1)), lambda : print("done"), lambda b,x: print(b))
