import math
from enum import Enum
import pygcode as pygc
import Sim.scara_ik as ik
import matplotlib.pyplot as plt
import logging as logger
# Commands are formatted like so:
# |code|argX|argY|
# 0    3   17    31
# code is an integer from 0 to 8 representing a specific G/M code
# Each argument is in terms of a fraction of an 11 in or 279.4 mm sheet of paper
# ArgX may also represent a T argument for the relevant codes


## For logging functionality
logger.basicConfig(level=logger.CRITICAL)

# Constants
class Mode(Enum):
    ABSOLUTE = 1
    RELATIVE = 2


# Bits per section
CODE_BITS = 4
ARG_BITS = 14

# Offsets
CODE_OFFSET = 0
ARGX_OFFSET = CODE_OFFSET + CODE_BITS
ARGY_OFFSET = ARGX_OFFSET + ARG_BITS

# Conversion
IN_TO_MM = 25.4

MAX_IN = 22  # in
MAX_MM = MAX_IN * IN_TO_MM  # mm

MIN_IN = 4
MIN_MM = MIN_IN * IN_TO_MM

IN_TO_BITS = 2 ** (ARG_BITS) / MAX_IN  # bits/in
MM_TO_BITS = 2 ** (ARG_BITS) / MAX_MM  # bits/mm

Y_BIAS = 0 * IN_TO_BITS
X_BIAS = 0 * IN_TO_BITS  # 4*IN_TO_BITS

# Y_LIMIT = 4 * IN_TO_BITS
# X_LIMIT = 4 * IN_TO_BITS

# Arm parameters
JOINT_1_LENGTH = 5.55 * IN_TO_BITS
JOINT_2_LENGTH = 9.25 * IN_TO_BITS

# Maximum steps
INTERPOLATION_LENGTH = (1/8) * IN_TO_BITS#1 * IN_TO_BITS

# Set arm to be at 45 degree angles initially
INIT_X = JOINT_1_LENGTH * math.cos(math.pi / 4) + JOINT_2_LENGTH * math.cos(math.pi / 2)
INIT_Y = JOINT_1_LENGTH * math.sin(math.pi / 4) + JOINT_2_LENGTH * math.sin(math.pi / 2)

# Gcode to command map
GCODE_MAP = {str(pygc.GCodeRapidMove()): 0, str(pygc.GCodeLinearMove()): 1, str(pygc.GCodeUseInches()): 2,
             str(pygc.GCodeUseMillimeters()): 3, str(pygc.GCodeAbsoluteDistanceMode()): 4,
             str(pygc.GCodeIncrementalDistanceMode()): 5, str(pygc.GCodeEndProgram()): 6,
             str(pygc.GCodeToolChange()): 7, "M72": 8}

# Inverse command map useful decoding fpga commands
COMMAND_MAP = {v: k for k, v in GCODE_MAP.items()}

def signed(arg):
    arg = int(arg)
    if arg.bit_length() == ARG_BITS:
        arg = arg - 2 ** ARG_BITS
    return arg

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
        unit_to_bits, _, _ = units
        conversion = 1 / unit_to_bits

    gcode += gcodeCommand + " "

    # shift to arguments
    command = command >> CODE_BITS
    if commandHasArgs(gcodeCommand):
        for argName in commandArgs(gcodeCommand):
            gcode += argName
            arg = (command & ((1 << ARG_BITS) - 1))

            # Argument is negative in ARG_BITS representation, invert it to be negative in int representation.
           # if arg.bit_length() == ARG_BITS:
            #    arg = arg - 2 ** ARG_BITS

            # Don't convert tool change units
            if gcodeCommand != str(pygc.GCodeToolChange()):
                argValue = arg * conversion
            else:
                argValue = arg

            gcode += str(argValue) + " "

            # shift to next argument
            command = command >> ARG_BITS
    return (gcode, conversion)


def commandsToGcode(commands):
    '''
    Convert a set of commands to gcode strings
    @param commands: An orderded set of command codes
    @return: A gcode string
    '''
    print("commandsToGcode")
    program = []
    conversion = 1 #/ IN_TO_BITS

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


def gcodeToCommands(gcodeText, useArcInterpolation = False):
    '''
    Convert gcode text to a list of commands. Throws exceptions if there are errors in the gcode.
    @param gcodeText:
    @return:

    '''
    logger.debug("Joint lengths (1,2): ({}, {})".format(JOINT_1_LENGTH, JOINT_2_LENGTH))
    arm = None
    if useArcInterpolation:
        arm = ik.SCARA_IK(([JOINT_1_LENGTH, JOINT_2_LENGTH]))

    lines = gcodeText.split("\n");
    parsedLines = list(map(pygc.Line, lines))
    commands = []

    # Assumed starting state
    max = MAX_IN
    min = MIN_IN
    conversion = IN_TO_BITS
    positioning = Mode.ABSOLUTE

    # Arm starts with both joints at 45 degree angle
    xPos = INIT_X
    yPos = INIT_Y

    for gcodeLine in parsedLines:
        for gcode in gcodeLine.gcodes:
            command = 0

            cmd = str(gcode.word)

            # check if command changes units
            units = commandUnits(cmd)
            print("Units: {}".format(units))
            if units:
                conversion, max, min = units
            logger.debug("Conversion: " + str(conversion))
            # Get enumeration value of cmd
            code = commandToCode(cmd)

            if commandMovesLinear(cmd) and len(gcode.params) > 0:

                xNew = noMove(xPos, positioning)
                yNew = noMove(yPos, positioning)

                if "X" in gcode.params:
                    xNew = paramToArg(gcode.params["X"].value, conversion, min, max, positioning)
                if "Y" in gcode.params:
                    yNew = paramToArg(gcode.params["Y"].value, conversion, min, max, positioning)
                xEnd = increment(xPos, xNew, positioning, 0)
                yEnd = increment(yPos, yNew, positioning, 0)
                print("start: " + str((xPos * 1/conversion, yPos * 1/conversion)))
                print("end: " + str((xEnd * 1/conversion, yEnd * 1/conversion)))
                if useArcInterpolation:
                    arm.set_target(xEnd, yEnd)
                    logger.info("Computing the angles to move to ({}, {})".format(xEnd, yEnd))
                    points = arm.geometric_method()
                # Linear moves must be split into a number of smaller segments for the arm to retain accuracy
                #commands += interpolateLinear(code, xPos, yPos, xEnd, yEnd, INTERPOLATION_LENGTH, positioning)#interpolate(code, INTERPOLATION_LENGTH, positioning, points)
                    logger.debug("Points:\n{}".format(points))
                    newCommand = interpolate(code, INTERPOLATION_LENGTH, positioning, points)
                    logger.debug("new command type: {}".format(type(newCommand)))
                    logger.debug("commands type: {}".format(type(commands)))

                    if type(newCommand) is type(None):
                        logger.critical("The new command is NoneType!!")
                    if type(commands) is type(None):
                        logger.critical("The commands list cannot be of type \"NoneType\"")
                    commands = commands + newCommand
                else:
                    commands += interpolateLinear(code, xPos, yPos, xEnd, yEnd, INTERPOLATION_LENGTH, positioning)
                xPos = xEnd
                yPos = yEnd
            # for key in gcode.params:
            #     offset = ARGX_OFFSET if key == "X" or key == "T" else ARGY_OFFSET
            #     if key != "T":
            #         command |= extractArg(gcode.params[key].value, conversion, min, max, positioning, offset)

                    # command |= extractArg(gcode.params[key].value, 1, 2 ** ARG_BITS, offset)

            else:

                if cmd == str(pygc.GCodeToolChange()):
                    if "T" in gcode.params:
                        command |= extractArg(gcode.params["T"].value, 1, 0, 2 ** ARG_BITS, positioning, ARGX_OFFSET)
                if cmd == str(pygc.GCodeIncrementalDistanceMode()):
                    positioning = Mode.RELATIVE
                if cmd == str(pygc.GCodeAbsoluteDistanceMode()):
                    positioning = Mode.ABSOLUTE
                command |= code << CODE_OFFSET
                commands.append(command)
    else:
        if gcodeLine.text == "M72":
            code = GCODE_MAP["M72"]
            commands.append(createCommand(code, 0, 0))

    return commands


###Functions that describe how the machine operates in ABSOLUTE and RELATIVE mode

def noMove(value, mode: Mode):
    '''
    What "zero" movement  means in the context of mode
    @param value:
    @param mode: RELATIVE or ABSOLUTE
    @return:
    '''
    return value if mode == Mode.ABSOLUTE else 0


def increment(value, newValue, mode: Mode, bias):
    '''
    What position the machine will be in when positioned at value, is moved to newValue, depending on the mode.
    @param value:
    @param newValue:
    @param mode:
    @return:
    '''
    print("increment mode: " + str(mode))
    return newValue + bias if mode == Mode.ABSOLUTE else value + newValue


###

def createCommand(code, xArg, yArg):
    '''
    Create an FPGA command
    @param code: command code in GCODE_MAP
    @param xArg: int size below ARG_BITS
    @param yArg: int size below ARG_BITS
    @return:
    '''
    return code | (xArg << ARGX_OFFSET) | (yArg << ARGY_OFFSET)

xData = []
yData = []
def interpolateLinear(code, xStart, yStart, xEnd, yEnd, segLength, mode):
    '''
    Split line (xStart, yStart), (xEnd, yEnd) into a number of segments sized segLength or less and return them as commands with the code code.
    @param code: Command code
    @param xStart: Starting x point
    @param yStart: Starting y point
    @param xEnd: Ending x point
    @param yEnd: Ending y point
    @param segLength: Maximum size of segment
    @param mode: ABSOLUTE or RELATIVE
    @return: List of move commands that draw the line in increments of segLength
    '''
    commands = []
    xDelta = xEnd - xStart
    yDelta = yEnd - yStart

    hypotenuse = math.sqrt(xDelta ** 2 + yDelta ** 2)

    div = math.ceil(hypotenuse / segLength)
    xInc = xDelta / div
    yInc = yDelta / div

    extra = hypotenuse - (segLength * div)

    if extra < 0:
        div -= 1

    if mode == Mode.ABSOLUTE:
        xCurrent = xStart
        yCurrent = yStart
        xData.append(xStart)
        yData.append(yStart)
        for i in range(0, div):

            xCurrent += xInc
            yCurrent += yInc
            xData.append(xCurrent)
            yData.append(yCurrent)
            commands.append(createCommand(code, int(xCurrent), int(yCurrent)))
        commands.append(createCommand(code, int(xEnd), int(yEnd)))
    else:
        for i in range(0, div):
            commands.append(createCommand(code, int(xInc), int(yInc)))
        angle = math.atan2(yDelta, xDelta)
        extraIncX = math.cos(angle) * extra
        extraIncY = math.sin(angle) * extra
        commands.append(createCommand(code, int(extraIncX), int(extraIncY)))
    return commands

def interpolate(code, segLength, mode, points):
    '''
    Split line (xStart, yStart), (xEnd, yEnd) into a number of segments sized segLength or less and return them as commands with the code code.
    @param code: Command code
    @param xStart: Starting x point
    @param yStart: Starting y point
    @param xEnd: Ending x point
    @param yEnd: Ending y point
    @param segLength: Maximum size of segment
    @param mode: ABSOLUTE or RELATIVE
    @return: List of move commands that draw the line in increments of segLength
    '''
    commands = []
    logger.debug(">> Segment Length: {}".format(segLength))
    logger.debug(">> Points: {}".format(points))
    logger.debug("Type of code: {}, segLength: {}, mode: {}, points: {}".format(type(code), type(segLength), type(mode), type(points))) 
    for i in range(0, len(points)): #, int(segLength)):
        logger.info("({}, {})".format(points[i][0], points[i][1]))
        xData.append(points[i][0])
        yData.append(points[i][1])
        newCommand = createCommand(code, int(points[i][0]) , int(points[i][1]))
        logger.info("Bitwise GCode: {0:b}".format(newCommand))
        commands.append(newCommand) #createCommand(code, int(points[i][0]) , int(points[i][1])))
    return commands


def commandHasArgs(code):
    '''
    True if given gcode code has arguments attached to it
    @param code:
    @return:
    '''
    return code == str(pygc.GCodeLinearMove()) or code == str(pygc.GCodeRapidMove()) or code == str(
        pygc.GCodeToolChange())


def commandMovesLinear(code):
    '''
    True if given code moves the arm linearly
    @param code:
    @return:
    '''
    return code == str(pygc.GCodeLinearMove()) or code == str(pygc.GCodeRapidMove())


def commandArgs(code):
    '''
    Arguments in order of position in command code for given code. If code has no args returns None
    @param code:
    @return:
    '''
    if code == str(pygc.GCodeRapidMove()) or code == str(pygc.GCodeLinearMove()):
        return ("X", "Y")
    if code == str(pygc.GCodeToolChange()):
        return ("T")


def commandUnits(code):
    '''

    @param code:
    @return: (conversion factor, max value) for given gcode code if code converts units, None otherwise.
    '''
    if code == str(pygc.GCodeUseInches()):
        return (IN_TO_BITS, MAX_IN, MIN_IN)
    if code == str(pygc.GCodeUseMillimeters()):
        return (MM_TO_BITS, MAX_MM, MIN_MM)
    return None


def paramToArg(value, conversion, min, max, mode):
    '''
    Convert a value in units that is at most max to a value in units * conversion that is at most 2**ARG_BITS
    @param value:
    @param conversion:
    @param max:
    @return:
    '''
    decimal = float(value)
    print("decimal: " + str(decimal))
    # Clamp to maximum
    decimal = math.copysign(max, decimal) if abs(decimal) > max else decimal

    # Clamp to minimum
    # if mode == Mode.ABSOLUTE:
    #     decimal = math.copysign(min, decimal) if abs(decimal) < min else decimal

    # Convert in/mm to bit/in or bit/mm
    decimal *= conversion

    # Constrain integer to be within the bit space
    integer = int(decimal) & ((2 ** ARG_BITS) - 1)
    return integer


def extractArg(value, conversion, min, max, mode, offset):
    '''
    Returns a converted value at the appropriate offset
    @param value:
    @param conversion:
    @param max:
    @param offset:
    @return:
    '''
    integer = paramToArg(value, conversion, min, max, mode)
    arg = (integer) << offset

    return arg


def commandToCode(code):
    '''
    Given a code in the format <G|M><number> return the appropriate command number.

    @param code:
    @return:
    '''
    if code in GCODE_MAP:
        return GCODE_MAP[code]
    else:
        raise Exception("Invalid code: {c}".format(c=code))


# test code
if __name__ == '__main__':

    gcodeFile = open("test.gcode", "r")

    gcode = gcodeFile.read()
    print(gcode)
    commands = gcodeToCommands(gcode, True)
    xData = [x * 1/IN_TO_BITS for x in xData]
    yData = [y * 1/IN_TO_BITS for y in yData]

    plt.plot(xData, yData)
    plt.show()
    reverseGcode = commandsToGcode(commands)

    print(reverseGcode)

