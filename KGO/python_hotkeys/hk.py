class build_hotkeys():

	def __init__(self): 
		#//*** Initialize list of Hotkeys
		self.hotkeys = []
		self.input_delay = .5
		self.iter_counter = 0

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

	def __iter__(self):
		return(self)

	def __next__(self):
		if self.iter_counter < len(self.hotkeys):

			out = self.hotkeys[self.iter_counter]
			self.iter_counter = self.iter_counter +1
			return out

		raise StopIteration
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
					),suppress=True,trigger_on_release=True)

			elif hotkey['function'] == 'enter_exit_script':
					print(key_str)
					keyboard.add_hotkey(key_str, self.do_enter_exit_script, 
					args =(
						hotkey['keystroke']['ctrl'],
						hotkey['keystroke']['shift'],
						hotkey['keystroke']['win'],
						hotkey['keystroke']['alt'],
						hotkey['key']
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
		"""
		if elem.style() in self.style.keys():
			return self.style[elem.style()]
		
		print("Unknown Element Style: ",str(elem.style()))
		return None
		"""
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
				out = "editor"

			elem = elem

		print(elem)
		print(elem.get_properties())

		return out


	def do_enter_exit_script(self, ctrl, shift, win, alt, key):
		print("Enter Exit Script")


		elem = self.get_focused_object()

		if elem == None:
			return

		elem_type = self.get_element_type(elem)

		print(elem_type)

		if elem_type == "rundown":

			self.enter_script(key)			

		if elem_type == "editor":

			self.exit_script(key)			
		
			print("Releasing Keys")
			self.release_modifier_keys( ctrl, shift, win, alt)

	def enter_script(self,key):
		keyboard.press_and_release(key)
		time.sleep(.1)
		elem = self.get_focused_object()
		time.sleep(.1)
		
		timeout = 50
		loop_counter = 0
		while elem.class_name() != "RICHEDIT50W":
			elem = self.get_focused_object()
			time.sleep(.1)

			loop_counter = loop_counter + 1

			if loop_counter >= timeout:
				print("Timeout on Entering Script")
				return

		print(f"In Editor")




		#print(self.get_element_type(elem))

		return
		#//*** Wait for Edit window
		while self.get_element_type(elem) != "edit_window":

			print("Waiting for edit window",self.get_element_type(self.get_element_type(elem)))

	def exit_script(self,key):
		keyboard.press_and_release("ctrl+s")
		time.sleep(.1)
		keyboard.press_and_release(key)
		time.sleep(.1)
		elem = self.get_focused_object()
		time.sleep(.1)

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
