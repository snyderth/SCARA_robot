import serial
import GCode.gcodeParser as gp
from time import sleep

def f(ser):
	
	sleep(0.1)
	res = ser.readline()
	print(res.decode())


	yield str(res.decode())

ser = serial.Serial("/dev/ttyS0", 115200)
ser.flush()
for r in f(ser):
	
	print(r)
	ser.write(b"1")
