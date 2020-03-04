import serial
import HPS_to_FPGA.CommandCodeStreamer as ci
import GCode.gcodeParser as gp
from GUI.easycalltools import *

DONE_SIGNAL = "Done"
SEND_SIGNAL = "Send"
SENT_SIGNAL = "Sent"
SUCCESS_DELIM = "|"

def getSerial(ser):
    if ser.is_open():
        yield int.from_bytes(ser.read(5), "little")

#To be ran on computer
def serialSendCommands(port, baud, commands, reportDone, reportSend, reportSent):
    ser = serial.Serial(port, baud, timeout=0)
    for command in commands:
        print("Writing: " + str(command.to_bytes(4, byteorder="big")))
        ser.write(command.to_bytes(4 ,byteorder="big"))
        response = str(ser.readline())
        print("Recived: " + response)
        if response.find(DONE_SIGNAL) > -1 :
            reportDone()
        elif response.find(SEND_SIGNAL) > -1:
            gcode = response[response.find(SEND_SIGNAL):]
            reportSend(gcode)
        elif response.find(SENT_SIGNAL) > -1:
            splitResponse = response.split(SUCCESS_DELIM)
            gcode = splitResponse[0][response.find(SENT_SIGNAL):]
            success = splitResponse[1]
            reportSent(success, gcode)


#To be ran on HPS
def serialReportDone(ser):
    ser.writeline(DONE_SIGNAL)
def serialReportSend(ser, gcode):
    ser.writeline(SEND_SIGNAL + gcode)
def serialReportSent(ser, success, gcode):
    ser.writeline(SENT_SIGNAL + gcode + SUCCESS_DELIM + str(success))

def serialStreamProcess(port, baud):
    ser = serial.Serial(port, baud)
    ci.streamProcess(getSerial(ser), partial(serialReportDone, ser), giveCommand(partial(serialReportSend)), lambda b, c: giveCommand(partial(serialReportSent, ser, b))(c))


if __name__ == '__main__':
    commands = gp.gcodeToCommands("G00 X8 Y8")
    print(commands)
    serialSendCommands("COM4", 115200, commands, lambda : print("done"), lambda g: print(g), lambda s, g: print(s + " " + g))