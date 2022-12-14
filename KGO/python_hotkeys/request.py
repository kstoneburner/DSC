import requests, json
overdrive_server_ip = "10.218.116.11"
transition_filename = "transitions.json"
transitions = None

#//*** Download video Transitions from Overdrive Server
response = requests.get(f'http://{overdrive_server_ip}/server/rest/api/videoTransitions')

#//*** If good response, parse and save data
if response.status_code == 200:
	print("success")
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
		
	print(tran)
	