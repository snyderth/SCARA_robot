import sys
try:
	sys.path.index("/root/SCARA_robot/src")
except ValueError:
	sys.path.append("/root/SCARA_robot/src")
import HPS_to_FPGA.CommandStreamTest as cst

cst.main()
