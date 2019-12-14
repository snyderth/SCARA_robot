from string import Template

g00 = Template("G00 X$x Y$y") #Rapid move
g01 = Template("G01 X$x Y$y") #Linear move
g20 = Template("G20") #Inches units
g21 = Template("G21") #Millimiter units
g90 = Template("G90") #Absolute coordnates
g91 = Template("G91") #RelativeCoordnates

m2 = Template("M2") #End of program
m6 = Template("M6 T$num") #Tool change
m72 = Template("M72") #Raise tool
