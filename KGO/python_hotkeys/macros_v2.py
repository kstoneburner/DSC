import sys,re,multiprocessing
import socket,threading,keyboard,time,subprocess,winreg
from http.server import HTTPServer, BaseHTTPRequestHandler


from hotkey_core_modules import *
from macros_core_modules import *


from tkinter import *
from tkinter import ttk, filedialog
from tkinter.filedialog import askopenfile


#from PIL import Image,ImageTk

import pywinauto, pyautogui
from pywinauto import application
#pywinauto.multi_threading_mode = True

import win32gui
from pywinauto.controls.uiawrapper import UIAWrapper


win = Tk()
win.title("Dalet Hotkeys")
win.resizable(1,1)

#//*** Always on top
win.attributes('-topmost',True)

#//*** Borderless
win.overrideredirect(True)





#app = application.Application(backend="uia")


master_hotkey_filename = "master_hotkeys.json"
master_rules = load_master_rules(master_hotkey_filename)
master_ahk_triggers_filename = "triggers.ahk"

transitions,transition_actions = load_transitions()

alt_modes = load_alt_modes()
show_modes = load_show_modes()

enter_exit_script_key = 'f7'
connected = False


sys.coinit_flags = 0


global quit


quit = False



default = {
    
    "transition" : '1_CUT _CLRG1'    

}
selected = {

    "studio_mode" : "desk_studio",
    "alt_mode" : 'base',
    "transition" : default['transition'],
    "anc1" : "ANC1",
    "anc2" : "ANC2",
    "initials" : "",
    "active" : False,
    "elem" : None
}



widgets = {}

srv = None



def on_focus_out(event):
    updateSelectedValues()

def updateSelectedValues(event=None):
    for key in ['alt_modes', 'transition', 'studio_modes','anc1','anc2','initials']:
        selected[key] = widgets[key].get()

    print("updateSelectedValues: ",selected)


def listen_for_ahk(input_port):   
    print("Xx")
    soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    h_name = socket.gethostname()
    HOST = socket.gethostbyname(h_name)
    HOST = "127.0.0.1"

    PORT = input_port

    #//**** Custom Reponse Class
    #//**** Assumes a single variable and value is sent
    class CustomHandler(BaseHTTPRequestHandler):
        def do_GET(self):
            #print(dir(self))
            


            #//*** Send a Basic Response to keep the hotkey COM server object happy.            
            self.send_response(200)
            self.send_header('content-type','text/html')
            self.end_headers()
            self.wfile.write('Python HTTP Webserver Tutorial'.encode())

            for x in self.requestline.split(" "):
                if "?" in x:
                    response = x.replace("/?","")

                    if "action=quit" not in response:

                            handleAHK_inputs(response)

            if "action=quit" in self.requestline:
                
                print("Quitting LIstener")

                return
    
    #//*** Spin up HTTP Server
    srv = HTTPServer(('',PORT), CustomHandler)
    print('Server started on port %s' %PORT)
    srv.serve_forever()


def capture_keystroke_threaded():
    global keystroke
    lock = threading.Lock()
    keep_going = True
    while keep_going:
        time.sleep(.1)
        keystroke = keyboard.read_key()
        #print("Keystroke:",keystroke)
        if keyboard.is_pressed(keystroke):

            if keystroke == "esc":
                #keep_going = False
                print("Quitting")
                keep_going = False
                doQuit()
                    
def doQuit():

    #//*** Kill Autohotkey
    tasks = subprocess.getoutput('tasklist /FI "IMAGENAME eq Autohotkey.exe" /v /nh').split('\n')

    for task in tasks:
        if "OleMainThreadWndName" in task or "triggers.ahk" in task:
            
            for val in task.split(" "):
                if len(val) == 0:
                    continue

                try:
                    pid = int(val)
                except:
                    continue

                #//*** Kill the AHK Process 
                subprocess.call(f"taskkill /pid {pid}")
                break

    win.destroy()

    requests.get("http://127.0.0.1:9999?action=quit")

    sys.exit()


def launchAHKScript(ahk_path):
    subprocess.run([ahk_path,master_ahk_triggers_filename])


#//**** Build AHK file from Master Rules
def buildAHKFile(master_rules):

    def build_AHK_trigger(selected_key,keystroke):

        out = ""

        for key,value in keystroke.items():
            if key == 'ctrl' and value:
                out += "^"
            if key == 'win' and value:
                out += "#"
            if key == 'shift' and value:
                out += "+"
            if key == 'alt' and value:
                out += "!"
        out +=f"{selected_key}"

        return out

    def build_AHK_text(trigger,selected_key,keystroke):
        out=""

        out+=f"{trigger}::\n"

        key_text = ""
        key_text += f"keyaction={selected_key}"

        key_text += "&ctrl="
        if keystroke['ctrl']:
            key_text += "1"
        else:
            key_text += "0"

        key_text += "&win="
        if keystroke['win']:
            key_text += "1"
        else:
            key_text += "0"

        key_text += "&shift="
        if keystroke['shift']:
            key_text += "1"
        else:
            key_text += "0"

        key_text += "&alt="
        if keystroke['alt']:
            key_text += "1"
        else:
            key_text += "0"

        out += '\toWhr := ComObjCreate("WinHttp.WinHttpRequest.5.1")\n'
        out += f'\toWhr.Open("GET", "http://127.0.0.1:9999?{key_text}", false)\n'
        out += '\toWhr.Send()\n'
        out += '\toWhr.Abort()\n'
        out += "RETURN\n\n"
    

        return out

    print("BUILD AHK")
    


    trigger_list = []

    ahk_trigger_text = "#SingleInstance Force\n\n"
    for key,top_level_rule in master_rules.items():

        
        for rule_key,rule_studio_mode in top_level_rule.items():
            
            
            for rule_alt_mode_key, rule_value in rule_studio_mode.items():
                print(key, rule_key,rule_alt_mode_key,rule_value['keystroke'])
                ahk_trigger = build_AHK_trigger(key, rule_value['keystroke'])
                if ahk_trigger not in trigger_list:
                    trigger_list.append(ahk_trigger)

                    ahk_trigger_text += build_AHK_text(ahk_trigger,key,rule_value['keystroke'])
                    

    ahk_trigger_text += "^#!r::\n\tmsgbox reloading\n\treload\nRETURN\n"
    #print(ahk_trigger_text)

    #//*** Write AHK file Text to File
    with open(master_ahk_triggers_filename, "w") as outfile:
        outfile.write(ahk_trigger_text)

                    
    #//*** Get Path to Autohotkey Executable from Regsitry
    access_registry = winreg.ConnectRegistry(None,winreg.HKEY_CLASSES_ROOT)
    access_key = winreg.OpenKey(access_registry,r"AutoHotkeyScript\\Shell\\Open\\Command")
    reg_value = winreg.EnumValue(access_key,0)[1]
    ahk_path = None

    if ".exe" in reg_value:

        results = re.findall('\\".+?\\"',reg_value)
        for result in results:
            if ".exe" in result:

                #//*** Launch Autohotkey script 
                ahk_path = result.replace('"','')
                ahk_process = threading.Thread(target = launchAHKScript, args=[ahk_path])
                ahk_process.daemon = True
                ahk_process.start() 
                print(dir(ahk_process))
                print("===")
                print(ahk_process._native_id)

def handleAHK_inputs(response):

    current_input = {} 

    #//*** Validate inputs
    for x in ["keyaction=","ctrl=","win=","shift=","alt="]:
        if x not in response:
            print("AHK response missing ",x)
            return
    
    #//*** Split Response
    
    for response_value in response.split("&"):

        key,value = response_value.split("=")
        #print(key,value)

        if key == "keyaction":
            current_input["key"] = value
            continue

        if key == "ctrl":
            if value == "1":
                current_input['ctrl'] = True
            else:
                current_input['ctrl'] = False
            continue

        if key == "win":
            if value == "1":
                current_input['win'] = True
            else:
                current_input['win'] = False
            continue

        if key == "shift":
            if value == "1":
                current_input['shift'] = True
            else:
                current_input['shift'] = False
            continue

        if key == "alt":
            if value == "1":
                current_input['alt'] = True
            else:
                current_input['alt'] = False
            continue
      
    #//*** Hard Verify all necessary keys are in current Input
    for x in ['key','ctrl','win','shift','alt']:
         if x not in current_input.keys():
            print(f"Invalid AHK Command Missing {x} key")
            return
    rule = getRule_based_on_inputs(current_input)

    #//*** Have Valid Rule
    if rule != None:
        
        for code in rule['codes']:
            handleCode(code)

def assignVariable(action,value):
    if action == 'transition':

        #//**************************
        #//*** Update ComboBox
        #//**************************

        #//*** Get Transition index from transitions
        index = list(transitions.keys()).index(value)

        widgets['transition'].current(index)


    updateSelectedValues()

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


def handleCode(code):

    #/*********************************************************************************************************
    #//**** Suppress Pressed Modifier Keys. bc weird Stuff happens if CTRL+WIN+F7 is pressed instead of F7
    #/*********************************************************************************************************
    reset = {
        "ctrl" : False,
        "win" : False,
        "shift" : False,
        "alt" : False
    }

    for mod in ['ctrl','win','shift','alt']:
        reset[mod] = keyboard.is_pressed(mod)

    for key,value in reset.items():
        
        if value:
            keyboard.release(key)

    #//*** Handle codes
    if code['transition'] == "ACTION":
        
        if code['mos_variable'] == 'assign_transition' or code['mos_variable'] == 'assign_default_transition': 

            #//*** Assign Selected Transition
            assignVariable('transition',code['transition_secondary'])

        elif code['mos_variable'] == 'enter_exit_script':
            print("Handle Enter Exit Script")
            print(code)
            do_enter_exit_script(enter_exit_script_key)
        else:
            print("Action")
            print(code)
        pass
    elif code['transition'] == "selected_transition":
        print("PROCESS Selected Transistsion")
    else:
        print("Handle Transition:", code['transition'])
        print(code)
        print(transitions)


    #//*** Restore Modifier Keys
    for key,value in reset.items():
        
        if value:
            keyboard.press(key)

def getRule_based_on_inputs(valid_input):


    #//*** Validate Key. It should all be linked, but paranoia.
    if valid_input['key'] in master_rules.keys():
        
        
        key_level_rule = master_rules[ valid_input['key'] ]
        
        #//*** Check if Studio Mode is associated with the key:
        if selected["studio_mode"] in key_level_rule.keys():
            studio_mode_level_rule = key_level_rule[ selected["studio_mode"] ]

            #//*** Check if Selected Alt Mode is defined in  studio_mode_level_rule keys
            if selected[ "alt_mode" ] in studio_mode_level_rule.keys():
                
                rule = studio_mode_level_rule[ selected[ "alt_mode" ] ]

                #//*** Validate Input Keypress, match rule keypress
                #//*** Should be equal, in version #1. Could change with time.
                for x in ['ctrl','win','shift','alt']:
                    if not valid_input[x] == rule['keystroke'][x]:
                        #//*** Return None if if Input Keystrokes don't match rule Keystrokes.
                        return None

                #//*** Rule is Valid as far as we can tell
                return rule



    return None

def buildGui():
    print(show_modes)
    print(alt_modes)

    #//*** Base Width
    bw = 10
    #print(transitions)

    #//*******************************
    #//*** Build Alt Mode drop-down
    #//*******************************
    #//*******************************
    widgets['alt_modes'] = ttk.Combobox(win,values=alt_modes,width=bw,state='readonly')
    widgets['alt_modes'].current(0)
    widgets['alt_modes'].pack(side=LEFT)
    #//*** Update all Selected Values when Combois selected
    widgets['alt_modes'].bind("<<ComboboxSelected>>", updateSelectedValues)


    #//*******************************
    #//*** Build Transition drop-down
    #//*******************************
    transition_names = list(transitions.keys())

    widgets['transition'] = ttk.Combobox(
        win,
        #state="readonly",
        values = transition_names,
        name="transition",
        width=int(bw*1.5),
        state='readonly'
    )

    #//*** Find Index of Default Transition 
    widgets['transition_default_index'] = transition_names.index(default['transition'])
    
    #//*** Assign as Default Index
    widgets['transition'].current( widgets['transition_default_index'] )
    widgets['transition'].pack(side=LEFT)
    #//*** Update all Selected Values when Combois selected
    widgets['transition'].bind("<<ComboboxSelected>>", updateSelectedValues)

    #//*******************************
    #//*** Build Studio Mode drop-down
    #//*******************************
    widgets['studio_modes'] = ttk.Combobox(win,values=show_modes,width=bw,state='readonly')
    widgets['studio_modes'].current(0)
    widgets['studio_modes'].pack(side=LEFT)
    #//*** Update all Selected Values when Combois selected
    widgets['studio_modes'].bind("<<ComboboxSelected>>", updateSelectedValues)

    #//*******************************
    #//*** Build Anchor Initials Label
    #//*******************************
    Label(win,text="Anc1:").pack(side=LEFT)
    #//*******************************
    #//*** Build Anchor Initials Entry
    #//*******************************
    widgets['anc1'] = Entry(win, width=int(bw*.75), name='anc1')
    widgets['anc1'].insert(0,"ANC1")
    widgets['anc1'].pack(side=LEFT)
    #//************************************
    #//*** Build Co-Anchor Initials Label
    #//************************************
    Label(win,text="Anc2:").pack(side=LEFT)
    #//************************************
    #//*** Build Co-Anchor Initials Entry
    #//************************************
    widgets['anc2'] = Entry(win, width=int(bw*.75), name='anc2')
    widgets['anc2'].insert(0,"ANC2")
    widgets['anc2'].pack(side=LEFT)


    #//***********************************
    #//*** Build Director Initials Label
    #//***********************************
    Label(win,text="Initials:").pack(side=LEFT)
    #//***********************************
    #//*** Build Director Initials Entry
    #//***********************************
    widgets['initials'] = Entry(win, width=int(bw*.75), name='initials', text="ANC2")
    widgets['initials'].pack(side=LEFT)

    #//*** Probably should build some specialized Menu system for Special Characters.
    #//*** Something specific that handles the bugs 
    #//*** Something that handles a larger long tail of of codes

    #//***********************************
    #//*** Build Bug Drop Down Entry
    #//***********************************



    #//*******************************
    #//*** Build Quit Button
    #//*******************************
    Button(win, text="Quit", command=doQuit).pack( side = LEFT ) 

def connect_to_dalet():

    elem = get_focused_object()


    if elem != None:
        print(get_element_type(elem) )

        
     
    time.sleep(1)

    

    

    connect_to_dalet()
    
#//*** Launch Keyboard and HTTP server as threads    
listener = threading.Thread(target = listen_for_ahk, args=[9999])
listener.daemon = True
listener.start()


keeb = threading.Thread(target = capture_keystroke_threaded)
keeb.daemon = True
keeb.start()

#//*** USe this to monitor the Dalet Interface, good for testing/debugging
#dalet_mon = threading.Thread(target = connect_to_dalet)
#dalet_mon.daemon = True
#dalet_mon.start()


#print(dir(keeb))

    
#//**** Build & Launch Authotkey File from master_rules
buildAHKFile(master_rules)

buildGui()



#//*** Update selected Values When win loses focus
win.bind("<FocusOut>", on_focus_out)

#//*** Run Window Mainloop
win.mainloop()