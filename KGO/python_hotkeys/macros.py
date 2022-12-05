import win32gui, os, sys
import time, threading, pyperclip, keyboard, re

from pywinauto import application
import pywinauto 
import pyautogui

connected = False
app = application.Application()

class build_hotkeys():

	def __init__(self): 
		#//*** Initialize list of Hotkeys
		self.hotkeys = []
		self.input_delay = .5

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
			keyboard.add_hotkey(key_str, self.do_hotkey_macros, 
				args =(
					hotkey['keystroke']['ctrl'],
					hotkey['keystroke']['shift'],
					hotkey['keystroke']['win'],
					hotkey['keystroke']['alt'],
					[codes]
				),suppress=True,trigger_on_release=True)

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

	def do_hotkey_macros(self, ctrl, shift, win, alt, codes):
		print("Firing Hotkey")

		active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
		if "Dalet Galaxy" in active_window_text:
			dlg = app[active_window_text]

			wrapper = dlg.wrapper_object()

			#keyboard.send("left")

			for dalet_object in wrapper.children():
				
				if dalet_object.has_keyboard_focus():
				#	dalet_object.draw_outline()
					
					
					if len(dalet_object.children()) > 0:

						elem = dalet_object.children()[-1]
						print(elem)	
						print(elem.texts())
					else:
						print("=====")
						if dalet_object.class_name() == "RICHEDIT50W":
							print("in_editor")
							print(f"Starting Length: {len(dalet_object.texts()[0])}")

							text_length = len(dalet_object.texts()[0])

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
								keyboard.press_and_release('ctrl + v')

								print(f"1 waiting: {text_length} == {len(dalet_object.texts()[0])}")
								#self.wait_for_text_update(text_length,dalet_object)
								#//*** Wait for Input to be accepted.
								while text_length == len(dalet_object.texts()[0]):
									time.sleep(.1)
									print(f"2 waiting: {text_length} == {len(dalet_object.texts()[0])}")

								keyboard.press_and_release('\n')
								print(f"3 waiting: {text_length} == {len(dalet_object.texts()[0])}")
								
								#pywinauto.keyboard.send_keys('{ENTER}')
								print(f"Done waiting: {text_length} == {len(dalet_object.texts()[0])}")

						#self.press_modifier_keys(ctrl, shift, win, alt)
		else:
			print("Not in Dalet ... Skipping")
							#//** Add Test to see if Editor is active



		#self.press_modifier_keys(ctrl, shift, win, alt)

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

hk = build_hotkeys()

hk.add_hotkey(sotvo_hotkey)
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