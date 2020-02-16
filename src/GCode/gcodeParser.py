import math
from enum import Enum
from gcodeFormatter import *
import pygcode as pygc
#Commands are formatted like so:
#|code|argX|argY|
#0    3   17    31
#code is an integer from 0 to 8 representing a specific G/M code
#Each argument is in terms of a fraction of an 11 in or 279.4 mm sheet of paper
#ArgX may also represent a T argument for the relevant codes

#Constants
class Mode(Enum):
    ABSOLUTE = 1
    RELATIVE = 2
#Bits per section
CODE_BITS = 4
ARG_BITS = 14

#Offsets
CODE_OFFSET = 0
ARGX_OFFSET = CODE_OFFSET + CODE_BITS
ARGY_OFFSET = ARGX_OFFSET + ARG_BITS

#Conversion
MAX_IN = 11 #in
MAX_MM = 279.4 #mm
IN_TO_BITS = 2**(ARG_BITS)/MAX_IN #bits/in
MM_TO_BITS = 2**(ARG_BITS)/MAX_MM #bits/mm

#Arm parameters
JOINT_1_LENGTH = 5 * IN_TO_BITS
JOINT_2_LENGTH = 4 * IN_TO_BITS

#Maximum line length
INTERPOLATION_LENGTH = (1 / 16) * IN_TO_BITS

#Set arm to be at 45 degree angles initially
INIT_X = JOINT_1_LENGTH * math.cos(math.pi/4) + JOINT_2_LENGTH * math.cos(math.pi / 2)
INIT_Y = JOINT_1_LENGTH * math.sin(math.pi/4) + JOINT_2_LENGTH * math.sin(math.pi / 2)

#Gcode to command map
GCODE_MAP = {str(pygc.GCodeRapidMove()): 0, str(pygc.GCodeLinearMove()): 1, str(pygc.GCodeUseInches()): 2, str(pygc.GCodeUseMillimeters()): 3, str(pygc.GCodeAbsoluteDistanceMode()): 4, str(pygc.GCodeIncrementalDistanceMode()): 5, str(pygc.GCodeEndProgram()): 6, str(pygc.GCodeToolChange()): 7, "M72": 8}

#Inverse command map useful decoding fpga commands
COMMAND_MAP = {v: k for k, v in GCODE_MAP.items()}



def commandToGcode(command, conversion):
    '''
    Convert one command to gcode using the given conversion
    @param command: The command to convert
    @param conversion: The conversion factor
    @return: (gcode, conversion) conversion may be different if the command changes units.
    '''
    gcode = ""

    code = commandCode(command)
    gcodeCommand = COMMAND_MAP[code]

    units = commandUnits(gcodeCommand)
    if units != None:
        unit_to_bits, _ = units
        conversion = 1 / unit_to_bits

    gcode += gcodeCommand + " "

    command = command >> CODE_BITS
    if commandHasArgs(gcodeCommand):
        for argName in commandArgs(gcodeCommand):
            gcode += argName
            arg = (command & ((1 << ARG_BITS) - 1))

            # Argument is negative in ARG_BITS representation, invert it to be negative in int representation.
            if arg.bit_length() == ARG_BITS:
                arg = arg - 2**ARG_BITS

            if gcodeCommand != str(pygc.GCodeToolChange()):
                argValue =  arg * conversion
            else:
                argValue = (command & ((1 << ARG_BITS) - 1))

            gcode += str(argValue) + " "

            command = command >> ARG_BITS
    return (gcode, conversion)

def commandsToGcode(commands):
    '''
    Convert a set of commands to gcode strings
    @param commands: An orderded set of command codes
    @return: A gcode string
    '''
    program = []
    conversion = 1 / IN_TO_BITS

    for command in commands:
        gcode, conversion = commandToGcode(command, conversion)

        program.append(gcode)
    return '\n'.join(program)


def commandCode(command: int):
    '''
    @param command:
    @return: code portion of command
    '''
    code = (command >> CODE_OFFSET) & ((1 << CODE_BITS) - 1)
    return code



def gcodeToCommands(gcodeText):
    '''
    Convert gcode text to a list of commands. Throws exceptions if there are errors in the gcode.
    @param gcodeText:
    @return:

    '''


    lines = gcodeText.split("\n");
    parsedLines = list(map(pygc.Line, lines))
    commands = []

    #Assumed starting state
    max = MAX_IN
    conversion = IN_TO_BITS
    positioning = Mode.ABSOLUTE

    #Arm starts with both joints at 45 degree angle
    xPos = INIT_X
    yPos = INIT_Y

    for gcodeLine in parsedLines:
        for gcode in gcodeLine.gcodes:
            command = 0

            cmd = str(gcode.word)

            #check if command changes units
            units = commandUnits(cmd)
            if units:
                conversion, max = units

            #Get enumeration value of cmd
            code = commandToCode(cmd)

            if commandMovesLinear(cmd) and len(gcode.params) > 0:


                xNew = noMove(xPos, positioning)
                yNew = noMove(yPos, positioning)

                if "X" in gcode.params:
                    xNew = paramToArg(gcode.params["X"].value, conversion, max)
                if "Y" in gcode.params:
                    yNew = paramToArg(gcode.params["Y"].value, conversion, max)


                xEnd = increment(xPos, xNew, positioning)
                yEnd = increment(yPos, yNew, positioning)

                #Linear moves must be split into a number of smaller segments for the arm to retain accuracy
                commands += interpolate(code, xPos, yPos, xEnd, yEnd, INTERPOLATION_LENGTH, positioning)

                xPos = xEnd
                yPos = yEnd

            else:
                if cmd == str(pygc.GCodeToolChange()):
                    for key in gcode.params:
                        command |= extractArg(gcode.params[key].value, 1, 2 ** ARG_BITS, ARGX_OFFSET)
                command |= code << CODE_OFFSET
                commands.append(command)
    return commands

#Functions that describe how the machine operates in ABSOLUTE and RELATIVE mode
def noMove(value, mode: Mode):
    '''
    What "zero" movement  means in the context of mode
    @param value: 
    @param mode: RELATIVE or ABSOLUTE
    @return: 
    '''
    return value if mode == Mode.ABSOLUTE else 0

def increment(value, newValue, mode: Mode):
    '''
    What position the machine will be in when positioned at value, is moved to newValue, depending on the mode.
    @param value:
    @param newValue:
    @param mode:
    @return:
    '''
    return newValue if mode == Mode.ABSOLUTE else value + newValue

def createCommand(code, xArg, yArg):
    return code | (xArg << ARGX_OFFSET) | (yArg << ARGY_OFFSET)

def interpolate(code, xStart, yStart, xEnd, yEnd, segLength, mode):
    commands = []

    xDelta = xEnd - xStart
    yDelta = yEnd - yStart

    hypotenuse = math.sqrt(xDelta**2 + yDelta**2)
    angle = math.atan2(yDelta, xDelta)


    if mode == Mode.ABSOLUTE:
        xCurrent = xStart
        yCurrent = yStart
        for i in range(0, int(hypotenuse // segLength)):
            #Make the length of the line segment be the segment length or the remainder of the hypotenuse smaller than the segment length
            segHypotenuse = min(segLength, hypotenuse - (segLength * i + 1))
            xInc = segHypotenuse * math.cos(angle)
            yInc = segHypotenuse * math.sin(angle)

            xCurrent += xInc
            yCurrent += yInc

            commands.append(createCommand(code, int(xCurrent), int(yCurrent)))
    else:
        for i in range(0, int(hypotenuse // segLength)):
            # Make the length of the line segment be the segment length or the remainder of the hypotenuse smaller than the segment length
            segHypotenuse = segLength if hypotenuse - (segLength * i + 1) > segLength else hypotenuse - (segLength * i + 1)
            xInc = segHypotenuse * math.cos(angle)
            yInc = segHypotenuse * math.sin(angle)

            commands.append(createCommand(code, int(xInc), int(yInc)))

    return commands



#True if given gcode code has arguments attached to it
def commandHasArgs(code):
    return code == str(pygc.GCodeLinearMove()) or code == str(pygc.GCodeRapidMove()) or code == str(pygc.GCodeToolChange())

#True if given code moves the arm linearly
def commandMovesLinear(code):
    return code == str(pygc.GCodeLinearMove()) or code == str(pygc.GCodeRapidMove())

def commandArgs(code):
    if code == str(pygc.GCodeRapidMove()) or code == str(pygc.GCodeLinearMove()):
        return ("X", "Y")
    if code == str(pygc.GCodeToolChange()):
        return ("T")

#Returns (conversion factor, max value) for given gcode code if code converts units, None otherwise.
def commandUnits(code):
    if code == str(pygc.GCodeUseInches()):
        return (IN_TO_BITS, MAX_IN)
    if code == str(pygc.GCodeUseMillimeters()):
        return (MM_TO_BITS, MAX_MM)
    return None

def paramToArg(value, conversion, max):
    decimal = float(value)

    # Clamp to maximum
    decimal = math.copysign(max, decimal) if abs(decimal) > max else decimal

    # Convert in/mm to bit/in or bit/mm
    decimal *= conversion

    # Constrain integer to be within the bit space
    integer = int(decimal) & (2 ** ARG_BITS - 1)
    return integer

#Given a string in the format <x | y | t> <number>.<number>, return an argument value at the approprate offset
def extractArg(value, conversion, max, offset):

    integer = paramToArg(value, conversion, max)
    arg = (integer) << offset

    return arg

#Given a code in the format <G|M><number> return the appropriate command number.
def commandToCode(code):
    if code in GCODE_MAP:
        return GCODE_MAP[code]
    else:
        raise Exception("Invalid code: {c}".format(c = code))

#test code
if __name__ == '__main__':

    gcodeFile = open("../../test.gcode", "r")

    gcode = gcodeFile.read()

    commands = gcodeToCommands("G01 X4.0 Y8.0")

    reverseGcode = commandsToGcode(commands)

    print(reverseGcode)

