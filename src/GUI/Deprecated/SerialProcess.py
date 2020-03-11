import GUI.SerialInterface as si
PORT = "/dev/ttyS0"
BAUD = 115200
if __name__ == "__main__":
    si.serialStreamProcess(PORT, BAUD)
