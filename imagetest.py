from Vision.vision import *
import cv2 as cv
from matplotlib import pyplot as plt

img = cv.imread("Vision/testimg.jpg")
palette = [0, 60, 145, 206, 240]
cv. imshow('original', img)
coerceHue(img, palette)

cv.imshow('coerced', img)
h, s, v = cv.split(img)
cv.imshow('h', h)
he = hueEdge(h, 9, 11)

plt.subplot(122),plt.imshow(he,cmap = 'gray')
plt.title('Edge Image'), plt.xticks([]), plt.yticks([])
plt.show()
while 1:
    k = cv.waitKey(5) & 0xFF
    if k == 27:
        break
