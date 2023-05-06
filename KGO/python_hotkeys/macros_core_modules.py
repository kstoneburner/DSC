import win32gui,keyboard,time,requests,pywinauto
#from pywinauto import application

import socket,threading,sys
from http.server import HTTPServer, BaseHTTPRequestHandler

	

def capture_keystroke_threaded():
    global keystroke
    lock = threading.Lock()
    while True:
        with lock:
            time.sleep(.1)
            keystroke = keyboard.read_key()
            #print("Keystroke:",keystroke)
            if keyboard.is_pressed(keystroke):

                if keystroke == "esc":
                    #keep_going = False
                    print("Quitting")
                    sys.exit()
    



def determine_hotkey_action(hotkey,input_app):
	global app 
	app = input_app
	print("Determine Hotkey Action")
	print(hotkey['function'])
	
	if hotkey['function'] == 'enter_exit_script':
		do_enter_exit_script(hotkey)

	if hotkey['function'] == 'macro':
		print("Execute Macros")
		do_hotkey_macro(hotkey)


def get_focused_object():
    
    active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
    if "Dalet Galaxy" in active_window_text:
        
        #//*** In Dalet, get an HWNDwrapper of the active window, Return the control with active focus
        
        return pywinauto.controls.hwndwrapper.HwndWrapper(win32gui.GetForegroundWindow()).get_focus()
        #print(dir(elem))
        #print(len(elem.children()),elem,elem.has_keyboard_focus())
        #print(elem.class_name(),elem.texts())
        #print(elem.element_info)
        #elem.draw_outline()

        if len(elem.children()) > 0:
            elem = elem.children()[-1]

        #print("-->",elem)
        #print("-->",elem.texts())
        #print("-->",elem.element_info)
                                                                                                                                                                         

    return None

def get_element_type(elem):

    out = None

    if len(elem.children()) > 0:
        #//*** If focused Object has children, the last one is the keyboard control
        elem = elem.children()[-1]
        #print("has children")
        #print(elem)
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

        #elem = elem

    #print(elem)
    #print(elem.get_properties())

    return out

def do_enter_exit_script(hotkey):
    print("Enter Exit Script")

    elem = get_focused_object()
    print("Focused Object")
    print(elem)
    
    
    if elem == None:
        return

    elem_type = get_element_type(elem)

    print(elem_type)

    if elem_type == "rundown" or elem_type == "rundown_field":

        enter_script(hotkey)         

    if elem_type == "editor":

        exit_script(hotkey)          
    
        #print("Releasing Keys")
        #self.release_modifier_keys( ctrl, shift, win, alt)

def enter_script(input_key):
    print("ENTER SCRIPT",input_key)


    keyboard.press_and_release(input_key)

    time.sleep(.1)
    elem = get_focused_object()
    time.sleep(.1)
    
    timeout = 50
    loop_counter = 0

    while elem.class_name() != "RICHEDIT50W":
        print("Waiting to Enter Script")
        print(get_focused_object())
        elem = get_focused_object()

        #//*** Check if Story locked. Modal Dialog with a Focused button will appear.
        if elem.class_name() == "Button":
            print("Modal Window Found, Story Locked, Quit")
            time.sleep(1)
            elem = get_focused_object()
            #//*** Send Enter, if the object is still focused
            if elem.class_name() == "Button":
                keyboard.press_and_release("enter")
            return True
        time.sleep(.1)

        loop_counter = loop_counter + 1

        if loop_counter >= timeout:
            print("Timeout on Entering Script")
            return False

    print(f"In Editor")




    #print(self.get_element_type(elem))

    return
    #//*** Wait for Edit window
    while get_element_type(elem) != "edit_window":

        print("Waiting for edit window", get_element_type(get_element_type(elem)))

def exit_script(key):
    keyboard.press_and_release("ctrl+s")
    time.sleep(.1)
    keyboard.press_and_release(key)
    time.sleep(.1)
    elem = get_focused_object()
    
    timeout = 50
    loop_counter = 0

    while get_element_type(get_focused_object()) == "editor":
        
        print("waiting:", get_element_type(get_focused_object()))
        time.sleep(.1)

        loop_counter = loop_counter + 1

        if loop_counter >= timeout:
            print("Timeout on Entering Script")
            return

def add_transition(mos):
	out = mos
	return out

def block_modifier_keys(hotkey):

	for key in hotkey['keystroke'].keys():
		if key == "key":
			continue

		if hotkey['keystroke'][key]:
			keyboard.block_key(key)
	
def release_modifier_keys(hotkey):

	for key in hotkey['keystroke'].keys():
		if key == "key":
			continue

		if hotkey['keystroke'][key]:
			keyboard.unblock_key(key)
	#keyboard.release("alt")

def send_code(code):

	#//*** Default to not using Tran
	use_tran = False

	if 'use_tran' in code.keys():
		print("Tans FFou")

def do_hotkey_macro(hotkey):


	print("String Hotkey Macro")
	
	#//*** Check for Rundown
	elem = get_focused_object()

	print( "Type:", get_element_type(elem) )
	
	elem_type = get_element_type(elem)
	
	if elem_type == "rundown" or elem_type == "rundown_field":
		enter_script('f7')

		#//*** Get the Element again to Verify is Script
		elem = get_focused_object()
		elem_type = get_element_type(elem)

	if elem_type == "editor":

		block_modifier_keys(hotkey)

		#//*** Send Codes
		for code in hotkey['codes']:
			send_code(code)


	

def __init__():
	print("DING")