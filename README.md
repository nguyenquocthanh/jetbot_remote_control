# jetbot-remote-control
This is very basic example project which control Nvidia Jetbot remotely via iOS app
Based on jetbot of Nvidia, adding sample source code connecting with mqtt broker.

This project is tested on Waveshare Jetbot as link:
https://www.waveshare.com/jetbot-ai-kit.htm

# Setup on Jetbot

Run command:
```
	git clone https://github.com/nguyenquocthanh/jetbot-remote-control
	cd jetbot-remote-control/jetbot_py
	pip3 install -r requirement.txt
	python3 ./sample/jetbot_remote_ctrl.py
```
Troubleshooting:

If any problem while installing python packages, you could try manually by links below:

https://github.com/adafruit/Adafruit-Motor-HAT-Python-Library

https://github.com/eclipse/paho.mqtt.python

https://github.com/ipython/traitlets

# Setup on iOS (updating):
...
