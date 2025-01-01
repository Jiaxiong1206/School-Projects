import LCD1602
import KPLIB

from time import sleep
import threading
myPad=KPLIB.keypad(retChar='D')
LCD1602.init(0x27,1)
myString=''
pwd='1'
import cv2
import numpy as np
cap = cv2.VideoCapture(0)
ret, frame1 = cap.read()
ret, frame2 = cap.read()

from pygame import mixer
mixer.init()
mixer.music.load('/home/pi/Desktop/Mecha2/al1.mp3')

def readKP():
    global myString
    while myString != '*': #to stop programme
        myString=myPad.readKeypad()
        sleep(.5)
readThread=threading.Thread(target=readKP,)
readThread.daemon=True
readThread.start()

LCD1602.write(0,1,'Ready          ')

while myString != '*':
    CMD=myString
    if CMD=='B'+pwd:
        print("Unarmed")
        LCD1602.write(0,0,'UnArmed        ')
        LCD1602.write(0,1,'               ')
        cv2.destroyAllWindows()
        mixer.music.stop()
        
    if CMD=='C'+pwd:
        print("Password?") 
        LCD1602.write(0,0,'Password?      ')
        LCD1602.write(0,1,'               ')
        while myString=='C'+pwd:
            pass
        pwd=myString
        print(pwd)
        LCD1602.write(0,0,pwd+'         ')
        sleep(2)
        LCD1602.write(0,0,'               ')
        LCD1602.clear()
        
    if CMD=='A'+pwd:
        print("Armed")
        LCD1602.write(0,0,'Armed          ')
        
        while cap.isOpened():
            mot = 0
            print(mot)
            diff = cv2.absdiff(frame1, frame2)
            gray = cv2.cvtColor(diff, cv2.COLOR_BGR2GRAY)
            blur = cv2.GaussianBlur(gray, (5,5), 0)
            _, thresh = cv2.threshold(blur, 20, 255, cv2.THRESH_BINARY)
            dilated = cv2.dilate(thresh, None, iterations=3)
            contours, _ = cv2.findContours(dilated, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
           
                    
            for contour in contours:
                (x, y, w, h) = cv2.boundingRect(contour)
                if cv2.contourArea(contour) < 700:
                    continue
                mot = 1
                print(mot)
                cv2.rectangle(frame1, (x, y), (x+w, y+h), (0, 255, 0), 2)
                cv2.putText(frame1, "Status: {}".format('Movement'), (10, 20), cv2.FONT_HERSHEY_SIMPLEX,1, (0, 0, 255), 3)
            
            cv2.imshow("feed", frame1)
            frame1 = frame2
            ret, frame2 = cap.read()
            
            cv2.waitKey(25)
            
            break
    
        if mot == 0:
            print("All Clear")
            LCD1602.write(0,1,'All Clear       ')
            mixer.music.stop()
        elif mot == 1:
            print("Movement")
            LCD1602.write(0,1,'Intruder Alert')
            mixer.music.play()
        
    continue

sleep(1)
mixer.music.stop()    
cv2.destroyAllWindows()
LCD1602.clear()
LCD1602.write(0,1,'Turning Off       ')
sleep(3)
LCD1602.clear()
print("End")
