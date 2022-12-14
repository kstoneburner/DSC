import requests, json
overdrive_server_ip = "10.218.116.11"
transition_filename = "transitions.json"
mos_variables_filename = "l:\\tools\\Scripts\\ross\\Dalet\\Define.BaseShots"

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

				out[key] = value

		return out
				
				
def build_first_rule_row():
	row=0
	col=0

	rule_row = Frame(win)

	widget_row = widget_builder()


	#//*** Build Label Line
	#for x in ["Name","CTRL","WIN","SHIFT","ALT","Keyboard Key"]:
	wb.add_widgets({
		"type" : "label",
		"text" : "Name",
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "CTRL",
		"row" : row,
		"column" : col,
		"padx" : -10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "WIN",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "SHIFT",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "ALT",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "Key",
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "Codes",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1
	return rule_row

def build_rule_row():


	row = 0
	col = 0

	rule_row = Frame(win)
	widget_row = widget_builder()
	
	rule_row.params = {
		"elems" : 0
	}
	
	widget_row.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		"hook" : "name",
		"width" : 15,
	},rule_row)

	for hook in ["CTRL","WIN","SHIFT","ALT"]:
		col = col + 1
		wb.add_widgets({
			"type" : "rule_checkbox",
			"row" : row,
			"column" : col,
			"hook" : hook,
			"width" : 1,
		},rule_row)

	col = col + 1
	wb.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		"hook" : "key",
		"width" : 5,
	},rule_row)

	col = col + 1
	wb.add_widgets({
		"type" : "button",
		"row" : row,
		"column" : col,
		"hook" : "add_rule",
		"width" : 5,
		"action" : "add_code",
		"text" : "+",
		"padx" : 10,
	},rule_row)
	return rule_row


if __name__ == '__main__':
	print(load_mos_object_variables().keys())
	
	