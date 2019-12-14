from Vision import vision
import cv2

img = cv2.imread("Vision/burmese.jpg")

gcode = vision.asGCode(img, [(0, 0, 0)], 0.01, 32, (215, 279))

print(gcode)

file = open("test.gcode", "w")
file.write(gcode)
file.close()
