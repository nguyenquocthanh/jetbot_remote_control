# import context  # Ensures paho is in PYTHONPATH
import paho.mqtt.subscribe as subscribe
from robot import Robot
import time

robot = Robot()

topic_name = "mv_jetbot_tnq_2020_439487293474234/desired"

cmd_fwd = "{\"ctl\": \"fwd\"}"
cmd_bwd = "{\"ctl\": \"bwd\"}"
cmd_stop = "{\"ctl\": \"stop\"}"
cmd_left = "{\"ctl\": \"left\"}"
cmd_right = "{\"ctl\": \"right\"}"
encoding = 'utf-8'

def callback_func(client, userdata, message):    
    print("%s : %s" % (message.topic, message.payload))
    msg = message.payload
    msg = ''.join(map(chr, msg))
    #print(type(msg))
    #print(msg)
    #print(cmd_fwd)
    if(msg == cmd_fwd):
        print("go fwd")
        robot.forward(0.3)
        time.sleep(0.5)
        robot.stop()
    elif(msg == cmd_bwd):
        print("go bwd")
        robot.backward(0.3)
        time.sleep(0.5)
        robot.stop()
    elif(msg == cmd_left):
        print("go left")
        robot.left(0.2)
        time.sleep(0.3)
        robot.stop()
    elif(msg == cmd_right):
        print("go right")
        robot.right(0.2)
        time.sleep(0.3)
        robot.stop()
    elif(msg == cmd_stop):
        print("stop")
        robot.stop()

subscribe.callback(callback_func, topic_name, hostname="mqtt.eclipseprojects.io")
