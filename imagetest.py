from Vision.vision import *
import cv2 as cv
img = cv.imread("Vision/hsv-samples.jpg")
palette = [0, 50, 220]
cv. imshow('original', img)
coerceHue(img, palette)

cv.imshow('coerced', img)
h, s, v = cv.split(img)
cv.imshow('h', h)
while 1:
    k = cv.waitKey(5) & 0xFF
    if k == 27:
        break
