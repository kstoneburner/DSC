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
    #"CDC_all_mortality" : {
    #    "name" : "Dowloading CDC Mortality Data",
    #    "url" : "https://data.cdc.gov/api/views/hc4f-j6nb/rows.csv?accessType=DOWNLOAD&bom=true&format=true",
    #    "file" : "cdcMortality.csv",
    #},
   "CA_covid_Hospitalization.csv": {
       "name": "Dowloading California Hospital Data",
       "url": "https://data.ca.gov/dataset/529ac907-6ba1-4cb7-9aae-8966fc96aeef/resource/42d33765-20fd-44b8-a978-b083b7542225/download/hospitals_by_county.csv",
       "file": "CA_covid_Hospitalization.csv",
   }


}

#### Download each file in getFiles
for x in getFiles.keys():
    print(getFiles[x]["name"])
    response = requests.get(getFiles[x]["url"],stream=True)
    f = open(getFiles[x]["file"], 'w')
    #f.write(str(response.text.encode('utf-8')))
    f.write(response.text)
    f.close()
    print(response.text)
    print(getFiles[x]["name"])
