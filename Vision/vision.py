import cv2 as cv
import numpy as np
from scipy import spatial as sc

#Convert an image matrix to a gcode string.
#Inputs: 
#img: an image matrix (such as from a webcam or image file)
#hsvPalette: Array of tuples in the form [(h, s, v), ...]
#Outputs:
#return: a valid gcode string
def asGCode(img, hsvPalette):
    toHSV(img)
    coerceHSV(img, hsvPalette)

    return ""


def coerceHSV(img, hsvPalette):
    toHSV(img)
    colorCoercer = ColorCoerce(hsvPalette)
    img = colorCoercer.coerceColor(img)
    return img


def toHSV(img):
    return cv.cvtColor(img, cv.COLOR_BGR2HSV)


class ColorCoerce:
    def __init__(self, hsvPalette):
        self.lookupTree = sc.KDTree(hsvPalette)
        self.hsvPalette = hsvPalette
        self.vCoercePixel = np.vectorize(self.coercePixel)

    def coercePixel(self, px):
        _, index = self.lookupTree.query(px)
        return self.hsvPalette[index]

    def coerceColor(self, img):
        h,w,c = np.shape(img)
        for py in range(h):
            for px in range(w):
                pixelColor = img.item((px, py, 2))
                _, result = self.lookupTree.query(pixelColor)
                coercedPixel = self.hsvPalette[result]
                img.setitem((px, py, 2), coercedPixel)
        return img

#       return self.vCoercePixel(img);
