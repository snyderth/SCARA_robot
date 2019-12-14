import cv2 as cv
import numpy as np
import math
from GCode import gcodeFormatter as gcode
from functools import reduce, partial

'''
Convert image to valid g-code
@param img RGB: space image
@param huePalette: set of hues to look for when performing edge detection
@param granularity: Amount of points to use when turing contours into lines to draw. Higher value means longer lines.
@param maxLines: Maximum number of lines to draw
@returns g-code string
'''
def asGCode(img, colorPalette, granularity, maxLines, paperSize):
    edges = grayEdge(img)
    contours = filter(lambda c: int(len(c) * granularity) > 0 , imageContours(edges))

    contours.sort(key=lambda c: cv.contourArea(c))

    #get maxLines biggest contours
    majorContours = contours[len(contours) - maxLines:]


    contoursColors = contourColors(img, majorContours)

    #Convert contour colors to a set of indexes into colorPalette
    contourPalette = map(lambda c: colorPalette.index(reduce(closestTo(c), colorPalette)), contoursColors)

    #Make major contours into a set of lines to draw
    contoursAsLines = list(map(partial(contourLines, granularity), majorContours))




    return ""

#def linesAsGCode(lines, palette, paperSize):



def contourLines(granularity, contour):
    lines = []
    step = math.ceil(len(contour) * granularity)
    for i in range(0, len(contour) - step, step):
        lines.append((tuple(contour[i][0]), tuple(contour[i + step][0])))
    return lines

def imageContours(edges):
    contours, heierarchy = cv.findContours(edges, cv.RETR_TREE, cv.CHAIN_APPROX_NONE)
    for i in range(len(heierarchy)):
        if(heierarchy[0][i][3] < 0):
            del contours[i]
    return contours

def grayEdge(img):

    #Create grayscale version of img with blurring to reduce noise
    grayImg = img.copy()
    grayImg = cv.cvtColor(grayImg, cv.COLOR_RGB2GRAY)
    grayImg = cv.blur(grayImg, (3, 3))

    #Perform find edge thresholds using a method called "Otsu's method"
    highThresh, thresh_im = cv.threshold(grayImg, 0, 255, cv.THRESH_BINARY + cv.THRESH_OTSU)
    lowThresh = 0.5 * highThresh

    #Find edges
    edges = cv.Canny(grayImg, lowThresh, highThresh)

    #Try to "close" edges to create more defined contours
    modifiedEdges = cv.morphologyEx(edges, cv.MORPH_CLOSE, np.ones((2,2)))

    return modifiedEdges
#Returns an array of colors representing the average color along each contour in the given image
def contourColors(img, contours):
    return list(map(partial(avgContourPixelValue, img), contours))

#Get average value of colors in img along contour
def avgContourPixelValue(img, contour):
    contourColors = list(map(lambda c: img[c[0][1], c[0][0]], contour))
    return np.average(contourColors, 0)

# Returns a function that determines if value y or z is closer to x
def closestTo(x):
    return lambda y, z: y if abs(y - x) < z else z


# Naive implementation of color coercement. Very slow.
# Inputs:
# img: image matrix in HSV color space
# huePalette: an array of hue values to set the image to
# Outputs:
# Image with hues coerced to values in huePalette
def coerceColor(img, huePalette):
    w, h, c = np.shape(img)

    #If speed is a concern, find a way to do this that is not O(n^3)
    for py in range(h):
        for px in range(w):
            #Get hue
            pixelHue = img.item((px, py, 0))

            #Find closest hue value to pixel
            coercedHue = reduce(closestTo(pixelHue), huePalette)

            img.itemset((px, py, 0), coercedHue)
    return img
