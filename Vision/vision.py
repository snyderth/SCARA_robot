import cv2 as cv
import numpy as np
import operator
from GCode import gcodeFormatter as gc
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
    contours = imageContours(edges)

    contours.sort(key=lambda c: cv.contourArea(c))

    #get maxLines biggest contours
    majorContours = contours[len(contours) - maxLines:]

    contoursColors = contourColors(img, majorContours)


    #Convert contour colors to a set of indexes into colorPalette
    contourPalette = list(map(lambda c: colorPalette.index(reduce(closestTo(c), colorPalette)), contoursColors))

    #Show contours and colors
    blankImg = np.full(img.shape, (255,255,255),np.uint8)
    for i in range(len(majorContours)):
        cv.drawContours(blankImg, majorContours, i, colorPalette[contourPalette[i]])
    cv.imshow("Contours", blankImg)


    #Make major contours into a set of lines to draw
    contoursAsLines = list(map(partial(contourLines, granularity), majorContours))

    blankImg = np.zeros(img.shape, np.uint8)
    cv.polylines(blankImg, contoursAsLines, True, (255,255,255))
    cv.imshow("Lines", blankImg)

    return linesAsGCode(contoursAsLines, contourPalette, img.shape[0:2], paperSize)

#Organize lines by color and closeness
#TODO: Still not producing good results.
def organizeLines(contoursAsLines, palette, shape):
    # sort lines by color
    contoursAsLines, palette = (list(t) for t in zip(*sorted(zip(contoursAsLines, palette), key=lambda c: c[1])))
    colorRange = [palette.index(u) for u in np.unique(palette)]
    colorRange.append(len(palette))
    sortedLines = []
    for i in range(len(colorRange) - 1):
        sortedLines.append(sorted(contoursAsLines[colorRange[i]: colorRange[i + 1]], key = lambda l: l[0][0][0] * shape[0] + l[0][0][1]))
    return [y for x in sortedLines for y in x]

#Convert line data to g-code text
def linesAsGCode(contoursAsLines, palette, imageSize, paperSize):

    #Convert contours to lines
    contoursAsLines = organizeLines(contoursAsLines, palette, imageSize)

    #Scale image to fit paper size in millimeters
    mmPerPxX = paperSize[0]/imageSize[0]
    mmPerPxY = paperSize[1]/imageSize[1]

    gcode = []

    #initialize to be absolute coordnates
    gcode.append(gc.g90)

    #Initialize to use metric (better accuracy)
    gcode.append(gc.g21)

    currentTool = palette[0]
    for i in range(len(contoursAsLines)):
        segments = contoursAsLines[i]

        #If the current segment has a color different than the current pen, swap the pen out
        if palette[i] != currentTool:
            currentTool = palette[i]
            gcode.append(gc.m6.format(tool = currentTool))

            #Send pen to first point
            gcode.append(gc.m72)
            gcode.append(gc.g01.format(x=segments[0][0][0] * mmPerPxX, y=segments[0][0][1] * mmPerPxY))
            gcode.append(gc.m72)

        if(len(segments) > 1):
            for s in range(1, len(segments)):
                #Draw to subsequent points
                gcode.append(gc.g01.format(x = segments[s][0][0] * mmPerPxX, y = segments[s][0][1] * mmPerPxY))
    #End of program
    gcode.append(gc.m2)

    #Form string
    return "\n".join(gcode)


#Find lines in contours
def contourLines(granularity, contour):
    return cv.approxPolyDP(contour, granularity, True)

#Find contours from edges
def imageContours(edges):
    contours, heierarchy = cv.findContours(edges, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    return contours

#Convert image from RGB to grayscale and find edges
def grayEdge(img):

    #Create grayscale version of img with blurring to reduce noise
    grayImg = img.copy()
    grayImg = cv.cvtColor(grayImg, cv.COLOR_RGB2GRAY)
    grayImg = cv.blur(grayImg, (3, 3))

    #Find edge thresholds using a method called "Otsu's method"
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

#Return average color of contour in img
def avgContourPixelValue(img, contour):
    contourColors = list(map(lambda c: img[c[0][1], c[0][0]], contour))
    return np.average(contourColors, 0)

# Returns a function that determines if value y or z is closer to x
def closestTo(x):
    return lambda y, z: y if  reduce(operator.and_, np.less(np.abs(np.subtract(y, x)),  np.abs(np.subtract(z, x))))else z

if __name__ == '__main__':
    img = cv.imread("burmese.jpg")

    gcode = asGCode(img, [(0, 0, 0), (0, 255, 0), (105, 71, 59), (158, 124, 219)], 5, 32, (215, 279))

    print(gcode)

    file = open("../test.gcode", "w")
    file.write(gcode)
    file.close()

    while 1:
        k = cv.waitKey(5) & 0xFF
        if k == 27:
            break
