import win32gui, os, sys
import time, threading, pyperclip, keyboard, re

from pywinauto import application
import pywinauto 
import pyautogui


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
    lock = threading.Lock()
    loop = True
    while loop:
        with lock:
            time.sleep(.1)
            keystroke = keyboard.read_key()
            print(keystroke, keyboard.is_pressed("ctrl"),keyboard.is_pressed("shift"),keyboard.is_pressed("win"),keyboard.is_pressed("alt"))
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
					print(elem.style(),elem.class_name(),elem.user_data(),elem.texts()[0])
					print(keyboard.is_pressed("ctrl"),keyboard.is_pressed("shift"),keyboard.is_pressed("win"),keyboard.is_pressed("alt"))
					#print(str(len(pyperclip.paste())),pyperclip.paste())
						
#  1426102724 - Nonedit
#  1426100676 - Edit

class build_hotkeys():

	def __init__(self): 
		#//*** Initialize list of Hotkeys
		self.hotkeys = []
		self.input_delay = .5
		self.style = {
			1427151300 : "non_editor_window",
			1427149252 : "edit_window",
			1073807812 : "rundown",
			1342243268 : "rundown_field",
			1426100676 : "edit_window",
			1426102724 : "non_editor_window"

		}

	def __str__(self):
		out = ""
		for hotkey in self.hotkeys:

			out+= f"{hotkey['label']} - {self.get_keystroke_string(hotkey)}:\n"
			
			for code in hotkey['codes']:

				xml_pattern = "(?:<mosAbstract>)(.*?)(?:<\\/mosAbstract>)"
				results = re.findall(xml_pattern,code['mos'])
				out += "\t"
				out += results[0]
				out += "\n"
				

			if len(out) > 0:
				out = out[:-3]

		return out
	def get_keystroke_string(self,hotkey):
		key_str = ""

		if hotkey['keystroke']['ctrl']:
			key_str += "ctrl+"
		if hotkey['keystroke']['shift']:
			key_str += "shift+"
		if hotkey['keystroke']['win']:
			key_str += "windows+"
		if hotkey['keystroke']['alt']:
			key_str += "alt+"

		if len(key_str) > 0:
			#//*** Trim Last character
			key_str = key_str[:-1]

		key_str += f"+{hotkey['keystroke']['key']}"

		return(key_str)


	def add_hotkey(self, input_obj):
		self.hotkeys.append(input_obj)

	#//*** Registers each Hotkey with the Keyboard module
	def register_hotkeys(self):
		for hotkey in self.hotkeys:
			key_str = self.get_keystroke_string(hotkey)
			codes = hotkey['codes']
			if 'function' not in hotkey.keys():
				print(f"{hotkey['label']}:Hotkey needs a Function Value")
				return
			print(hotkey['function'])
			if hotkey['function'] == "macro":
				keyboard.add_hotkey(key_str, self.do_hotkey_macros, 
					args =(
						hotkey['keystroke']['ctrl'],
						hotkey['keystroke']['shift'],
						hotkey['keystroke']['win'],
						hotkey['keystroke']['alt'],
						[codes]
					),suppress=True,trigger_on_release=False)

			elif hotkey['function'] == 'enter_exit_script':
					print(key_str)
					keyboard.add_hotkey(key_str, self.do_enter_exit_script, 
					args =(
						hotkey['keystroke']['ctrl'],
						hotkey['keystroke']['shift'],
						hotkey['keystroke']['win'],
						hotkey['keystroke']['alt'],
						hotkey['key']
					),suppress=True,trigger_on_release=False)


	def block_all_modifiers(self):
		keyboard.release("ctrl")
		keyboard.release("shift")
		keyboard.release("windows")
		keyboard.release("alt")

		time.sleep((self.input_delay))	

		#keyboard.block_key("ctrl")
		#keyboard.block_key("shift")
		#keyboard.block_key("windows")
		#keyboard.block_key("alt")

		time.sleep((self.input_delay))	


	def release_modifier_keys(self, ctrl, shift, win, alt):
		if ctrl:
			keyboard.release("ctrl")

		if shift:
			keyboard.release("shift")

		if win:
			keyboard.release("windows")

		if alt:
			keyboard.release("alt")

	def press_modifier_keys(self, ctrl, shift, win, alt):
		try:
			keyboard.unblock_key("ctrl")
		except:
			pass
		try:
			keyboard.unblock_key("shift")
		except:
			pass

		try: 
			keyboard.unblock_key("windows")
		except:
			pass
		
		try:
			keyboard.unblock_key("alt")
		except:
			pass

		if ctrl:
			keyboard.press("ctrl")

		if shift:
			keyboard.press("shift")

		if win:
			keyboard.press("windows")

		if alt:
			keyboard.press("alt")

	def get_focused_object(self):
		active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
		if "Dalet Galaxy" in active_window_text:
			dlg = app[active_window_text]

			wrapper = dlg.wrapper_object()

			#keyboard.send("left")

			for dalet_object in wrapper.children():
				
				if dalet_object.has_keyboard_focus():
					return dalet_object

		return None

	def get_element_type(self,elem):
		if elem.style() in self.style.keys():
			return self.style[elem.style()]
		
		print("Unknown Element Style: ",str(elem.style()))
		return None

		out = None

		if len(elem.children()) > 0:
			#//*** If focused Object has children, the last one is the keyboard control
			elem = elem.children()[-1]
			print("has children")
			print(elem)
			if elem.class_name() == "GXEDIT":
				out = "rundown"
		else:
			#//*** If no children, then keep the object
			print("no children")
			if elem.class_name() == "GXEDIT":
				out = "rundown_field"
			if elem.class_name() == "RICHEDIT50W":
				#//*** The editor is Selected, determine if editor is in edit mode
				out = "Non_Specific_Editor"

			elem = elem

		print(elem)
		print(elem.get_properties())

		return out


	def do_enter_exit_script(self, ctrl, shift, win, alt, key):
		print("Enter Exit Script")
		elem = self.get_focused_object()

		if elem == None:
			return

		print(self.get_element_type(elem))

	def enter_script(self,elem):
		keyboard.press_and_release('f7')
		time.sleep(.1)

		#//*** Wait for Edit window
		while self.get_element_type(elem) != "edit_window":

			print("Waiting for edit window",self.get_element_type(self.get_element_type(elem)))




	def do_hotkey_macros(self, ctrl, shift, win, alt, codes):
		print("Firing Hotkey")

		dalet_object = self.get_focused_object()

		if dalet_object == None:
			print("Not in Dalet")
			return

					
							
		if len(dalet_object.children()) > 0:
			#//*** If focused Object has children, the last one is the keyboard control
			elem = dalet_object.children()[-1]
		else:
			#//*** If no children, then keep the object
			elem = dalet_object

		
		#//*** Return a known element type
		elem_type = self.get_element_type(elem)

		print("elem_type:", elem_type)

		if elem_type == "rundown" or elem_type == "rundown_field":
			self.enter_script(elem)
		return

		#self.block_all_modifiers()

		#//*** Codes is a list within a llist, bc that's how keyboard needs it.
		codes = codes[0]
		for code in codes:
			#print(type(code))
			#print(code)
			#print("=====")
			pyperclip.copy(code['mos'])
			
			while pyperclip.paste() != code['mos']:
				pyperclip.copy(code['mos'])
				time.sleep(.05) 
				print("Waiting for clipboard")

			#pywinauto.keyboard.send_keys('^v')
			#self.block_all_modifiers()
			text_length = len(dalet_object.texts()[0])

			keyboard.press_and_release('ctrl + v')

			self.wait_for_update(text_length,dalet_object)

			text_length = len(dalet_object.texts()[0])
			keyboard.press_and_release('\n')

								

	def wait_for_update(self,text_length,dalet_object, initial_delay=.1):
		time.sleep(initial_delay)
		print(f"1 waiting: {text_length} == {len(dalet_object.texts()[0])}")
		#//*** Wait for Input to be accepted.
		while text_length == len(dalet_object.texts()[0]):
			time.sleep(.1)
			print(f"2 waiting: {text_length} == {len(dalet_object.texts()[0])}")


		#self.press_modifier_keys(ctrl, shift, win, alt)

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

hk = build_hotkeys()

hk.add_hotkey(sotvo_hotkey)
hk.add_hotkey(enter_exit_script_hotkey)
print(hk)
hk.register_hotkeys()



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
	time.sleep(.1)
	pass