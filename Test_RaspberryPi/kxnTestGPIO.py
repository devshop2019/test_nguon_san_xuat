#https://github.com/devshop2019/test_nguon_san_xuat/tree/master/Test_RaspberryPi
# Neu chan nao bi loi se bao len
from array import *
import RPi.GPIO as gpio
import time

pin = 5
array1 = array('i', [10,20,30,40,50])
kxnErrcode = 2

def testPullup():
    global kxnErrcode
    for cf in range (1, 26):
        gpio.setup(cf, gpio.IN, pull_up_down=gpio.PUD_UP)
    
    for cf in range (1, 26):
        if gpio.input(cf) == 0:
            print("pin " + str(cf) + "pull UP fail!")
            kxnErrcode = 1
            
def testPulldown():
    global kxnErrcode
    for cf in range (1, 26):
        gpio.setup(cf, gpio.IN, pull_up_down=gpio.PUD_DOWN)
    
    for cf in range (1, 26):
        if gpio.input(cf) == 1:
            gpio.setup(cf, gpio.OUT)
            gpio.output(cf, gpio.LOW)
            if gpio.input(cf) == 1:
                gpio.setup(cf, gpio.IN, pull_up_down=gpio.PUD_DOWN)
                print("pin " + str(cf) + "pull DOWN fail!")
                kxnErrcode = 1
                print(kxnErrcode)

gpio.setmode(gpio.BCM)
#gpio.setup(6, gpio.IN, pull_up_down=gpio.PUD_UP)
#gpio.setup(pin, gpio.IN, pull_up_down=gpio.PUD_UP)
gpio.setwarnings(False)
print("first errcode " + str(kxnErrcode))
try:
    while True:
        testPullup()
        testPulldown()
        if kxnErrcode == 2:
            print("All Pin Test OK " + str(kxnErrcode))
        time.sleep(1)
        #gpio.output(18, gpio.HIGH)
        #passcode = raw_input("What is pi?: ")
        
        #if passcode == "Awesome":
        #    gpio.output(18, gpio.LOW)
        #    time.sleep(4)
       # 
        #else:
          #  gpio.output(18, gpio.HIGH)
         #   print("Wrong Password!")
        
finally:
    gpio.cleanup()
