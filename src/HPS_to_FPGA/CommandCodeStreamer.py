from HPS_to_FPGA.hps_to_fpga_python import *
from GCode.gcodeParser import commandCode, COMMAND_MAP, GCODE_MAP, commandToGcode
from GCode.gcodeFormatter import m2
import os
from ctypes import *


path = os.path.abspath(__file__)
path = os.path.realpath(path)
path = os.path.dirname(path)
path = os.path.join(path, "libhps_to_fpga_c.so")

def streamProcess(FPGACommands, reportFPGA, reportDone):
    '''

    @param FPGACommands: FPGA command values, in order of execution.
    @param reportFPGA: Function in the format (int)->None that reports any value returned by the FPGA
    @param reportDone: Function in the format ()->None that reports when the FPGA is done executing
    @return: None
    '''
    #print(os.environ)
    mi = MemoryInterface(os.path.abspath(path))
    for command in FPGACommands:

        #Stop early if end of program command is met
        if COMMAND_MAP[commandCode(command)] == m2.lower():
            reportDone()
            return
        print("sending " + commandToGcode(command, 1))
        mi.writeFifoBlocking(command)
        print("sent data")
        success = pointer(c_int(0))

        fpgaReport = mi.readFifoBlocking()
	
        print(success.contents.value)
        
        reportFPGA(fpgaReport)

