from Vision import vision
import cv2

img = cv2.imread("Vision/burmese.jpg")

gcode = vision.asGCode(img, [(0, 0, 0), (0, 255, 0), (105, 71, 59), (158, 124, 219)], 5, 32, (215, 279))

print(gcode)

file = open("test.gcode", "w")
file.write(gcode)
file.close()

while 1:
    k = cv2.waitKey(5) & 0xFF
    if k == 27:
        break
