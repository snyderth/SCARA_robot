import PySimpleGUI as sg
import cv2
import numpy as np

sg.theme('Reddit')

cap = cv2.VideoCapture(0)
recording = False
final_img = None
frame = None
ret = None

menu_lay = [[sg.Text('Select an input method', key='text')],
            [sg.Button('G-Code File', key='gc'), sg.Button('Computer Vision', key='cv')]]

file_brow_lay = [[sg.Button('Back', key='back1')],
                 [sg.Text('Select G-Code file to read from', key='file_text')],
                 [sg.Input(key='inputbox'), sg.FileBrowse(key='browse')],
                 [sg.Button('OK', key='OK')]]

live_cam_lay = [[sg.Button('Back', key='back2')],
                [sg.Text('Capture an image from the webcam', key='cam_text')],
                [sg.Image(filename='', key='image')],
                [sg.Button('Capture Image', key='capimg')]]

confirm_img_lay = [[sg.Button('Back', key='back3')],
                   [sg.Text('Confirm image?', key='confirm_text')],
                   [sg.Image(filename='', key='image_f')],
                   [sg.Button('Retake', key='retake'), sg.Button('Confirm', key='confirm')]]

cv_settings_lay = [[sg.Button('Back', key='back_to_cam')],
                   [sg.Text('Enter computer vision parameters', key='cv_text')],
                   [sg.Text('Color Palette (int)', size=(18, 1)), sg.Input(size=(13, 1), key='color1'), sg.Input(size=(13, 1), key='color2'), sg.Input(size=(13, 1), key='color3')],
                   [sg.Text('Granularity (float)', size=(18, 1)), sg.Input(key='granularity')],
                   [sg.Text('Max Lines (int)', size=(18, 1)), sg.Input(key='maxlines')],
                   [sg.Text('Paper Size in mm (int)', size=(18, 1)), sg.Input(size=(21,1), key='dim1'), sg.Input(size=(21,1), key='dim2')],
                   [sg.Button('Submit', key='submit')]]

layout = [[sg.Column(menu_lay, key='menu'), sg.Column(file_brow_lay, visible=False, key='file'), sg.Column(live_cam_lay, visible=False, key='live'),
           sg.Column(confirm_img_lay, visible=False, key='con'), sg.Column(cv_settings_lay, visible=False, key='cv_set')],
          [sg.Button('Exit', key='Exit')]]

window = sg.Window('Robot Arm', layout, location=(800, 400))

while True:
    event, values = window.read(timeout=20)
    if event in (None, 'Exit'):
        break
    elif event in ('back1', 'back2', 'back3'):
        recording = False
        window['menu'].update(visible=True)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)
    elif event == 'gc':
        window['menu'].update(visible=False)
        window['file'].update(visible=True)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)
    elif event in ('cv', 'retake'):
        recording = True
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=True)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=False)

    elif event in ('capimg', 'back_to_cam'):
        recording = False
        imgbytes = cv2.imencode('.png', frame)[1].tobytes()
        final_img = imgbytes
        window['image_f'].update(data=imgbytes)
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=True)
        window['cv_set'].update(visible=False)
    elif event == 'confirm':
        window['menu'].update(visible=False)
        window['file'].update(visible=False)
        window['live'].update(visible=False)
        window['con'].update(visible=False)
        window['cv_set'].update(visible=True)
    elif event == 'OK':
        file_path = values['inputbox']
        # Execute G code here

        break

    elif event == 'submit':
        colorPalette = [(values['color1'], values['color2'], values['color3'])]
        granularity = values['granularity']
        maxLines = values['maxlines']
        paperSize = (values['dim1'], values['dim2'])
        # Call CV function here

        break

    if recording:
        # From https://github.com/PySimpleGUI/PySimpleGUI/blob/master/DemoPrograms/Demo_OpenCV_Webcam.py example
        ret, frame = cap.read()
        imgbytes = cv2.imencode('.png', frame)[1].tobytes()
        window['image'].update(data=imgbytes)
window.close()