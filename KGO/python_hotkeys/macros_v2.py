#//**** Keyboard...Call Later:
#//**** https://github.com/boppreh/keyboard/issues/492


import sys,re,multiprocessing,pyperclip
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

global keystroke
keystroke = None

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

global display_help 

display_help = True

enter_exit_script_key = 'f7'
connected = False


sys.coinit_flags = 0


global quit


quit = False

hotkey_hooks = {}

default = {
    
    "transition" : '1_CUT _CLRG1'    

}
selected = {

    "studio_mode" : "desk_studio",
    "alt_modes" : 'base',
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

    selected['transition_id'] = transitions[ selected['transition'] ]

    print("updateSelectedValues: ",selected)



def doQuit():
    print("doQuit()")
    keyboard.unhook_all()
    win.destroy()
    sys.exit()
    return
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


def in_dalet():
    active_window_text = win32gui.GetWindowText (win32gui.GetForegroundWindow())
    if "Dalet Galaxy" in active_window_text:
        return True
    return False


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
    print("get_elem_type ",elem)
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

def wait_for_update(elem,target):
    count = 0
    while len(elem.texts()[0]) < target:
        print("Waiting for update:",len(elem.texts()[0]),":",target)
        time.sleep(.1)
        count += 1

        if count >= 50:
            print("Wait Loop Timed Out")
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

    print("Handling:",code)
    #keyboard_state = keyboard.stash_state()

    #print( keyboard_state )
    #for mod in ['ctrl','win','shift','alt']:
        
        #keyboard.unblock_key(mod)
    #    reset[mod] = keyboard.is_pressed(mod)
    #    if reset[mod]:
    #        keyboard.release(mod)
    #        keyboard.block_key(mod)
            


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

        elem = get_focused_object()
        print("Focused Object")
        print(elem)
        
        
        if elem != None:
            
            error = False

            elem_type = get_element_type(elem)

            if elem_type == "rundown" or elem_type == "rundown_field":
                enter_script(enter_exit_script_key)   

            print(selected['transition'])
            print(code)  

            mos = code['mos']  

            pattern = "<transition>.+</transition>"

            values = re.findall(pattern,mos)
            
            if len(values) == 0:
                error = True

            if not error:
                find_tran = values[0]
                replace_tran = f"<transition><id>{selected['transition_id']}</id><name>{selected['transition']}</name></transition>"
                print(find_tran)
                print(replace_tran)

                pattern = "<name>.+</name>"
                find_name = re.findall(pattern,find_tran)[0].replace("<name>","").replace("</name>","")
                print("Find Name:", find_name)


                mos = mos.replace(find_tran,replace_tran)
                mos = mos.replace(find_name,selected['transition'])

                pyperclip.copy(mos)

                time.sleep(.2)

            
            keyboard.press('ctrl')
            keyboard.press_and_release('v')
            keyboard.release('ctrl')
            wait_for_update(elem,len(elem.texts()[0]))
            
            
            keyboard.press_and_release('enter')
            wait_for_update(elem,len(elem.texts()[0]))
            
            




            

    else:
        print("Handle Transition:", code['transition'])
        print(code)
        print(transitions)
    
    
    
    #keyboard.restore_modifiers(keyboard_state)
    #print(reset)
    #for mod in ['ctrl','win','shift','alt']:
    #    if reset[mod]:
    #        keyboard.unblock_key(mod)
    #        keyboard.press(key_to_scan_codes(mod))
    #    print(mod,keyboard.key_to_scan_codes(mod),keyboard_state,keyboard.is_pressed(mod))

def toggleHelp(input_help):
    
    input_help = not input_help

    display_help = input_help
    print( input_help, display_help)

    print(master_rules)
    layout = {
        'F-Row' : ['f1' ,'f2' ,'f3' ,'f4' ,'f5' ,'f6' ,'f7' ,'f8' ,'f9' ,'f10' ,'f11' ,'f12','print screen' ,'scroll lock' ,'pause'],
        'tilde' : ['`' ,'1' ,'2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' ,'0' ,'-' ,'=' ,'backspace','insert' ,'home' ,'page up' ,'num lock' ,'/' ,'*' ,'-'],
        'tab' : ['tab' ,'q' ,'w' ,'e' ,'r' ,'t' ,'y' ,'u' ,'i' ,'o' ,'p' ,'[' ,']' ,'\\','delete' ,'end' ,'page down','7' ,'8' ,'9','+'],
        'caps lock' : ['caps lock' ,'a' ,'s' ,'d' ,'f' ,'g' ,'h' ,'j' ,'k' ,'l' ,';' ,'\'','enter' ,'4' ,'5' ,'6'],
        'shift' : ['z' ,'x' ,'c' ,'v' ,'b' ,'n' ,'m' ,',' ,'.' ,'/', 'enter' ,'0','1' ,'2' ,'3' ,'decimal'],
    }





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
    widgets['alt_modes'] = ttk.Combobox(win,values=alt_modes,width=bw,state='readonly',name='alt_modes')
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
    #//*** Build HELP Button
    #//*******************************
    Button(win, text="Help", command=lambda: toggleHelp(display_help)).pack( side = LEFT ) 


    #//*******************************
    #//*** Build Quit Button
    #//*******************************
    Button(win, text="Quit", command=doQuit).pack( side = LEFT ) 

                    
  
#//**** Build & Launch Authotkey File from master_rules
#buildAHKFile(master_rules)

#//*** Parse master Rules (Loaded From JSON)
#//*** Register Hotkeys based on the Unique Rule Triggers.
#//*** Triggers are used to determine which Hotkey is active.
def register_hotkeys(master_rules):

    #//*** Builds the Hotkey Keystroke Value to register.
    def build_hotkey_trigger(selected_key,keystroke):

        out = ""

        for key,value in keystroke.items():
            if key == 'ctrl' and value:
                out += "ctrl + "
            if key == 'win' and value:
                out += "win + "
            if key == 'shift' and value:
                out += "shift + "
            if key == 'alt' and value:
                out += "alt + "
        
        #print(out)
        #if out[-3:] == " + ":
        #    out = out[:-3]
        #    out += ", "
        #print(out)
            
        out +=f"{selected_key}"
        #print("Trigger: ",out)


        return out

    print("register_hotkeys")
    


    trigger_list = []

    
    for key,top_level_rule in master_rules.items():

        
        for rule_key,rule_studio_mode in top_level_rule.items():
            
            
            for rule_alt_mode_key, rule_value in rule_studio_mode.items():
                #print(key, rule_key,rule_alt_mode_key,rule_value['keystroke'])
                hotkey_trigger = build_hotkey_trigger(key, rule_value['keystroke'])
                
                if hotkey_trigger not in trigger_list:
                    trigger_list.append(hotkey_trigger)
                    keystroke = rule_value['keystroke']
                    print("Adding: ", hotkey_trigger, ":",rule_key,rule_alt_mode_key,keystroke)

                    #//*** Add the Complete Hotkey Trigger
                    keyboard.add_hotkey(hotkey_trigger, handle_hotkey_inputs,args=[keystroke], suppress=True,trigger_on_release=True)
                    
                    #//*** Add a trigger for just the key. This trigger is intended to activate if keys are pressed in sequence.
                    #//*** The Complete Hotkey Triggers only once with the Modifier keys pressed.
                    #//*** This generates a lot of base key triggers, which should exit quickly if modifiers are not pressed.
                    print("Adding: ", key, ":",rule_key,rule_alt_mode_key,keystroke)
                    keyboard.add_hotkey(key, handle_hotkey_inputs,args=[keystroke], suppress=True,trigger_on_release=True)

                #    ahk_trigger_text += build_AHK_text(ahk_trigger,key,rule_value['keystroke'])

def handle_hotkey_inputs(input_keystroke):
    
    
    print("Handle Inputs")
    print(input_keystroke)



    rule = getRule_based_on_inputs(input_keystroke)


    print("RULE:",rule)


    #//*** If Valid Rule Process Each Code individually
    if rule != None:

        for code in rule['codes']:
            handleCode(code)
    else:
        keyboard.press_and_release(input_keystroke['key'])


def getRule_based_on_inputs(valid_input):


    print("GET RULE")

    #//*** Validate Key. It should all be linked, but paranoia.
    if valid_input['key'] in master_rules.keys():
        
        
        key_level_rule = master_rules[ valid_input['key'] ]
        
        #//*** Check if Studio Mode is associated with the key:
        if selected["studio_mode"] in key_level_rule.keys():
            studio_mode_level_rule = key_level_rule[ selected["studio_mode"] ]

            #//*** Check if Selected Alt Mode is defined in  studio_mode_level_rule keys
            if selected[ "alt_modes" ] in studio_mode_level_rule.keys():
                
                print(selected[ "alt_modes" ], list(studio_mode_level_rule.keys()))
                print("Valid Input:",valid_input)
                rule = studio_mode_level_rule[ selected[ "alt_modes" ] ]

                #//*** Validate Input Keypress, match rule keypress
                #//*** Should be equal, in version #1. Could change with time.
                for x in ['ctrl','win','shift','alt']:
                    print(x,":",valid_input[x] == keyboard.is_pressed(x))
                    if not valid_input[x] == keyboard.is_pressed(x):
                        #//*** Return None if if Input Keystrokes don't match rule Keystrokes.
                        return None

                #//*** Rule is Valid as far as we can tell
                return rule



    return None



buildGui()


#//*** Close Windows on ESC
keyboard.add_hotkey('ctrl + esc',lambda: doQuit(),suppress=True)
#keyboard.add_hotkey('win', lambda: print("DING"), trigger_on_release=False)
#keyboard.add_hotkey('q',lambda: handle_raw_hotkey("q"),suppress=True)
#skeyboard.hook(handle_raw_hotkey,suppress=True)
#keyboard.hook_key("shift",ignore_key, suppress=False )
#keyboard.add_hotkey("ctrl + win+ q",lambda: call_rule("q"),suppress=Truee,trigger_on_release=True)
#keyboard.add_hotkey("ctrl + win + w",lambda: call_rule("w"),suppress=True,trigger_on_release=True)
#for key in master_rules.keys():
#    keyboard.hook_key(key, handle_raw_hotkey,suppress=True)
#keyboard.on_press_key()

register_hotkeys(master_rules)

print( master_rules.keys() )

#//*** Update selected Values When win loses focus
win.bind("<FocusOut>", on_focus_out)

#//*** Run Window Mainloop
win.mainloop()