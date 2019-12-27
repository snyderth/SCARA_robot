from rig.type_casts import float_to_fp, fp_to_float

#Commands are formatted like so:
#|code|argXAbove.argXFrac|argYAbove.argYFrac|
#0    3        12        17       26       31
#code is an integer from 0 to 8 representing a specific G/M code
#ArgX and ArgY are arguments in fixed point with 9 bits above the decimal and 5 bits below the decimal
#ArgX may also represent a T argument for the relevant codes

#Constants
#Bits per section
CODE_BITS = 4
ARG_ABOVE_BITS = 9
ARG_FRAC_BITS = 5

ARG_SIZE = ARG_ABOVE_BITS + ARG_FRAC_BITS

#Offsets
CODE_OFFSET = 0
ARGX_ABOVE_OFFSET = CODE_OFFSET + CODE_BITS
ARGX_FRAC_OFFSET = ARGX_ABOVE_OFFSET + ARG_ABOVE_BITS
ARGY_ABOVE_OFFSET = ARGX_FRAC_OFFSET + ARG_FRAC_BITS
ARGY_FRAC_OFFSET = ARGY_ABOVE_OFFSET + ARG_ABOVE_BITS

#Gcode to command map
GCODE_MAP = {"g00": 0, "g01": 1, "g20": 2, "g21": 3, "g90": 4, "g91": 5, "m2": 6, "m6": 7, "m72": 8}

#Convert gcode text to a list of commands. Throws exceptions if there are errors in the gcode.
def gcodeToCommands(gcodeText):
    #Format gcode to remove whitespace, convert to lower case, and remove empty lines
    gcodeCommands = filter(lambda t: not t.isspace(), map(lambda t: str.lower(str.strip(t)), gcodeText.split('\n')))

    return list(map(gcodeToCommand, gcodeCommands))

#Convert a line of lowercase gcode with whitespace stripped to a command code
def gcodeToCommand(gcodeLine):
    command = 0
    gcodeLine = gcodeLine.split()
    #Determine if line contains anything
    if len(gcodeLine) > 0:
        cmd = gcodeLine[0]
        code = commandToCode(cmd)
        command |= code << CODE_OFFSET
        if commandHasArgs(cmd):
            if len(gcodeLine) > 1:

                #OR each argument into command
                for argText in gcodeLine[1:]:
                    command |= extractArg(argText)

            else:
                raise Exception("Code {c} is expected to have arguments, but none are given".format(code))
        return command

    else:
        raise Exception("Empty line given")

#True if given gcode code has arguments attached to it
def commandHasArgs(code):
    return code == 'g00' or code == 'g01' or code == 'm6'

#Given a string in the format <x | y | z> <number>.<number>, return an argument value at the approprate offset
def extractArg(text):
    if len(text) > 0:
        arg = 0

        #Find initial offset
        if text[0:1] == "x" or text[0:1] == "t":
            offset = ARGX_ABOVE_OFFSET
        elif text[0:1] == "y":
            offset = ARGY_ABOVE_OFFSET
        else:
            raise Exception("Invalid arg prefix: {c}".format(c = text[0:1]))

        #Convert to fixed point
        decimal = float(text[1:])
        toFixed = float_to_fp(signed=False, n_bits=ARG_SIZE, n_frac=ARG_FRAC_BITS)

        #Apply fixed point number to appropriate location
        arg |= int(toFixed(decimal)) << offset

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

    gcodeFile = open("../test.gcode", "r")

    gcode = gcodeFile.read()

    commands = gcodeToCommands(gcode)

    print(commands)

    #Test argument generation
    num1 = "x24.25"
    cmd1 = extractArg(num1) >> CODE_BITS

    toFloat = fp_to_float(n_frac=ARG_FRAC_BITS)
    print(toFloat(cmd1))

