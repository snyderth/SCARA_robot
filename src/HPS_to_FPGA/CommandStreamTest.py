from HPS_to_FPGA.CommandCodeStreamer import *
from GCode.gcodeParser import *

if __name__ == "__main__":
    gcodeFile = open("../../test.gcode", "r")

    gcode = gcodeFile.read()

    commands = gcodeToCommands(gcode)

    streamProcess(commands, lambda x: print(x), lambda : print("done"))