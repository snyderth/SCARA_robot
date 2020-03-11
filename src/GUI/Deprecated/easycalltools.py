from functools import partial
from GCode.gcodeParser import commandToGcode, gcodeToCommands, commandCode, COMMAND_MAP

def __asCommand(handler, code):
    gcode = commandToGcode(code, 1)
    handler(gcode)


def giveCommand(handler):
    return partial(__asCommand, handler)
