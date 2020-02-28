import serial
import HPS_to_FPGA.CommandCodeStreamer as ci
from functools import partial
from GUI.easycall import giveCommand

def getSerial(ser):
    yield ser.read(4)

#To be ran on computer
def serialSendCommands(ser, commands):
    for command in commands:
        ser.write(command)

#To be ran on HPS
def serialReportDone(ser):
    ser.writeline("Done")
def serialReportSend(ser, gcode):
    ser.writeline("Send:" + gcode)
def serialReportSent(ser, success, gcode):
    ser.writeline("Sent:" + gcode + ",Success:" + success)

def serialStreamProcess(port, baud, reportDone, reportSend, reportSent):
    ser = serial.Serial(port, baud)
    ci.streamProcess(getSerial(ser), partial(serialReportDone, ser), giveCommand(partial(reportSend)), lambda b, c: giveCommand(partial(serialReportSent, ser, b))(c))