import serial

ser = serial.Serial("COM4", 115200)
while True:
        res = ser.write("test\n".encode())
        print(res)
