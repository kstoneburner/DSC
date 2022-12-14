import win32gui
from pywinauto import application

def determine_hotkey_action(hotkey,input_app):
	global app 
	app = input_app
	print(app)
	print("Determine Hotkey Action")
	print(hotkey['function'])
	print(app)
	if hotkey['function'] == 'enter_exit_script':
		do_enter_exit_script(hotkey)


def get_focused_object():
	print(app)
	active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
	if "Dalet Galaxy" in active_window_text:
		dlg = app[active_window_text]

		wrapper = dlg.wrapper_object()

		#keyboard.send("left")

		for dalet_object in wrapper.children():
			
			if dalet_object.has_keyboard_focus():
				return dalet_object

	return None

def get_element_type(elem):
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



def do_enter_exit_script(hotkey):
	print("Enter Exit Script")

	elem = get_focused_object()
	print("Focused Object")
	print(elem)
	return

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

def __init__():
	print("DING")