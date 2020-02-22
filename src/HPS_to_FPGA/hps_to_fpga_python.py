from ctypes import *
import os

class MemoryInterface:
    def __init__(self, libhps_to_fpga_cpath):
        '''

        @param libhps_to_fpga_cpath: Path to hps_to_fpga .so file. Expects that file implements:
            int write_fifo_dword_blocking(int)
        '''
        self.hps_to_fpga_c = CDLL(libhps_to_fpga_cpath)
        self.hps_to_fpga_c.init_fifo()
        self.hps_to_fpga_c.read_fifo_dword_nonblocking.argtypes = [POINTER(c_int)]
        #print(dir(self.hps_to_fpga_c))
       # if(self.hps_to_fpga_c.init_fifo() < 0):
       #     raise Exception("Could not initialize memory interface. errno: " + os.strerror(get_errno()));

    def writeFifoBlocking(self, dword: c_int32):
        '''
        Write dword to the hps fifo. Blocks until the fifo is free.
        @param dword: 32 bit value to write to fifo
        @return: -1 if error, 1 if success
        '''
        #print(dir(self.hps_to_fpga_c))
        return self.hps_to_fpga_c.write_fifo_dword_blocking(dword)

    def writeFifoNonBlocking(self, dword: c_int32):
        '''
        Write a dword to the hps fifo without waiting. Returns 1 if successful at writing.
        @param dword: 32 bit value to write to fifo
        @return: 1 if success
        '''
        return self.hps_to_fpga_c.write_fifo_dword_nonblocking(dword)

    def readFifoBlocking(self):
        '''
        Blocks untill a fifo value is avaliable to read and reads it.
        @return: Fifo value
        '''
        return self.hps_to_fpga_c.read_fifo_dword_blocking()
    def readFifoNonblocking(self, success_out: POINTER(c_int)):
        '''
        Read a fifo value without blocking.
        @param: success_out: Success value pointer. 1 if successful read.
        '''

        return self.hps_to_fpga_c.read_fifo_dword_nonblocking(success_out)
