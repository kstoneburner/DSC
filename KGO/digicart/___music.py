#from playsound import playsound
#playsound("test.mp3",True)
import time,sys
import vlc #pip install python-vlc
import os
import keyboard #pip install keyboard
#from pynput import keyboard #pip install pynput
#//*** Keyboard basics
#https://www.delftstack.com/howto/python/python-detect-keypress/
#//*** Threading Keyboard listener
#https://stackoverflow.com/questions/14043441/how-to-use-threads-to-get-input-from-keyboard-in-python-3
import threading
#from pathlib import Path


folder_path = "./music/1000 - 3pm"

print()

pc = {

    #//*** Build Playlist
    "playlist" : [],
    "play_counter" : 0,
    "display_name" : "",
    "playing" : False,
    "quit" : False,
    "action" : None,



}



from msvcrt import getch

key = "lol"

def capture_keystroke_threaded():
    global keystroke
    lock = threading.Lock()
    loop = True
    while loop:
        with lock:
            time.sleep(.1)
            keystroke = keyboard.read_key()
            if keyboard.is_pressed(keystroke):
                print(keystroke)
                if keystroke == "space":
                    pc["action"] = "play/pause"
                    
                elif keystroke == "right":
                    pc["action"] = "next_song"
                elif keystroke == "left":
                    print("KEYBOARD left")
                elif keystroke == "esc":
                    do_action("quit")
                    return



def do_action(input_action):

    if input_action == "init":
        for filename in os.listdir(folder_path):
            if os.path.isfile(folder_path + "/" + filename):
                pc["playlist"].append(folder_path + "/" + filename)
                pc["p"] = vlc.MediaPlayer(pc["playlist"][pc["play_counter"]])
                pc["display_name"] = pc["playlist"][pc["play_counter"]]
                print("Playing: " + pc["playlist"][pc["play_counter"]])

                print("SPACE: Play/Pause, LEFT Arrow: Restart, RIGHT Arrow: Next")

    if input_action == "play/pause":

        pc["playing"] = not pc["playing"] 

        if pc["playing"]:
            print("start playing")
            pc["p"].play()
            while not pc["p"].is_playing():
                time.sleep(.01)
            

        else:
            print("pause playing")
            pc["p"].pause()
            while pc["p"].is_playing():
                time.sleep(.01)

    if input_action == "next_song":
        pc["playing"] = True
        while pc["p"].is_playing():
            pc["p"].stop()
            time.sleep(.01)

        #//*** Increment counter
        pc["play_counter"]+=1

        if pc["play_counter"] >= len(pc["playlist"]):
            pc["play_counter"] = 0

        pc["p"] = vlc.MediaPlayer(pc["playlist"][pc["play_counter"]])
        pc["p"].play()
        print("Playing: " + pc["playlist"][pc["play_counter"]])

        #//*** Ensure the player is playing before moving on 
        while not pc["p"].is_playing():
            time.sleep(.01)


    if input_action == "quit":
        print("QUIT?")
        pc["quit"] = True



print("init")
do_action("init")


threading.Thread(target = capture_keystroke_threaded).start()

while True:

    
    time.sleep(.5)

    
    print(pc["playing"],pc["quit"],pc["action"])

    #//*** Check current Action
    if pc["action"] != None:
        do_action(pc["action"])
        pc["action"] = None

    #"""
    #//*** Advance Playlist if actually playing
    if pc["playing"]:
        if not pc["p"].is_playing():
            do_action("next_song")            


            
            #break
    #"""
    if pc["quit"]:
        sys.exit()

