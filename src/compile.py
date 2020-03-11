from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext



ext_modules=[
    Extension("HPS_to_FPGA" ,["HPS_to_FPGA/hps_to_fpga_python.py"]),
    Extension("Vision", ["Vision/vision.py"]),
    Extension("easycall", ["GUI/easycall.py"]),
    Extension("GUI", ["GUI/GUI_v0.py"]),
] 

setup (
        name = 'HPS_GUI',
        cmdclass = {'build_ext':build_ext},
        ext_modules=ext_modules
)
