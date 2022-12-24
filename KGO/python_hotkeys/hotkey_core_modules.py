import requests, json, re, sys

overdrive_server_ip = "10.218.116.11"
transition_filename = "transitions.json"
mos_variables_filename = "l:\\tools\\Scripts\\ross\\Dalet\\Define.BaseShots"
mos_variables_filename = "config.codes"
alt_modes = ['base','alt1']
show_modes = ['desk_studio']
hotkey_actions = ['enter_exit_script','autocode']
def load_transitions(overdrive_server_ip=overdrive_server_ip):
	#//*** Download video Transitions from Overdrive Server
	response = requests.get(f'http://{overdrive_server_ip}/server/rest/api/videoTransitions')

	#//*** If good response, parse and save data
	if response.status_code == 200:
		print("Downloading Transitions")
		raw_tran = json.loads(response.content)
		transitions = {}

		#//*** Build dictionary of all transitions
		for obj in raw_tran:
			
			transitions[obj['name']] = obj['id']

		with open(transition_filename, "w") as outfile:
			json.dump(transitions, outfile)
	else:
		#//*** in the unlikely event of unable to connect, use cached transitions
		with open(transition_filename, "r") as infile:
			transitions = json.loads(infile.read())
	
	return transitions

def load_mos_object_variables():
	out = {}
	#//*** Load Autohotkey Mos Variables
	with open(mos_variables_filename, "r") as infile:
		for line in infile.readlines():
			
			if "=" in line:
				#//*** Split Line[0] and strip any Spaces 
				key = line.split("=")[0].replace(" ","")

				#//*** Trim Trailing Newline Character
				value = line.split("=")[1][:-1]

				findvals = re.findall("<shotName>.+</shotName>",value)
				
				shotName = ""
				if len(findvals) > 0:
					shotName = findvals[0].replace("<shotName>","").replace("</shotName>","")
				

				findvals = re.findall("<imageURL>.+</imageURL>",value)
				imageURL = ""
				if len(findvals) > 0:
					imageURL = f"http://{overdrive_server_ip}"
					imageURL += findvals[0].replace("<imageURL>","").replace("</imageURL>","")


				
				out[key] = {
				
					"mos" : value,
					"shotName" : shotName,
					"imageURL" : imageURL

				}

		for key,value in out.items():
			imageURL = value['imageURL']
			print("Downloading image",imageURL)
			response = requests.get(imageURL)
			
			#//*** If good response, parse and save data
			if response.status_code == 200:
				out[key]['image'] = response.content

		return out
				
def load_alt_modes():
	return alt_modes

def load_show_modes():
	return show_modes

def load_hotkey_actions():
	return hotkey_actions

def load_keyboard_key_list():
	
	out = {
	'all' : [],
	'F-Row' : ['f1' ,'f2' ,'f3' ,'f4' ,'f5' ,'f6' ,'f7' ,'f8' ,'f9' ,'f10' ,'f11' ,'f12'],
	'specials' : ['print screen' ,'scroll lock' ,'pause' ,'insert' ,'home' ,'page up' ,'delete' ,'end' ,'page down'],
	'keypad' : ['num lock' ,'/' ,'*' ,'-', '+' ,'enter' ,'0','1' ,'2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9','decimal'], 
	'tilde' : ['`' ,'1' ,'2' ,'3' ,'4' ,'5' ,'6' ,'7' ,'8' ,'9' ,'0' ,'-' ,'=' ,'backspace'],
	'tab' : ['tab' ,'q' ,'w' ,'e' ,'r' ,'t' ,'y' ,'u' ,'i' ,'o' ,'p' ,'[' ,']' ,'\\'],
	'caps lock' : ['caps lock' ,'a' ,'s' ,'d' ,'f' ,'g' ,'h' ,'j' ,'k' ,'l' ,';' ,'\'','enter' ,],
	'shift' : ['z' ,'x' ,'c' ,'v' ,'b' ,'n' ,'m' ,',' ,'.' ,'/' ],
	}
	
	#//*** Build a list of all keys
	for key,value in out.items():
		if key == 'all':
			continue
		for item in out[key]:
			if item not in out["all"]:
				out["all"].append(item)

	#out["all"] = list(set(out["all"]))
	return out

if __name__ == '__main__':
	print(load_mos_object_variables().keys())
	
	