import sys,re,multiprocessing
import socket,threading,keyboard,time,subprocess,winreg
from http.server import HTTPServer, BaseHTTPRequestHandler


from hotkey_core_modules import *
from macros_core_modules import *

master_hotkey_filename = "master_hotkeys.json"
master_rules = load_master_rules(master_hotkey_filename)
master_ahk_triggers_filename = "triggers.ahk"

transitions,transition_actions = load_transitions()
alt_modes = load_alt_modes()
show_modes = load_show_modes()


selected = {

    "studio_mode" : "desk_studio",
    "alt_mode" : 'base',
    "transition" : "1_CUT_CLR_G1"
}




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
            
            for x in self.requestline.split(" "):
                if "?" in x:
                    response = x.replace("/?","")

                    if "action=quit" not in response:

                            handleAHK_inputs(response)

            #//*** Send a Basic Response to keep the hotkey COM server object happy.            
            self.send_response(200)
            self.send_header('content-type','text/html')
            self.end_headers()
            self.wfile.write('Python HTTP Webserver Tutorial'.encode())

            if "action=quit" in self.requestline:
                
                print("Quitting LIstener")
                
                sys.exit()
    
    #//*** Spin up HTTP Server
    srv = HTTPServer(('',PORT), CustomHandler)
    print('Server started on port %s' %PORT)
    srv.serve_forever()




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

def handleCode(code):

    print(transitions)
    if code['transition'] == "ACTION":
        pass
    elif code['transition'] == "selected_transition":
        print("PROCESS Selected Transistsion")

    else:
        print("Handle Transition:", code['transition'])
        print(code)


    
    
    
        


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

    
    
#//*** Launch Keyboard and HTTP server as threads    
listener = threading.Thread(target = listen_for_ahk, args=[9999])
#listener.daemon = True
listener.start()

keeb = threading.Thread(target = capture_keystroke_threaded)
#keeb.daemon = True
keeb.start()
    
#//**** Build & Launch Authotkey File from master_rules
buildAHKFile(master_rules)
