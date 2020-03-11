"""
NOT USED IN PRODUCTION CODE
"""
import serial
import HPS_to_FPGA.CommandCodeStreamer as ci
from GUI.easycalltools import *
from time import *

DONE_SIGNAL = "Done"
SEND_SIGNAL = "Send"
SENT_SIGNAL = "Sent"
SUCCESS_DELIM = "|"

def getSerial(ser):
    print("Reading")
    val = int(ser.readline().decode("ASCII"))#int.from_bytes(ser.read(4), "little")
    print("Read " + str(val))
    yield(val)

#To be ran on computer
def serialSendCommands(port, baud, commands, reportDone, reportSend, reportSent):
    ser = serial.Serial(port, baud, timeout=0)
    #ser.flush()
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
    print("Report done")
    #ser.write((DONE_SIGNAL + '\n').encode())
def serialReportSend(ser, gcode):
    print("Report send " + str(gcode))
    #ser.write((SEND_SIGNAL + str(gcode) + '\n').encode())
def serialReportSent(ser, success, gcode):
    print("Report sent " + str(gcode) + " " + str(success))
    #ser.write((SENT_SIGNAL + str(gcode) + SUCCESS_DELIM + str(success) + '\n').encode())

def serialReadLine(ser):
    b = []
    count = 0
    while True:
        # Continuously receive to newline
        sleep(0.1)
        # Read one byte at a time
        v = ser.read(1)
        if v == b'\n':
           # If newline read, convert to int
           # and return
           #print("{}".format(b))
           rxInt = 0
           for i in range(0, len(b)):
               # Shift each value up by power of ten for 
               # translating what was sent to an integer
               # value.
               exp = 10 ** (len(b) - i - 1)
               #print(exp)
               rxInt += (int(b[i]) * exp) 
               #print(rxInt)
           return rxInt #bytes(b)
        elif v == b'd':
           return 0
        # If not newline, append the received byte
        # to the byte array
        b.append(v)
       

def readCommands(ser):
    print("Waiting for computer")
    ser.read(1)
    
    print("Notfying computer")
    ser.write(b"1")
    ser.timeout = 1
    commands = []
    while True:
        print("Reading")
        read = serialReadLine(ser)
        print("Read:")
        print(read)
        if read == 0:
            # 0 is reserved because there is no
            # way for the arm to reach point (0,0)
            print("Receiving complete")
            break
        else:
            commands.append(read)
        
    return commands
        #print(read.decode())
        #try:
        #    commands.append(int(read.decode()))
        #except ValueError:
        #    return commands

def serialStreamProcess(port, baud):
    ser = serial.Serial(port, baud, timeout = None)
    print("Reading commands")

    commands = readCommands(ser)
    print("Read commands, running stream process")
    ci.streamProcess(commands, partial(serialReportDone, ser), giveCommand(partial(serialReportSend, ser)), lambda b, c: giveCommand(partial(serialReportSent, ser, b))(c))
