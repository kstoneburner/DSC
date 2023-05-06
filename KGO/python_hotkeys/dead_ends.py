

#//*** Launch Keyboard and HTTP server as threads    
listener = threading.Thread(target = listen_for_ahk, args=[9999])
listener.daemon = True
listener.start()


#//*** USe this to monitor the Dalet Interface, good for testing/debugging
dalet_mon = threading.Thread(target = connect_to_dalet)
dalet_mon.daemon = True
dalet_mon.start()


                    
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




def launchAHKScript(ahk_path):
    subprocess.run([ahk_path,master_ahk_triggers_filename])



def get_valid_rule():
    pass

def connect_to_dalet():

    elem = get_focused_object()


    if elem != None:
        print(get_element_type(elem) )

        
     
    time.sleep(1)

    

    

    connect_to_dalet()
    
def capture_keystroke_threaded():
    
    lock = threading.Lock()
    keep_going = True
    while keep_going:
        time.sleep(.001)


        keystroke = keyboard.read_key()
        print("Keystroke:",keystroke)
        
            #if keystroke == "esc":
            #    #keep_going = False
            #    print("Quitting")
            #    keep_going = False
            #    doQuit()

#keeb = threading.Thread(target = capture_keystroke_threaded)
#keeb.daemon = True
#akeeb.start()

def handle_raw_hotkey(event):
    print(event)
    #print("handle_keystroke_release")
    #
    #print(key,event.event_type,keyboard.is_pressed("shift"))

    #//*** Logically Release Modifier keys on every keystroke
    for x in ['ctrl',"shift","win","alt"]:
        if not keyboard.is_pressed(x):
            keyboard.send(f"{x}",do_press=False, do_release=True)

    #//*** Check if key in hotkeys, It should be. Otherwise this shouldn't trigger
    key=event.name
    if key in master_rules.keys():


        
        #//*** Verify Current Studio Mode exists for Key
        if selected["studio_mode"] in master_rules[key].keys():

            
            #//*** Verify Current Alt Mode exists for Key
            if selected["alt_modes"] in master_rules[key][ selected["studio_mode"] ].keys():

                #//*** Get Rule
                rule = master_rules[key][ selected["studio_mode"] ][ selected["alt_modes"] ]
                
                #//*** Verify Rule Modifers match keyboard modifier states
                if (rule['keystroke']['ctrl'] == keyboard.is_pressed('ctrl') and 
                    rule['keystroke']['shift'] == keyboard.is_pressed('shift') and 
                    rule['keystroke']['win'] == keyboard.is_pressed('win') and
                    rule['keystroke']['alt'] == keyboard.is_pressed('alt')):
                    
                    #//*** Handle the rule if Dalet is the currently active window.
                    #//*** This process takes some CPU cycles, so saving it for last.
                    if in_dalet():
                        print(rule)
                        print("In Dalet, Let's do some macroing!")
                        return





#//*** Emulate regular keystrokes
def passthru_keystroke(event):

    modifier_list = ['ctrl',"shift","win","alt"]

    print("Pass Thru Keystroke")
    key=event.name
    if event.event_type == "down":
        
        if key in modifier_list:
            keyboard.send(f"{key}",do_press=True, do_release=False)
            print(keyboard.is_pressed("shift"))
        else:
            mod_keys=""
            for x in modifier_list:
                if keyboard.is_pressed(x):
                   mod_keys += f"{x}+"
            print(f"sending:{mod_keys}{key}")
            #keyboard.send(f"{mod_keys}{key}")

            keyboard.send(f"{mod_keys}{key}",do_press=True, do_release=False)

    elif event.event_type == "up":
        
        mod_keys=""
        #for x in ['ctrl',"shift","win","alt"]:
        #    if not keyboard.is_pressed(x):
        #       keyboard.send(f"{x}",do_press=False, do_release=True)

        print("releasing:",key)
        #keyboard.send(f"{mod_keys}{key}",do_press=True, do_release=True)
        keyboard.send(f"{key}",do_press=False, do_release=True)
  
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
