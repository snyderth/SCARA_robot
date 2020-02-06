from .hps_to_fpga_python import *
from ..GCode.gcodeParser import commandCode, COMMAND_MAP, GCODE_MAP
from ..GCode.gcodeFormatter import m2

path = "./hps_to_fpga_c/Debug/libhps_to_fpga_c.so"

def streamProcess(FPGACommands, reportFPGA, reportDone):
    '''

    @param FPGACommands: FPGA command values, in order of execution.
    @param reportFPGA: Function in the format (int)->None that reports any value returned by the FPGA
    @param reportDone: Function in the format ()->None that reports when the FPGA is done executing
    @return: None
    '''
    mi = MemoryInterface(path)
    for command in FPGACommands:

        #Stop early if end of program command is met
        if COMMAND_MAP[commandCode(command)] == m2.lower():
            return

        mi.writeFifoBlocking(command)

        success = 0
        fpgaReport = mi.readFifoNonblocking(success)

        if success:
            reportFPGA(fpgaReport)

