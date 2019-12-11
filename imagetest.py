from Vision.vision import *
import cv2 as cv
img = cv.imread("Vision/testimg.jpg")
palette = [(0, 60, 60), (50, 60, 60), (90, 60, 60)]
coerceHSV(img, palette)


