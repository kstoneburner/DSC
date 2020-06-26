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

getFiles = {
    "CDC_all_mortality" : {
        "name" : "Dowloading CDC Mortality Data",
        "url" : "https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true",
        "file" : "cdcMortality.csv",
    },
    "CA_Covid_Cases": {
        "name": "Downloading CA Covid Info",
        "url": "https://data.chhs.ca.gov/dataset/6882c390-b2d7-4b9a-aefa-2068cee63e47/resource/6cd8d424-dfaa-4bdd-9410-a3d656e1176e/download/covid19data.csv",
        "file": "ca_covid_cases.csv"
    }
}

#### Download each file in getFiles
for x in getFiles.keys():
    print(getFiles[x]["name"])
    response = requests.get(getFiles[x]["url"],stream=True)
    f = open(getFiles[x]["file"], 'w')
    thisOut = response.text.replace("\ufeff","")
    thisOut = thisOut.replace("\r\n\r\n","\r\n")
    #f.write(str(response.text.encode('utf-16')))
    f.write(thisOut)
    f.close()
    #print(response.text)
    print(getFiles[x]["name"])

