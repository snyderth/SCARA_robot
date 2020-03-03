from HPS_to_FPGA.CommandCodeStreamer import *
from GCode.gcodeParser import *
def main():
       gcodeFile = open("test.gcode", "r")
    

       gcode = gcodeFile.read()
       print(gcode)
       print("parsing")
       commands = gcodeToCommands(gcode)
       print("sending")
       streamProcess(commands,lambda _: print("done"), lambda x: print(commandToGcode(x, 1)), lambda s,x: print(s))

if __name__ == "__main__":
    main()
