from Vision.vision import asGCode
from HPS_to_FPGA.CommandCodeStreamer import streamProcess
from GCode.gcodeParser import commandToGcode, gcodeToCommands, commandCode, COMMAND_MAP
from functools import partial

def streamFromImage(img, colorPalette, granularity, maxLines, paperSize, reportDone, reportSend, reportSent):
    '''
    Send gcode to the fpga derived from an image
    @param reportSend: Function in the format (int)->None that reports when a value is about to be sent
    @param reportSent: Function in the format (bool, int)->None that reports when a value has been sent, and if it was succe,ssful or not.
    @param reportDone: Function in the format ()->None that reports when the FPGA is done executing
    '''
    gcode = asGCode(img, colorPalette, granularity, maxLines, paperSize)
    __stream(gcode, reportDone, reportSend, reportSent)

def streamFromGcode(gcode, reportDone, reportSend, reportSent):
    '''
    Send gcode to the fpga
    '''
    __stream(gcode, reportDone, reportSend, reportSent)


def reportSendWhenCommand(handler, command):
    '''
    reportSend handler that checks when the code about to be sent is a specific command
    @param handler: Function in the format (str)->None that is given the gcode command that matches the command code (in bits/unit format)
    '''
    return partial(__whenCommand, handler, command)

def giveCommand(handler):
    return partial(__asCommand, handler)

def __asCommand(handler, code):
    gcode = commandToGcode(code, 1)
    handler(gcode)


def __whenCommand(handler, command, code):
    code = commandCode(code)
    gcodeCommand = COMMAND_MAP[code]


    if gcodeCommand == command:
        gcode = commandToGcode(code, 1)
        handler(gcode)


def __stream(gcode, reportDone, reportSend, reportSent):
    commands = gcodeToCommands(gcode)
    streamProcess(commands, reportDone, reportSend, reportSent)
