import math
from GCode.gcodeFormatter import *
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
IN_TO_BITS = 2**ARG_BITS/MAX_IN #bits/in
MM_TO_BITS = 2**ARG_BITS/MAX_MM #bits/mm
TOOL_TO_BITS = 1

#Gcode to command map
GCODE_MAP = {g00Command.lower(): 0, g01Command.lower(): 1, g20.lower(): 2, g21.lower(): 3, g90.lower(): 4, g91.lower(): 5, m2.lower(): 6, m6Command.lower(): 7, m72.lower(): 8}

#Inverse command map useful decoding fpga commands
COMMAND_MAP = {v: k for k, v in GCODE_MAP.items()}


def commandsToGcode(commands):
    program = []
    conversion = 1 / IN_TO_BITS

    for command in commands:

        gcode = ""

        code = commandCode(command)
        gcodeCommand = COMMAND_MAP[code]

        units = commandUnits(gcodeCommand)
        if  units != None:
            unit_to_bits, _ = units
            conversion = 1 / unit_to_bits

        gcode += gcodeCommand + " "

        command = command >> CODE_BITS
        if commandHasArgs(gcodeCommand):
            for argName in commandArgs(gcodeCommand):
                gcode += argName

                argValue = (command & ((1 << ARG_BITS) - 1)) * conversion
                gcode += str(argValue) + " "

                command = command >> ARG_BITS

        program.append(gcode)
    return '\n'.join(program)


def commandCode(command: int):
    code = (command >> CODE_OFFSET) & ((1 << CODE_BITS) - 1)
    return code



def gcodeToCommands(gcodeText):
    '''
    Convert gcode text to a list of commands. Throws exceptions if there are errors in the gcode.

    @param gcodeText:
    @return:
    '''
    #Format gcode to remove whitespace, convert to lower case, and remove empty lines
    gcodeCommands = filter(lambda t: not t.isspace(), map(lambda t: str.lower(str.strip(t)), gcodeText.split('\n')))
    commands = []

    #Assume to be in inches first
    max = MAX_IN
    conversion = IN_TO_BITS

    for gcodeLine in gcodeCommands:
        command = 0
        gcodeLine = gcodeLine.split()

        # Determine if line contains anything
        if len(gcodeLine) > 0:
            cmd = gcodeLine[0]

            #check if command changes units
            units = commandUnits(cmd)
            if units:
                conversion, max = units

            #Get enumeration value of cmd
            code = commandToCode(cmd)
            command |= code << CODE_OFFSET

            if commandHasArgs(cmd):

                if len(gcodeLine) > 1:
                    # OR each argument into command
                    for argText in gcodeLine[1:]:
                        command |= extractArg(argText, conversion, max)

                else:
                    raise Exception("Code {c} is expected to have arguments, but none are given".format(code))

            commands.append(command)

        else:
            raise Exception("Empty line given")
    return commands

#True if given gcode code has arguments attached to it
def commandHasArgs(code):
    return code == 'g00' or code == 'g01' or code == 'm6'

def commandArgs(code):
    if code == 'g00' or code == 'g01':
        return ("x", "y")
    if code == 'm6':
        return ("t")

#Returns (conversion factor, max value) for given gcode code if code converts units, None otherwise.
def commandUnits(code):
    if code == 'g20':
        return (IN_TO_BITS, MAX_IN)
    if code == 'g21':
        return (MM_TO_BITS, MAX_MM)
    return None

#Given a string in the format <x | y | t> <number>.<number>, return an argument value at the approprate offset
def extractArg(text, conversion, max):
    if len(text) > 0:
        arg = 0

        #Find initial offset
        if text[0:1] == "x" or text[0:1] == "t":
            offset = ARGX_OFFSET
        elif text[0:1] == "y":
            offset = ARGY_OFFSET
        else:
            raise Exception("Invalid arg prefix: {c}".format(c = text[0:1]))

        decimal = float(text[1:])

        #Clamp to maximum
        decimal = math.copysign(max, decimal) if abs(decimal) > max else decimal

        #Convert in/mm to bit/in or bit/mm
        decimal *= conversion

        arg |= int(decimal) << offset

        return arg
    else:
        raise Exception("Empty text provided")

#Given a code in the format <G|M><number> return the appropriate command number.
def commandToCode(code):
    if code.lower() in GCODE_MAP:
        return GCODE_MAP[code]
    else:
        raise Exception("Invalid code: {c}".format(c = code))

#test code
if __name__ == '__main__':

    gcodeFile = open("../../test.gcode", "r")

    gcode = gcodeFile.read()

    commands = gcodeToCommands(gcode)

    reverseGcode = commandsToGcode(commands)

    print(reverseGcode)

