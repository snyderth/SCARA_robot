g00Command = "G00"
g00 = g00Command + " X{x} Y{y}" #Rapid move

g01Command = "G01"
g01 = g01Command + " X{x} Y{y}" #Linear move

g20 = "G20" #Inches units
g21 = "G21" #Millimiter units
g90 = "G90" #Absolute coordnates
g91 = "G91" #RelativeCoordnates

m2 = "M2" #End of program

m6Command = "M6"
m6 = m6Command + " T{tool}" #Tool change

m72 = "M72" #Raise tool
