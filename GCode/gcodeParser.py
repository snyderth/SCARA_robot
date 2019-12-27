import re

#Commands are formatted like so:
#|code|argXAbove.argXBelow|argYAbove.argYBelow|
#0    3        12         17        26       31
#code is an integer from 0 to 8 representing a specific G/M code
#ArgX and ArgY are arguments in fixed point with 9 bits above the decimal and 5 bits below the decimal
#ArgX may also represent a T argument for the relevant codes

#Constants
#Offsets for command forming
CODE_BITS = 4
ARG_ABOVE_BITS = 9
ARG_BELOW_BITS = 5


COMMAND_OFFSET = 0
ARGX_ABOVE_OFFSET = COMMAND_OFFSET + CODE_BITS
ARGX_BELOW_OFFSET = ARGX_ABOVE_OFFSET + ARG_ABOVE_BITS
ARGY_ABOVE_OFFSET = ARGX_BELOW_OFFSET + ARG_BELOW_BITS
ARGY_BELOW_OFFSET = ARGY_ABOVE_OFFSET + ARG_ABOVE_BITS


#Gcode to command map
GCODE_MAP = {"g00": 0, "g01": 1, "g20": 2, "g21": 3, "g90": 4, "g91": 5, "m2": 6, "m6": 7, "m72": 8}

def gcodeToCommands(gcodeText):

    #Format gcode to remove whitespace and get list of lines
    gcodeCommands = filter(lambda t: not t.isSpace(), map(str.strip, gcodeText.split()))

    return list(map(gcodeToCommand, gcodeCommands))

def gcodeToCommand(gcodeLine):
    command = 0
    gcodeLine.split(' ')
    #Determine if line contains anything
    if len(gcodeLine) > 0:
        code = codeToCommand(gcodeLine)
        command |= code << COMMAND_OFFSET
        if codeHasArgs(code):
            if len(gcodeLine) > 1:

                #OR each argument into command
                for argText in gcodeLine[1:]:
                    command |= extractArg(argText)

            else:
                raise Exception("Code {c} is expected to have arguments, but none are given".format(code))
        return command

    else:
        raise Exception("Empty line given")

def codeHasArgs(code):
    return code == 'g00' or code == 'g01' or code == 'm6'


def extractArg(text):
    if len(text) > 0:
        arg = 0

        #Find initial offset
        if text[0:1] == "X" or text[0:1] == "T":
            offset = ARGX_ABOVE_OFFSET
        elif text[0:1] == "Y":
            offset = ARGY_ABOVE_OFFSET
        else:
            raise Exception("Invalid arg prefix: {c}".format(c = text[0:1]))

        #Parse above and below decimal
        decimal = re.findall("\d+(\.|$)")
        #OR bits onto arg. If there are below decimal bits, OR those too.
        for d in decimal:
            arg |= int(d) << offset
            offset += ARG_ABOVE_BITS
        return arg
    else:
        raise Exception("Empty text provided")

def codeToCommand(code):
    if code.lower() in GCODE_MAP:
        return GCODE_MAP[code]
    else:
        raise Exception("Invalid code: {c}".format(c = code))

