import glob
import subprocess
from setuptools import setup, find_packages, Extension

def build_libs():
    subprocess.call(['cmake', '.'])
    subprocess.call(['make'])
# build_libs()
setup(
    name='jetbot-remote-control',
    version='0.0.1',
    description='An open-source robot based on NVIDIA Jetson Nano, adding iOS sample app to control remotely',
    packages=find_packages(),
    install_requires=[
        'Adafruit_MotorHat',
        'Adafruit-SSD1306',
        'paho-mqtt',
    ],
)
