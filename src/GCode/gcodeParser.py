import math
from gcodeFormatter import *
import pygcode as pygc
#Commands are formatted like so:
#|code|argX|argY|
#0    3   17    31
#code is an integer from 0 to 8 representing a specific G/M code
#Each argument is in terms of a fraction of an 11 in or 279.4 mm sheet of paper
#ArgX may also represent a T argument for the relevant codes

#Constants

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
TOOL_TO_BITS = 1

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
    #Format gcode to remove whitespace, convert to lower case, and remove empty lines
    # gcodeCommands = filter(lambda t: not t.isspace(), map(lambda t: str.lower(str.strip(t)), gcodeText.split('\n')))
    # commands = []
    #
    #Assume to be in inches first
    lines = gcodeText.split("\n");
    parsedLines = list(map(pygc.Line, lines))
    commands = []
    max = MAX_IN
    conversion = IN_TO_BITS

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
            command |= code << CODE_OFFSET
            # OR each argument into command

            for key in gcode.params:
                offset = ARGX_OFFSET if key == "X" or key == "T" else ARGY_OFFSET
                if key != "T":
                    command |= extractArg(gcode.params[key].value, conversion, max, offset)
                else:
                    command |= extractArg(gcode.params[key].value, 1 , 2**ARG_BITS, offset)


            commands.append(command)
    return commands



#True if given gcode code has arguments attached to it
def commandHasArgs(code):
    return code == str(pygc.GCodeLinearMove()) or code == str(pygc.GCodeRapidMove()) or code == str(pygc.GCodeToolChange())

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

#Given a string in the format <x | y | t> <number>.<number>, return an argument value at the approprate offset
def extractArg(value, conversion, max, offset):
    decimal = float(value)

    #Clamp to maximum
    decimal = math.copysign(max, decimal) if abs(decimal) > max else decimal

    #Convert in/mm to bit/in or bit/mm
    decimal *= conversion

    #Constrain decimal to be within the bit space
    integer = int(decimal) & (2**ARG_BITS - 1)

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

    commands = gcodeToCommands("G01 X-2.4 Y2.4")

    reverseGcode = commandsToGcode(commands)

    print(reverseGcode)

