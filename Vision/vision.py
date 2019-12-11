import cv2 as cv
import numpy as np
from functools import reduce

'''
Convert image to valid g-code
@param img RGB space image
@param huePalette set of hues to look for when performing edge detection
@returns g-code string
'''
def asGCode(img, huePalette):
    cv.cvtColor(img, cv.COLOR_BGR2HSV)
    coerceHue(img, huePalette)

    return ""


# Set an RGB image to only have a specific set of hues
# Inputs:
def coerceHue(img, huePalette):
    cv.cvtColor(img, cv.COLOR_BGR2HSV)
    img = coerceColor(img, huePalette)
    return img


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
