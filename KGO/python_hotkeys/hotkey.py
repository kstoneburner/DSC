#import keyboard #pip install keyboard
import win32gui, os, sys
import time, threading, pyperclip

from pywinauto import application
import pywinauto 
import pyautogui

#//*** Pyperclip documentation
#https://medium.com/analytics-vidhya/clipboard-operations-in-python-3cf2b3bd998c
#https://github.com/boppreh/keyboard


app = application.Application()
print(win32gui.FindWindow(None, "Dalet Galaxy"))

all_cols = ['icon','float','lock','page','slug','segment','brio5','brio6','brio7','brio8','anchor','cam','dur','stage','gfx','changes']
cols = ['page','slug','segment','anchor','cam','stage','gfx','changes']
base_vo = "<mos><mosID>kgo.pcr2.ovd.mos</mosID><itemID>0</itemID><mosAbstract>v3 VO - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Video Only</mosAbstract><objSlug>v3 VO - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Video Only</objSlug><mosPlugInID>Ross.Inception</mosPlugInID><objID>5bc956d2910de</objID><mosItemEditorProgID>RossClem.RossEditor</mosItemEditorProgID><objDur>1</objDur><objTB>60</objTB><abstract/><itemSlug/><mosExternalMetadata><mosScope>PLAYLIST</mosScope><mosSchema>http:'rossvideo.com/schemas/MOS/external/1.0</mosSchema><mosPayload><shotID>33135</shotID><dbAppVersion><major>18</major><minor>4</minor><revision>11</revision><build>6170</build></dbAppVersion><dbTemplate><templateNumber>1101</templateNumber><shotName>v3 VO</shotName><imageURL>/icons/KGO/v2 Server/v2 VO.png</imageURL><transition><id>39</id><name>1_CUT _CLRG1</name></transition><mleList><id>37741</id></mleList><afvLevel>-3</afvLevel><additionalAudioList><additionalAudio><id>-1</id><order>1</order><audio><id>35975</id><name>BRIO STUV##ME##0##BUS##program</name><type>DEVICE</type></audio><customLevel>50</customLevel><overrideState>OVERRIDE_ON</overrideState></additionalAudio></additionalAudioList><floorDirectorCueNote/><floorDirectorCueNoteEnabled>false</floorDirectorCueNoteEnabled></dbTemplate><icon>/icons/KGO/v2 Server/v2 VO.png</icon></mosPayload></mosExternalMetadata></mos>"
connected = False
quit=False
#print("!")
#r = os.popen('tasklist /v').read().strip().split('\n')

#cmd = 'tasklist /FI "imagename eq DaletGalaxy.exe" /v'
#print(os.popen(cmd).read())

"""
def capture_keystroke_threaded():
    global keystroke
    lock = threading.Lock()
    loop = True
    while not quit:
        with lock:
            
            keystroke = keyboard.on_press()
            #keystroke = keyboard.read_key()
            #keyboard.block_key(keystroke)
            print(keystroke)
            if keyboard.is_pressed(keystroke):

            	#active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
            	#if "Dalet Galaxy" in active_window_text:
                #print(keystroke)
                has_ctrl = keyboard.is_pressed('ctrl')
                has_shift = keyboard.is_pressed('shift')
                has_win = keyboard.is_pressed('win')
                
                #print(has_ctrl,has_shift,has_win)

                if has_ctrl and has_win:

                	
                	if keystroke == "\\":
                		readRundownLine()
                	if keystroke == "w":
                		keyboard.block_key("w")
                		send_vo()
                	#keyboard.unblock_key(keystroke)
"""
#keeb = threading.Thread(target = capture_keystroke_threaded)
#keeb.daemon = True
#keeb.start()                    


def status_rundown():
	global status
	win32gui.GetCursorInfo()

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

#print(dir(keyboard))

def send_vo():
	print("DING!")
	
	keyboard.release("ctrl")
	keyboard.release('windows')
	pyperclip.copy(base_vo)
	time.sleep(.5)
	
	pywinauto.keyboard.send_keys('+{INS}')
	
	return
	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
	if "Dalet Galaxy" in active_window_text:
		dlg = app[active_window_text]

		wrapper = dlg.wrapper_object()

		#keyboard.send("left")

		for dalet_object in wrapper.children():
			
			if dalet_object.has_keyboard_focus():
				dalet_object.draw_outline()
				
				
				if len(dalet_object.children()) > 0:

					elem = dalet_object.children()[-1]
					print(elem)	
					print(elem.texts())
				else:
					print("=====")
					if dalet_object.class_name() == "RICHEDIT50W":
						print("in_editor")
						print(len(dalet_object.texts()[0]))


						#//** Add Test to see if Editor is active

						pyperclip.copy(base_vo)
						time.sleep(1)
						pc.paste()

#keyboard.add_hotkey('ctrl + windows + q', send_vo, args =(),suppress=True,trigger_on_release=True)

while True:
	
	
	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
	if "Dalet Galaxy" in active_window_text:
		#print(active_window_text)
		#print(win32gui.GetForegroundWindow())
		if not connected:
			app.connect(handle=win32gui.GetForegroundWindow())
			connected = True
			dlg = app[active_window_text]
			print(dir(dlg))




		"""
		dlg = app[active_window_text]

		wrapper = dlg.wrapper_object()

		#keyboard.send("left")
		try:
			for dalet_object in wrapper.children():
				
				if dalet_object.has_keyboard_focus():
					dalet_object.draw_outline()
					
					
					if len(dalet_object.children()) > 0:

						elem = dalet_object.children()[-1]
						print(elem)	
						print(elem.texts())
					else:
						print("=====")
						if dalet_object.class_name() == "RICHEDIT50W":
							print("in_editor")
							print(len(dalet_object.texts()[0]))
						for key,value in dalet_object.get_properties().items():
							print( key,":",value)
		except:
			pass
		"""
	try:
		print(win32gui.GetCursorInfo())
	except: 
		pass
	time.sleep(.1)

