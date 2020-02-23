"""
    Program:    GUI_v0.py
    Author:     Kyle Noble
    Date:       2/6/2020

    Description:
        Uses the PySimpleGUI library to create a Graphical User Interface
        for a Selective Compliance Assembly Robot Arm (SCARA).

        User can capture images using a webcam, load their own .png image,
        or load a .gcode file.

        Each GUI page has a layout. The main layout will display one of these
        layouts at a time and the buttons will trigger events that changes
        between the layouts.

        WIP

        TODO:
            Finish up progress screen: add loading bar
            Connect loading screen to rest of GUI with button events
            Restrict file type on file browser.
            Call functions for other blocks.
            Remove redundant/unnecessary visibilty updates.

"""

import PySimpleGUI as sg
import cv2
import numpy as np
def test_func(colorPalette, granularity, maxlines, papersize):
    print("Color: ",colorPalette, "Granularity: ", granularity, "maxlines: ", maxlines, "papersize: ", papersize)

sg.theme('Reddit')

cap = cv2.VideoCapture(0)       # select webcam input
recording = False
final_img = None
frame = None
ret = None
prev_screen = None      # 0 for take photo, 1 for load photo

parser_feed = "Initializing"


# Main Menu: Select input type (gcode file, take photo, load photo
menu_lay = [[sg.Text('Select an input method', key='text')],
            [sg.Button('G-Code File', key='gc'), sg.Button('Load a photo', key='load_photo'), sg.Button('Take a Photo', key='cv')]]

# G-code file browser
file_brow_lay = [[sg.Button('Back', key='back1')],
                 [sg.Text('Select G-Code file to read from', key='file_text')],
                 [sg.Input(key='inputbox'), sg.FileBrowse(key='browse')],
                 [sg.Button('OK', key='OK')]]

# Live video feed with a capture button to take a picture
live_cam_lay = [[sg.Button('Back', key='back2')],
                [sg.Text('Capture an image from the webcam', key='cam_text')],
                [sg.Image(filename='', key='image')],
                [sg.Button('Capture Image', key='capimg')]]

# Confirm that the picture you took is good. Otherwise retake.
confirm_img_lay = [[sg.Button('Back', key='back3')],
                   [sg.Text('Confirm image?', key='confirm_text')],
                   [sg.Image(filename='', key='image_f')],
                   [sg.Button('Retake', key='retake'), sg.Button('Confirm', key='confirm')]]

# Enter parameters for openCV contour generation
cv_settings_lay = [[sg.Button('Back', key='back_to_cam')],
                   [sg.Text('Enter computer vision parameters', key='cv_text')],
                   [sg.Text('Color Palette (6 digit hex)', size=(40, 1)), sg.Input(size=(13, 1), key='color1'),
                        sg.Input(size=(13, 1), key='color2'), sg.Input(size=(13, 1), key='color3')],
                   [sg.Text('Granularity (float between 1 and 50)', size=(40, 1)), sg.Input(key='granularity')],
                   [sg.Text('Max Lines (int between 1 and 1000)', size=(40, 1)), sg.Input(key='maxlines')],
                   [sg.Text('Paper Size in mm (int in [10, 279], int in [10, 215])', size=(40, 1)),
                        sg.Input(size=(21,1), key='dim1'), sg.Input(size=(21,1), key='dim2')],
                   [sg.Button('Submit', key='submit')]]

# Image file browser
load_png_lay = [[sg.Button('Back', key='back4')],
                [sg.Text('Select a .png image file', key='img_file_text')],
                [sg.Input(key='img_path'), sg.FileBrowse(key='browse2')],
                [sg.Button('OK', key='OK_photo')]]

# For displaying parser activities an progress. Tells user when to change tools
parser_feedback_lay = [[sg.Button('Cancel', key='cancel')],
                       [sg.Text(parser_feed, key='parser_feed')]]

# Each of the above layouts is a column whose visibility can be changed to depict a certain screen.
layout = [[sg.Column(menu_lay, key='menu'), sg.Column(file_brow_lay, visible=False, key='file'),
                sg.Column(live_cam_lay, visible=False, key='live'),
                sg.Column(confirm_img_lay, visible=False, key='con'),
                sg.Column(cv_settings_lay, visible=False, key='cv_set'),
                sg.Column(load_png_lay, visible=False, key='load_png'),
                sg.Column(parser_feedback_lay, visible=False, key='parse')],
          [sg.Button('Exit', key='Exit')]]
		  




window = sg.Window('Robot Arm', layout, location=(800, 400))

while True:
    event, values = window.read(timeout=20)
    if event in (None, 'Exit'):
        break
    elif event in ('back1', 'back2', 'back3', 'back4'):     # return to main menu
        recording = False
        window['menu'].update(visible=True)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)
        window['load_png'].update(visible=False)
    elif event == 'gc':                                     # gcode file browser
        window['menu'].update(visible=False)
        window['file'].update(visible=True)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)
    elif event in ('cv', 'retake'):                         # Live webcam feed
        recording = True
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=True)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)

    elif event in ('capimg', 'back_to_cam'):                # Still image of last webcam frame captured
        recording = False
        imgbytes = cv2.imencode('.png', frame)[1].tobytes()
        final_img = frame
        window['image_f'].update(data=imgbytes)
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=True)
        window['cv_set'].update(visible=False)
    elif event == 'confirm':                                # Enter openCV params
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=True)
    elif event == 'OK':                                     # Submit gcode file path
        file_path = values['inputbox']
        # Execute G code here

        window['file'].update(visible=False)
        window['parse'].update(visible=True)

    elif event == 'load_photo':                             # load photo in
        prev_screen = 1
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)
        window['load_png'].update(visible=True)

    elif event == 'submit':                                 # Display progress after submitting openCV params
        color1 = int(values['color1'], 16)
        color2 = int(values['color2'], 16)
        color3 = int(values['color3'], 16)
        colorPalette = [(color1 >> 16,  color1 % (2**16) >> 8, color1 % (2**8)), (color2 >> 16, (color2 % (2**16)) >> 8,
                        color2 % (2**8)), (color3 >> 16,  (color3 % (2**16)) >> 8, color3 % (2**8))]
        print(colorPalette)
        granularity = values['granularity']
        maxLines = values['maxlines']
        paperSize = (values['dim1'], values['dim2'])
        # final_img is image to be sent
        cv2.imwrite("final_image.png", img=final_img)
        # Call CV function here
        test_func(colorPalette, granularity, maxLines, paperSize)

        window['cv_set'].update(visible=False)
        window['parser_feed'].update(visible=True)

    if recording:                                           # Only update webcam image when in live video mode
        # From https://github.com/PySimpleGUI/PySimpleGUI/blob/master/DemoPrograms/Demo_OpenCV_Webcam.py example
        ret, frame = cap.read()
        imgbytes = cv2.imencode('.png', frame)[1].tobytes()
        window['image'].update(data=imgbytes)
window.close()

# A function that can be called to update the text displayed on the progress screen.
def update_feed(new_text: str):
    window['parser_feed'].update(new_text)
    return

def test_func(colorPalette, granularity, maxlines, papersize):
    print("Color: ",colorPalette, "Granularity: ", granularity, "maxlines: ", maxlines, "papersize: ", papersize)
