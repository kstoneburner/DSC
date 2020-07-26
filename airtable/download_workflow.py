import json
try:
    import requests
except:
    print("=========================================================================================================================================")
    print("You need to install the Requests library!")
    print("=========================================================================================================================================")
    print("Install Pip: get-pip.py included in this folder")
    print("For Windows: Add pip to your path")
    print("Locate python scripts path. should be something similar to:")
    print("C:\\Users\\%username%\\AppData\\Local\\Programs\\Python\\Python38-32\\Scripts")
    print("to add to path use: path=%path%;C:\\Users\\%username%\\AppData\\Local\\Programs\\Python\\Python38-32\\Scripts ")
    quit()

#"https://api.airtable.com/v0/appmIMEB5hUAv3fYU/Network_Workflow_Tab/?api_key=keyAf4mqDWplUMH1S"

#print(getFiles[x]["name"])

APICall= "https://api.airtable.com/v0/appmIMEB5hUAv3fYU/Network_Workflow_Tab/?api_key=keyAf4mqDWplUMH1S"
response = requests.get(APICall,stream=True)



master_data = json.loads(response.text)

# f = open(getFiles[x]["file"], 'w')
#f.write(str(response.text.encode('utf-8')))
#f.write(response.text)
#f.close()

print(master_data)

print(master_data["offset"])

keys = master_data.keys()

loopLimit = 0
while "offset" in keys:
  thisOffset = master_data["offset"]

  print(thisOffset)
  print(APICall + "&"+thisOffset)
  response = requests.get(APICall + "&offset="+thisOffset,stream=True)

  ### Build Temp Object
  thisOBJ = json.loads(response.text)

  ### Update keys for main loop
  keys = thisOBJ.keys()

  #print(thisOBJ)



  print(len(thisOBJ["records"]))

  for x in thisOBJ["records"]:
    #thisRecord = thisOBJ["records"][x]
    print(x)

    master_data["records"].append(x)
    


  loopLimit = loopLimit + 1

  if loopLimit > 3:
    print("Reached Loop Limit. Quitting!")
    break




print(len(master_data["records"]))
outputString = json.dumps(master_data)

print(outputString)

f = open("network_flow_tab.json", 'w')
#f.write(str(outputString.encode('utf-8')))
f.write(outputString)
f.close()