import serial
import HPS_to_FPGA.CommandCodeStreamer as ci
from functools import partial
from GUI.easycall import giveCommand

DONE_SIGNAL = "Done"
SEND_SIGNAL = "Send"
SENT_SIGNAL = "Sent"
SUCCESS_DELIM = "|"

def getSerial(ser):
    yield ser.read(4)

#To be ran on computer
def serialSendCommands(port, baud, commands, reportDone, reportSend, reportSent):
    ser = serial.Serial(port, baud, timeout=0)
    for command in commands:
        ser.write(command)
        response = ser.readline()
        if response.find(DONE_SIGNAL):
            reportDone()
        elif response.find(SEND_SIGNAL):
            gcode = response[response.find(SEND_SIGNAL):]
            reportSend(gcode)
        elif response.find(SENT_SIGNAL):
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