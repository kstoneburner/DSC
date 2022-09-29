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

import socket
import binascii

import win32gui

folder_path = "./music/1_0_0 - 3pm Playlist"

music_path = "./music/"
file_types = [".mp3",".wav", ".aiff"]

#//*** Clear the Screen on each action. False aids in debugging.
clear_screen = True

pc = {

    #//*** Build Playlist
    "playlist" : [],
    "play_counter" : 0,
    "display_name" : "",
    "playing" : False,
    "quit" : False,
    "action" : None,
    "socket" : socket.socket(socket.AF_INET, socket.SOCK_STREAM),
    "conn" : None,
    "addr" : None,
    "selected_cut" : None,
    "cut_index" : None,
    "cut" : {}
    
}   




key = "lol"




# specify Host and Port
HOST = '172.24.132.148'
PORT = 8001

def listen_for_digi():   
    #soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      
    with pc["socket"] as s:
        s.bind((HOST, PORT))
        s.listen()
        try:
            pc["conn"], pc["addr"] = s.accept()
        except:
            return
        print("=====")
        with pc["conn"]: 
            print(f"Connected by {pc['addr']}")
            print(pc["conn"])
            do_ack = False
            while not pc["quit"]:
                print("-")
                try:
                    data = pc["conn"].recv(1024)
                    if not data:
                        break
                    print("Received: ", data)
                    handleInput(data)

                    #if not do_ack:
                    #    do_ack = True
                    #    conn.sendall(data)
                except KeyboardInterrupt:
                    pc["conn"].close(); s.close();break;
            pc["conn"].close()
            s.close()

def capture_keystroke_threaded():
    global keystroke
    lock = threading.Lock()
    loop = True
    while not pc["quit"]:
        with lock:
            time.sleep(.1)
            keystroke = keyboard.read_key()
            if keyboard.is_pressed(keystroke):

                if pc['active_window_text'] == win32gui.GetWindowText (win32gui.GetForegroundWindow()):
                    #print(keystroke)

                    if keystroke == "space":
                        pc["action"] = "play/pause"
                        
                    elif keystroke == "right":
                        pc["action"] = "next_song"
                    
                    elif keystroke == "left":
                       pc["action"] = "stop"

                    elif keystroke == "down":
                       pc["action"] = "next_track"

                    elif keystroke == "up":
                       pc["action"] = "prev_track"

                    elif keystroke == "esc":
                        do_action("quit")

def handleInput(raw_data):


    if len(raw_data) < 17:
        return
    
    play = [8, 160, 80 ]
    stop = [2, 160, 108 ]
    pause = [3, 160, 64]
    
    #//*** raw_data is a Binary Array
    #//*** Convert each Binary bit to an integer
    data = []
    for x in raw_data:
        #print(int(x),str(x),chr(x))
        data.append(int(x))
    
    #//*** Strip first 17 characters, these are consistent values
    data = data[17:]
    print(data,data[:3])
    
    #//*** First 3 elements dictate the command
    command = data[:3]
    

    if command == play:
        
        #//*** Get the Values of Clip to Play
        cut = data[4:8]
        
        #//*** Convert Each value to a String based on the Byte Integer Separated By _
        cut = ""
        for x in data[4:8]:
            cut += str(x)+"_"

        #//*** Trim Trailing _
        cut = cut[:-1]

        #//*** Perform Digi Play Action
        do_action("DIGI_PLAY",cut)
    
    if command == stop:
        print("DIGI STOP")

        #//*** Perform Digi Play Action  
        do_action("DIGI_STOP")

    if command == pause:
        print("PAUSE")

        do_action("DIGI_PAUSE")

def is_valid_filetype(filename):
    for file_type in file_types:
        if file_type in filename:
            return True
    return False

def sort_folder(files):

    #//*** Sort by Drive, Folder, Cut so everything is in Digicart Order

    out = []
    compare = []
    hier = {}

    #//*** Build an object heirarchy based on drive, folder, cut
    for file in files:
    
        drive = int(file.split("_")[0])
        folder = int(file.split("_")[1])
        cut = int(file.split("_")[2].split(" ")[0])

        if drive not in hier.keys():
            hier[drive] = {}

        if folder not in hier[drive].keys():
            hier[drive][folder] = []

        hier[drive][folder].append(cut)

        

    #//*** Loop through hierarchy and sort each level as we loop down
    #//*** Build ordered list in Compare
    for drive in sorted(list(hier.keys())):
        for folder in sorted(list(hier[drive].keys())):
            for cut in sorted(hier[drive][folder]):
                print(f"drive: {drive} Folder: {folder} Cut: {cut}")
                compare.append(f"{drive}_{folder}_{cut}")


    #//*** Build ordered list of actual filenames based on compare order
    for stem in compare:

        for file in files:

            target = file.split(" ")[0]

            #//*** Target Matches Stem, this is out File
            if stem == target:
                out.append(file)
                
    
    return out

def do_action(input_action,input_cut=None):

    if input_action == "scan": 
        
        #//*** Sort Filenames then process each file or playlist
        for filename in sort_folder(os.listdir(music_path)):
            
            #//*** Process Filename as a playlist Folder
            if os.path.isdir(music_path + filename):
                error = False

                #//*** Build Cutname
                #//*** Assume Cut is separated by spaces
                try:
                    raw_cut = filename.split(" ")[0]
                except:
                    error = True

                if error:
                    print("Problem Processing TrackName for Digicart Cut Reference")
                    print(filename)
                    print("Format is drive_directory_cut <--- Followed by a space and any text you'd like")
                    continue    
            
                music_obj = {
                    "type" : "playlist",
                    "track_names" : [],
                    "track_paths" : [],
                    "selected" : 0,
                }

                playlist_path = music_path + filename
                
                #//*** Validate Individual Tracks
                for x in os.listdir(playlist_path):
                    
                    #//*** Only work with files
                    if os.path.isfile(playlist_path+"/"+x):
                        
                        #//*** Verify file has correct extension
                        if is_valid_filetype(x):

                            #//*** Add Track Name
                            music_obj["track_names"].append(x)
                            #//*** Add Full Path
                            music_obj["track_paths"].append( playlist_path+"/"+x )

                #//*** If there are track_names then add music_obj to pc["cut"]
                if len(music_obj["track_names"]) > 0:

                    #//*** Add music Object to pc["cut"]
                    pc["cut"][raw_cut] = music_obj

            else:
                #//*** Build Music Object for individual files
                error = False

                #//*** Build Cutname
                #//*** Assume Cut is separated by spaces
                try:
                    raw_cut = filename.split(" ")[0]
                except:
                    error = True

                if error:
                    print("Problem Processing TrackName for Digicart Cut Reference")
                    print(filename)
                    print("Format is drive_directory_cut <--- Followed by a space and any text you'd like")
                    continue    

                music_obj = {
                    "type" : "file",
                    "track_names" : [],
                    "track_paths" : [],
                    "selected" : 0,
                }

                filepath = music_path + filename

                    
                #//*** Verify file has correct extension
                if is_valid_filetype(x):

                    #//*** Add Track Name
                    music_obj["track_names"].append(filename)
                    #//*** Add Full Path
                    music_obj["track_paths"].append( filepath )

                #//*** Add music Object to pc["cut"]
                pc["cut"][raw_cut] = music_obj

        #for key,value in pc["cut"].items():
        #    print(key,value)
        #    print("========")
        return

    if input_action == "init":
        """
        for filename in os.listdir(folder_path):
            if os.path.isfile(folder_path + "/" + filename):
                pc["playlist"].append(folder_path + "/" + filename)
                pc["p"] = vlc.MediaPlayer(pc["playlist"][pc["play_counter"]])
                pc["display_name"] = pc["playlist"][pc["play_counter"]]
        """

        music_objs = pc["cut"]
        pc["cut_index"] = 0
        if len(list(music_objs.keys())) > 0:


            pc["selected_cut"] = list(music_objs.keys())[pc["cut_index"]]

            track_filename = music_objs[ pc["selected_cut"] ]['track_paths'][0]
            pc["p"] = vlc.MediaPlayer(track_filename)

        else:
            
            print("No Songs or Playlists in Music Folder")
            pc["quit"] = True

        #//*** Get Current window name
        pc['active_window_text'] = win32gui.GetWindowText (win32gui.GetForegroundWindow())


    if input_action == "stop":
        pc["playing"] = False
        while pc["p"].is_playing():
            pc["p"].stop()
            time.sleep(.01)

    if input_action == "play/pause":

        #//*** Toggle the value of playing
        pc["playing"] = not pc["playing"] 

        #//*** Play if we should be playing
        if pc["playing"]:

            print("start playing")
            pc["p"].play()

            #//*** Wait till player indicates playing. Helps with timing
            while not pc["p"].is_playing():
                time.sleep(.01)
        else:
            #//*** Pause Playing 
            print("pause playing")
            pc["p"].pause()
            #//*** Wait till player indicates playing has stopped. Helps with timing
            while pc["p"].is_playing():
                time.sleep(.01)

    if input_action == "next_song":

        #//*** Get the Music Object
        music_obj = pc['cut'][ pc["selected_cut"] ]

        #//*** Do Nothing unless it's a playlist Object
        if music_obj["type"] != "playlist":
            return

        #//*** Add Code to quit on file. Continue if Playlist

        #//*** Increment counter
        music_obj["selected"] += 1

        if music_obj["selected"] >= len(music_obj["track_paths"]):
            music_obj["selected"] = 0


        if pc["playing"] == True:
            while pc["p"].is_playing():
                pc["p"].stop()
                time.sleep(.01)

            #//*** Get the filepath as track
            selected_index = music_obj["selected"]
            track = music_obj['track_paths'][selected_index]

            #//*** Load Song
            pc["p"] = vlc.MediaPlayer(track)

            #//*** Play Song
            pc["p"].play()

            
            #//*** Ensure the player is playing before moving on 
            while not pc["p"].is_playing():
                time.sleep(.01)
        else:

            #//*** Get the filepath as track
            selected_index = music_obj["selected"]
            track = music_obj['track_paths'][selected_index]

            #//*** Load Song
            pc["p"] = vlc.MediaPlayer(track)

    if input_action == "next_track" or input_action == "prev_track":

        #"selected_cut" : None,
        #"cut_index" : None,
        #"cut" : {}

        cut_list = list(pc['cut'].keys())

        if input_action == "next_track":
            pc["cut_index"] += 1

            if pc["cut_index"] >= len(cut_list):
                pc["cut_index"] = 0

        if input_action == "prev_track":
            pc["cut_index"] -= 1

            if pc["cut_index"] < 0:
                
                pc["cut_index"] = len(cut_list) - 1 

        pc["selected_cut"] = cut_list[ pc["cut_index"] ]
        
        music_obj = pc["cut"][ pc["selected_cut"] ]

        #//*** Stop Existing Track
        pc["p"].stop()

        #//*** Wait till player indicates playing has stopped. Helps with timing
        while pc["p"].is_playing():
            time.sleep(.01)

        #//*** Assign New Track
        #//*** Get the filepath as track
        selected_index = music_obj["selected"]
        track = music_obj['track_paths'][selected_index]

        #//*** Load Song
        pc["p"] = vlc.MediaPlayer(track)


        #//**** Load and Play the Track
        if pc["playing"]:

            pc["p"].play()

            #//*** Wait till player indicates playing. Helps with timing
            while not pc["p"].is_playing():
                time.sleep(.01)


    if input_action == "DIGI_PLAY":
        

        #//*** Check if selecting currently selected cut
        if pc["selected_cut"] == input_cut:

            #//*** Check if already playing
            if pc["playing"]:

                #//*** If Playlist, and Playing, do Nothing. Track list is already playing on repeat
                
                #//*** Get the Music Object
                music_obj = pc['cut'][ pc["selected_cut"] ]

                #//*** Do Nothing unless it's a playlist Object
                if music_obj["type"] == "playlist":
                    return

            else:

                #//*** Not Playing
                pass

            pc["playing"] = True    

        else:
            #//*** Print Handle different cut

    if input_action == "DIGI_STOP":
        print("Do some stuff with DIGI_STOP")

    if input_action == "quit":
        pc["quit"] = True

    
    #//*** Draw Display Section


    try:
        cut = pc['selected_cut']
    except:
        cut = "None"
    try:
        cut_type = pc['cut'][cut]["type"]
    except:
        cut_type = "None"

    music_obj = pc['cut'][ pc["selected_cut"] ]

    selected_index = music_obj["selected"]

    track = music_obj['track_paths'][selected_index]

    out = ""
    out += f"Cut: {cut}"
    out += "\n"
    out += f"Type: {cut_type}"  
    out += "\n"
    out += f"Track: {track}" 
    out += "\n"
    out += "\n"
    out += "Playing: " + str(pc["playing"])
    out += "\n"
    out += "SPACE: Play/Pause, LEFT: Stop"
    if cut_type == "playlist":
        out += ", RIGHT: Next Playlist Item"
    out += "\n"
    out += "DOWN:  Next Track/Playlist"
    

    if clear_screen:
        os.system('cls')
    
    print(out)

#//*************************
#//*** END DO do_action()  
#//*************************


print("Scan")
do_action("scan")
print("INIT")
do_action("init")



threading.Thread(target = capture_keystroke_threaded).start()
threading.Thread(target = listen_for_digi).start()

while True:
    time.sleep(.1)

    

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
        #threading.Thread(target = listen_for_digi)._stop()
        threading.Thread(target = capture_keystroke_threaded)._stop()
        try:
            pc["conn"].close()
        except:
            pass
        try:
            pc["socket"].close()
        except:
            pass
        sys.exit()

 