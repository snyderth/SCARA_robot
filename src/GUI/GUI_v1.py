"""
    Program:    GUI_v0.py
    Author:     Kyle Noble
    Date:       2/28/2020

    Description:
        Uses the PySimpleGUI library to create a Graphical User Interface
        for a Selective Compliance Assembly Robot Arm (SCARA).

        User can capture images using a webcam, load their own .png image,
        or load a .gcode file.

        Consists of two tabs:

        OpenCV parameters can be set in the OpenCV Settings tab.
"""

import PySimpleGUI as sg
import cv2
import numpy as np
import GUI.easycall as easycall
import GUI.FTPInterface as ftp

# An unused test function to demonstrate functionality of the GUI.
def test_func(colorPalette, granularity, maxlines, papersize):
    print("Color: ",colorPalette, "Granularity: ", granularity, "maxlines: ", maxlines, "papersize: ", papersize)

# Prints to console when command is complete.
def reportDone():
    print("Command is done")

# Prints command to console that is being sent.
def reportSend(gcode):
    print("Command is being sent: {}".format(gcode))

# Prints whether the command was successful or not.
def reportSent(success, code):
    if success:
        print("Command {} is sent".format(code))
    else:
        print("Command {} send failed".format(code))

# GUI theme
# All default themes available at:
# https://user-images.githubusercontent.com/46163555/71361827-2a01b880-2562-11ea-9af8-2c264c02c3e8.jpg
sg.theme('BlueMono')

cap = cv2.VideoCapture(0)       # select webcam input
recording = True                # Bool that tracks whether to read from webcam
final_img = None                # img to be sent to CV. Should be RGB numpy matrix
frame = None                    # image last captured from webcam
ret = None                      # Bool that indicates if image capture is successful
imgbytes = None                 # byte array of image
file_path = ""                  # File path in the file browser input box
height = 482                    # Default height of video capture
width = 642                     # Default width of video capture

com = 'COM4'                    # Serial Communication Port to send data over.
baud = 115200                   # baud rate to use

# Default OpenCV values:
color1 = int(0x0000ff)
color2 = int(0x00ff00)
color3 = int(0xff0000)
colorPalette = [(color1 >> 16,  color1 % (2**16) >> 8, color1 % (2**8)), (color2 >> 16, (color2 % (2**16)) >> 8,
                color2 % (2**8)), (color3 >> 16,  (color3 % (2**16)) >> 8, color3 % (2**8))]

granularity = 1
maxLines = 100
paperSize = (279, 215)

# Main tab for selecting data to send
tab1 = [[sg.Text('Capture a webcam image, upload an image, or upload a GCode file.')],

        [sg.Text('Upload an image or GCode file:'), sg.Input(key='inputbox'),
         sg.FileBrowse(key='browse', file_types=(("Image Files", "*.png"),
                                                 ("GCode Files", "*.txt *.gcode *.mpt *.mpf *.nc")))],

        [sg.Text('Webcam output:', key='imgtext')],

        [sg.Image(filename='', key='image')],

        [sg.Text('Camera Controls:\t'),
         sg.Button('Capture Image', key='capimg'), sg.Button('Clear Image', key='retake', disabled=True)],

        [sg.Text("Send Output:\t"),
         sg.Button("Send Image", key="sendimg", disabled=True),
         sg.Button("Send GCode File", key="sendGcode", disabled=True)]]

# Tab dedicated to the many OpenCV settings.
tab2 = [
            [sg.Text('Enter computer vision parameters', key='cv_text')],

            [sg.Text('Color Palette (6 digit hex)', size=(40, 1)),
             sg.Input(size=(13, 1), key='color1', default_text="0000FF"),
             sg.Input(size=(13, 1), key='color2', default_text="00FF00"),
             sg.Input(size=(13, 1), key='color3', default_text="FF0000")],

            [sg.Text('Granularity (float between 1 and 50)', size=(40, 1)),
             sg.Input(key='granularity', default_text="1")],

            [sg.Text('Max Lines (int between 1 and 1000)', size=(40, 1)), sg.Input(key='maxlines', default_text="100")],

            [sg.Text('Paper Size in mm (int in [10, 279], int in [10, 215])', size=(40, 1)),
             sg.Input(size=(21, 1), key='dim1', default_text="279"),
             sg.Input(size=(21, 1), key='dim2', default_text="215")],

            [sg.Button('Apply', key='apply')]]

# Putting everything together into a single window.
layout = [
            [sg.TabGroup([[sg.Tab('Main Interface', tab1), sg.Tab('OpenCV Settings', tab2)]])],
            [sg.Output(size=(80, 10), font='Verdana 10')],
            [sg.Button('Exit', key='exit')]]

# Can only call this once. Opens a window.
window = sg.Window('Robot Arm Interface', layout, location=(200, 0))

# Continue looping forever.
while True:
    # Check for events, update values
    event, values = window.read(timeout=20)
    if event in (None, 'exit'):     # If window is closed or exit button pressed, close program.
        break
    elif event == 'capimg':         # Routine for when "Capture Image" button is pressed.
        recording = False
        final_img = frame
        window['imgtext'].update('Image to use:')
        window['sendimg'].update(disabled=False)
        window['capimg'].update(disabled=True)
        window['retake'].update(disabled=False)
    elif event == 'retake':         # Routine for when "Clear Image" button is pressed.
        recording = True
        window['imgtext'].update('Webcam Output:')
        window['sendimg'].update(disabled=True)
        window['capimg'].update(disabled=False)
        window['retake'].update(disabled=True)
        window['inputbox'].update("")
        values['inputbox'] = ""
    elif event == 'sendimg':        # Routine for when "Send Image" button is pressed.
        print("Sending image to OpenCV...")
        easycall.streamFromImage(final_img, colorPalette, granularity, maxLines, paperSize, reportDone,
                                 easycall.giveCommand(reportSend), reportSent, easycall.serialStream(com, baud))

    elif event == 'sendGcode':      # Routine for when "Send GCode File" button is pressed.
        print("Sending GCode...")
        gcode = open(file_path).read()
        ftp
        easycall.streamFromGcode(gcode, reportDone, easycall.giveCommand(reportSend), reportSent,
                                 easycall.serialStream(com, baud))
    elif event == 'apply':          # Routine for when "Apply" button is pressed.
        print("Saved OpenCV Settings:")

        # Update all OpenCV settings
        color1 = int(values['color1'], 16)
        color2 = int(values['color2'], 16)
        color3 = int(values['color3'], 16)
        colorPalette = [(color1 >> 16, color1 % (2 ** 16) >> 8, color1 % (2 ** 8)),
                        (color2 >> 16, (color2 % (2 ** 16)) >> 8,
                         color2 % (2 ** 8)), (color3 >> 16, (color3 % (2 ** 16)) >> 8, color3 % (2 ** 8))]
        print("Color Palette: {}".format(colorPalette))
        granularity = float(values['granularity'])
        print("Granularity: {}".format(granularity))
        maxLines = int(values['maxlines'])
        print("Max Lines: {}".format(maxLines))
        paperSize = (float(values['dim1']), float(values['dim2']))
        print("Paper Size: {}".format(paperSize))

    # Update image displayed in GUI
    if recording:  # Only update webcam image when in live video mode
        # From https://github.com/PySimpleGUI/PySimpleGUI/blob/master/DemoPrograms/Demo_OpenCV_Webcam.py example
        ret, frame = cap.read()
        height = frame.shape[0]
        width = frame.shape[1]
        imgbytes = cv2.imencode('.png', frame)[1].tobytes()
        window['image'].update(data=imgbytes)
    file_path = str(values['inputbox'])
    if file_path.lower().endswith(('.png')):  # If a .png file is selected, enable sending image data.
        #window['sendimgfile'].update(disabled=False)
        tempimg = cv2.imread(file_path)
        final_img = tempimg
        dim = (min(int(tempimg.shape[1]/tempimg.shape[0]*height), width), height)
        final_img_disp = cv2.resize(tempimg, dim, interpolation=cv2.INTER_LANCZOS4)
        final_imgbytes = cv2.imencode('.png', final_img_disp)[1].tobytes()
        window['image'].update(data=final_imgbytes)
        recording = False
        window['imgtext'].update('Image to use:')
        window['sendimg'].update(disabled=False)
        window['capimg'].update(disabled=True)
        window['retake'].update(disabled=False)
    if file_path.lower().endswith(('.txt', '.gcode', '.mpt', '.mpf', '.nc')):   # If a GCode file is selected, enable
                                                                                # sending GCode
        window['sendGcode'].update(disabled=False)
    else:
        window['sendGcode'].update(disabled=True)

# Close window when loop is broken.
window.close()
