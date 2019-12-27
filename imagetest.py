from Vision.vision import *
import cv2 as cv
import random
import colorsys
from functools import reduce, partial


from matplotlib import pyplot as plt

img = cv.imread("Vision/burmese.jpg")
palette = [0, 60, 145, 206, 240]
cv.imshow('original', img)

edges = grayEdge(img)

contours = imageContours(edges)

contours.sort(key=lambda c: cv.contourArea(c))

# get maxLines biggest contours
majorContours = contours[len(contours) - 32:]
contoursColors = contourColors(img, majorContours)

blankImg = np.zeros(img.shape, np.uint8)

for i in range(len(majorContours)):
    cv.drawContours(blankImg, majorContours, i, contoursColors[i])
cv.imshow("contours", blankImg)
#contourPalette = map(lambda c: colorPalette.index(reduce(closestTo(c), colorPalette)), contoursColors)
contourLines = list(map(partial(contourLines, 10), majorContours))

blankImg = np.zeros(img.shape, np.uint8)

# for c in range(len(contourLines)):
#     color = (random.randint(20, 255), random.randint(20, 255), random.randint(20, 255))
#     for i in range(len(contourLines[c])):
#         cv.line(blankImg, contourLines[c][i][0], contourLines[c][i][1], color)
# cv.imshow("lines", blankImg)
poly = []
for i in range(len(majorContours)):
    poly.append(cv.approxPolyDP(majorContours[i], 5, True))
cv.polylines(blankImg, poly, True, (255,255,255))
cv.imshow("Poly", blankImg)

while 1:
    k = cv.waitKey(5) & 0xFF
    if k == 27:
        break
