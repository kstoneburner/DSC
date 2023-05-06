import win32gui, os, sys
import time, threading, pyperclip, keyboard, re

from pywinauto import application
import pywinauto 
import pyautogui

from macros_core_modules import *


# API Calls

#//*** Switcher Crosspoints
# http://10.218.116.11/server/rest/api/crosspoints


# http://10.218.116.11/server/rest/api/videoTransitions
# http://10.218.116.11/server/rest/api/customControls
# http://10.218.116.11/server/rest/api/switcherModels

# http://10.218.116.11/server/rest/api/keywords
# http://10.218.116.11/server/rest/api/mosgateway/overDriveServer
# http://10.218.116.11/server/rest/api/mosgateway/mosId
# http://10.218.116.11/server/rest/api/mosgateway/buddyMosId/1
# http://10.218.116.11/server/rest/api/licensing/check/nrcsPlugin
# http://10.218.116.11/server/rest/api/server/configuration
# http://10.218.116.11/server/rest/api/licensing/check/features/?featureIds=40,100,50
# http://10.218.116.11/server/rest/api/featureToggle/getAll/?
# http://10.218.116.11/server/rest/api/mosgateway/nrcsConfigName/1
# http://10.218.116.11/server/rest/api/masterTemplates
# http://10.218.116.11/server/rest/api/audioChannels
# http://10.218.116.11/server/rest/api/audioVariable
# http://10.218.116.11/server/rest/api/quickAudio
# http://10.218.116.11/server/rest/api/quickTurnSegments
# http://10.218.116.11/server/rest/api/customControls
# http://10.218.116.11/server/rest/api/switcherModels
# http://10.218.116.11/server/rest/api/crosspoints
# http://10.218.116.11/server/rest/api/keywords
# http://10.218.116.11/server/rest/api/mosgateway/mosId/1
# http://10.218.116.11/server/rest/api/mosgateway/buddyMosId/1






connected = False

app = application.Application()
hk = None
key_director = None
global key_str
key_str = ""

def readRundownLine():
	#pyautogui.keyUp('windows')
	#pyautogui.press('left')

	#pywinauto.keyboard.send_keys("{LEFT}")
	#pywinauto.keyboard.send_keys("{TAB}")
	
	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
	if "Dalet Galaxy" in active_window_text:
		print("Read Rundown")
		
		keyboard.release("windows")
		keyboard.press("ctrl")
		keyboard.send("left")
		keyboard.release("ctrl")	


		dlg = app[active_window_text]
		wrapper = dlg.wrapper_object()

		#keyboard.send("left")

		for dalet_object in wrapper.children():
			#dalet_object.draw_outline()
			if dalet_object.has_keyboard_focus():

				rundown = dalet_object
				if len(rundown.children()) > 0:
					elem = rundown.children()[-1]
				else:
					continue
				
				rd_obj = {}
				for col in all_cols:
					
					elem = rundown.children()[-1]
					#for key,value in elem.get_properties().items():
					#	print( key,":",value)
					elem.automation_id = col
					
					if col in cols:
						print(col,elem.texts()[0],elem.automation_id)
					
					keyboard.send("tab")


					
				#for x in dir(elem):
				#		print(x)
				print(elem.writable_props)	
				keyboard.press_and_release("left")
				print(pyautogui.position())
				#for key,value in elem.get_properties().items():
				#	print( key,":",value)
				
				#print("Texts: ",elem.texts()[0])
								
				break

				rundown.draw_outline()

				for elem in rundown.children():
					elem.draw_outline()
					print(elem)

	else:
		print("Not in Dalet")

def capture_keystroke_threaded():
    global keystroke
    global key_str
    lock = threading.Lock()
    loop = True
    while loop:
        with lock:
            #time.sleep(.1)
            keystroke = keyboard.read_key()
            event = keyboard.read_event()
            #print(keystroke, keyboard.is_pressed("ctrl"),keyboard.is_pressed("shift"),keyboard.is_pressed("win"),keyboard.is_pressed("alt"))
            
            print("handling", keystroke)
            print("Event:", event.to_json())
            print(keyboard.key_to_scan_codes(keystroke))

           

            

            if not keyboard.is_pressed(keystroke):
            	if keystroke != "esc":
            		key_str += f"'{keystroke.lower()}' ,"	
            	else:
            		print(key_str)
	            	
	            	with open("myfile.txt", "w") as file1:
	            		# Writing data to a file
	            		file1.write(key_str)
	            	
            		


            if keystroke in key_director.keys():
            	#//*** Test only on key Release
            	print("handling", keystroke)

            	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
            	if "Dalet Galaxy" in active_window_text:
            		if connected:
            			print("In Dalet: Do Something here")
            			
            			#//*** Test For Valid Hotkeys
            			for hotkey in key_director[keystroke]:
            				print(hotkey.keys())
            				print(hotkey['keystroke'])

            				execute_hotkey = True
            				for modifier in ['ctrl','shift','alt','win']:
            					print(modifier, hotkey['keystroke'][modifier],keyboard.is_pressed(modifier),hotkey['keystroke'][modifier] == keyboard.is_pressed(modifier))

            					#//*** If any modifier does not match, then move to next element
            					if hotkey['keystroke'][modifier] != keyboard.is_pressed(modifier):
            						execute_hotkey = False
            						break

            				if not execute_hotkey:
            					print("Invalid modifier, test next macro")
            					continue

            			if not execute_hotkey:
            				print("Skipping Macro")
            			else:
            				print("Let's Do a Macro")

            				if keyboard.is_pressed(keystroke):
            					#//*** Block Key
            					pass
            				else:
            					#keyboard.block_key(keystroke)
            					determine_hotkey_action(hotkey,app)
            					#keyboard.release(keystroke)

            	else:
            		print("Not in Dalet")

            if keyboard.is_pressed(keystroke):
            	if keystroke == "up":
            		spy_window()
            	elif keystroke == "down":
            		spy_window()
            	elif keystroke == "left":
            		spy_window()
            	elif keystroke == "right":
            		spy_window()


def spy_window():
	
	return

	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())

	if "Dalet Galaxy" in active_window_text:

		if connected:
			dlg = app[active_window_text]
			wrapper = dlg.wrapper_object()

			for dalet_object in wrapper.children():
				#dalet_object.draw_outline()
				if dalet_object.has_keyboard_focus():

					rundown = dalet_object
					if len(rundown.children()) > 0:
						elem = rundown.children()[-1]
					else:
						elem = rundown

					#print(elem)
					#print(elem.get_properties())
					#print(elem.style(),elem.class_name(),elem.user_data(),elem.texts()[0])
					print(keyboard.is_pressed("ctrl"),keyboard.is_pressed("shift"),keyboard.is_pressed("win"),keyboard.is_pressed("alt"))
					#print(str(len(pyperclip.paste())),pyperclip.paste())
						
#  1426102724 - Nonedit
#  1426100676 - Edit


keeb = threading.Thread(target = capture_keystroke_threaded)
keeb.daemon = True
keeb.start()

base_hotkey = {
	"keystroke" : {
		"ctrl" : False,
		"shift" : False,
		"alt" : False,
		"win" : False,
		"key" : None
	},
	"label" : None,
	"codes" : []
}
base_code = {
	"use_tran" : False,
	"mos" : None
}

sotvo_hotkey = {
	"keystroke" : {
		"ctrl" : True,
		"shift" : False,
		"alt" : False,
		"win" : True,
		"key" : "z"
	},
	"function" : "macro",
	"label" : "SOTVO",
	"codes" : [
	{
		"use_tran" : True,
		"mos" : "<mos><mosID>kgo.pcr2.ovd.mos</mosID><itemID>0</itemID><mosAbstract>v3b SOT - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Disabled</mosAbstract><objSlug>v3b SOT - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Disabled</objSlug><mosPlugInID>Ross.Inception</mosPlugInID><objID>5eef91bc652b2</objID><mosItemEditorProgID>RossClem.RossEditor</mosItemEditorProgID><objDur>1</objDur><objTB>60</objTB><abstract/><itemSlug/><mosExternalMetadata><mosScope>PLAYLIST</mosScope><mosSchema>http:'rossvideo.com/schemas/MOS/external/1.0</mosSchema><mosPayload><shotID>33133</shotID><dbAppVersion><major>20</major><minor>2</minor><revision>10</revision><build>7869</build></dbAppVersion><dbTemplate><templateNumber>1100</templateNumber><shotName>v3b SOT</shotName><imageURL>/icons/KGO/v2 Server/v2 SOT.png</imageURL><transition><id>39</id><name>1_CUT _CLRG1</name></transition><mleList><id>37349</id></mleList><afvLevel>-2</afvLevel><additionalAudioList><additionalAudio><id>25768</id><order>1</order><audio><id>35276</id><name>BRIO STUV##ME##0##BUS##program</name><type>DEVICE</type></audio><customLevel>-1</customLevel><overrideState>OVERRIDE_ON</overrideState></additionalAudio></additionalAudioList><floorDirectorCueNote/><floorDirectorCueNoteEnabled>false</floorDirectorCueNoteEnabled><secondaryEvent>false</secondaryEvent></dbTemplate><icon>/icons/KGO/v2 Server/v2 SOT.png</icon></mosPayload></mosExternalMetadata></mos>"
	},
	{
		"use_tran" : False,
		"mos" : "<mos><mosID>kgo.pcr2.ovd.mos</mosID><itemID>0</itemID><mosAbstract>v3c Anchors On - Ross Video - Audio AFV: Video Only</mosAbstract><objSlug>v3c Anchors On - Ross Video - Audio AFV: Video Only</objSlug><mosPlugInID>Ross.Inception</mosPlugInID><objID>5eef919ad7863</objID><mosItemEditorProgID>RossClem.RossEditor</mosItemEditorProgID><objDur>1</objDur><objTB>60</objTB><abstract/><itemSlug/><mosExternalMetadata><mosScope>PLAYLIST</mosScope><mosSchema>http:'rossvideo.com/schemas/MOS/external/1.0</mosSchema><mosPayload><shotID>33627</shotID><dbAppVersion><major>20</major><minor>2</minor><revision>10</revision><build>7869</build></dbAppVersion><dbTemplate><templateNumber>9997</templateNumber><shotName>v3c Anchors On</shotName><imageURL>/icons/KGO/v2 Audio Studio/v2 Anchors On.png</imageURL><transition><id>55</id><name>Audio Only</name></transition><afvLevel>-3</afvLevel><additionalAudioList><additionalAudio><id>-1</id><order>1</order><audio><id>1</id><name>ANCH</name><type>CHANNEL</type></audio><customLevel>-1</customLevel><overrideState>OVERRIDE_ON</overrideState></additionalAudio><additionalAudio><id>-1</id><order>2</order><audio><id>2</id><name>COAN</name><type>CHANNEL</type></audio><customLevel>-1</customLevel><overrideState>OVERRIDE_ON</overrideState></additionalAudio></additionalAudioList><floorDirectorCueNote/><floorDirectorCueNoteEnabled>false</floorDirectorCueNoteEnabled><secondaryEvent>false</secondaryEvent></dbTemplate><icon>/icons/KGO/v2 Audio Studio/v2 Anchors On.png</icon></mosPayload></mosExternalMetadata></mos>"
	}


	]
}

enter_exit_script_hotkey = {
	"keystroke" : {
		"ctrl" : True,
		"shift" : False,
		"alt" : False,
		"win" : True,
		"key" : "enter"
	},
	"function" : "enter_exit_script",
	"label" : "enter_exit_script",
	"key" : "f7",
	"codes" : []

}

#hk = build_hotkeys()

#hk.add_hotkey(sotvo_hotkey)
#hk.add_hotkey(enter_exit_script_hotkey)
#print(hk)

hk = []
hk.append(sotvo_hotkey)
hk.append(enter_exit_script_hotkey)


key_director = {}

for hotkey in hk:

	if hotkey['keystroke']['key'] not in key_director.keys():
		key_director[hotkey['keystroke']['key']] = [hotkey]
	else:
		key_director[hotkey['keystroke']['key']].append(hotkey)

#hk.register_hotkeys()



while True:
	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
	if "Dalet Galaxy" in active_window_text:
		#print(active_window_text)
		#print(win32gui.GetForegroundWindow())
		if not connected:
			app.connect(handle=win32gui.GetForegroundWindow())
			connected = True
			dlg = app[active_window_text]
			#print(dir(dlg))
			print("connected to Dalet")
	time.sleep(.1)
	pass