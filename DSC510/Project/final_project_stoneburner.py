####################################################################################################
####################################################################################################
####################################################################################################
#### course: DSC510
#### assignment: 12.1
#### date: 04/27/20
#### name: Kurt Stoneburner
#### Program Purpose:
##################### Get the current weather conditions for any city in the world by city name.
##################### Or any US city by zip code.
##################### This Program is windows *only*, and is required for autocomplete and
##################### up/Down Arrow functions
####################################################################################################
#### Courtesy: Zip Code List downloaded From - https://simplemaps.com/data/us-zips
##########################################################################################
#### API Call Example: Call by City ID
##########################################################################################
#### api.openweathermap.org/data/2.5/weather?id={city id}&appid={your api key}
##########################################################################################
#### API Call Example: Call by City ZIP Code
##########################################################################################
#### http://api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={your api key}
##########################################################################################
#### API Key = 17839eee3906ba441aa25d06cb196d3c
##########################################################################################
#### Install requests: curl http://bootstrap.pypa.io/get-pip.py -o get-pip.py
##########################################################################################
#### Weather ID types - https://openweathermap.org/weather-conditions
##########################################################################################
try:
    import msvcrt
except:
    print("=========================================================================================================================================")
    print("This program is Windows ONLY!")
    print("It depends on the MSVCRT library which is used by windows exclusively")
    print("=========================================================================================================================================")
    quit()
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
import os
import sys
import platform
import json
import re
import wxArtwork ### Included as a local library to help reduce clutter
#######################################################################################################################
#### FUNCTIONS
#######################################################################################################################
#### clrScreen: Clears the Screen. Only Works on Windows machines AFAIK
#######################################################################################################################
#### cl: convenience function, refers to JavaScript console.log which is the rough equivalent of print
####     without the newline character. Use sys.stdout.write, screen is drawn with the flush command
#######################################################################################################################
#### clb: convenience function, like cl without the flush. This allows multiple write commands to the screen buffer
####      helps make code more readable and allows the whole screen frame to be drawn in one command.
####      Could proabaly have used one giant string and a single print.
#######################################################################################################################
#### displayWeather: Process and format retrieved weather information for display. Columns and rows are managed manually.
#################### The layout could be more easily restructured using string.format(). But I did it 'the hard way'
#################### before learning about string formatting
#### drawScreen: All in one drawscreen function, uses global values stored in the master dictionary
###############  triggered by valid keystrokes.
#######################################################################################################################
#### getMatches: Builds the list of partial matching Cities
#######################################################################################################################
#### getWeather: Performs the API call to open weather returns a dictionary, containing the reposnse
####################################################################################a###################################
#### getZipMatches: Builds the list of partial matching Zip Codes
#######################################################################################################################
#### initialize: Initialization routines moves here. Loads a variety of dictionaries including artwork and building
################ autocomplete dictionaries. This was moved to a function to make the code collapsible in the editor
################ to help make the code more readable.
#######################################################################################################################
#######################################################################################################################
#######################################################################################################################

#### Global master - Dictionary contains all global values
g = {
    "currentInput" : "",
    "mainMessage":
        "=========================================================================================\n"
        "World wide weather\n"
        "Current Temps in any city\n"
        "=========================================================================================\n"
        "ESC-Quit | Up/Down Arrow Nav | ENTER Choose\n"
        "=========================================================================================\n"
        "Start typing City Name or ZipCode\n"
        "=========================================================================================\n\n\n"
        "What City: ",
    "forecastMessage" : "",
    "cityList" : [],
    "cityID" : {},
    "partialCity" : [],
    "zipList" : [],
    "zipCity" : {}, ### key: zip code, ### value is City, County Country
    "zipAttrib" : {},
    "partialZip" : {},
    "selectedIndex" : -1, #### The index of PartialCities that indicates selected City
    "modeState" : "main", #### Used in handling keyboard input. Mode determines if next keystroke clears text
    "diag" : "",
    "resetText" : False,
    "inputMode" : "",
    "partialDict" : {},
    "requestCall" : "http://api.openweathermap.org/data/2.5/weather?id=", ### API call by cityID
    "requestZip" : "http://api.openweathermap.org/data/2.5/weather?zip=", ### API call by zip
    "apiKey" : "&units=imperial&appid=17839eee3906ba441aa25d06cb196d3c",
    "art" : {},
    "artMain" : {},  ### ASCII Text as Art: Cloudy, Sunny, Clear...Rainy...Etc
    "artImage" : {}, ### ASCII Art Images
    "lineLength" : 80,
    "weatherID" : {
        "200" : "Thunderstorm",
        "300" : "Drizzle",
        "500" : "Rain",
        "600" : "Snow",
        "800" : "clear",
        "801" : "few clouds",
        "802" : "scattered clouds",
        "803" : "broken clouds",
        "804" : "overcast"
    },
    "compass" : {
        0 : "N",
        1 : "NNE",
        2 : "NE",
        3 : "ENE",
        4 : "E",
        5 : "ESE",
        6 : "SE",
        7 : "SSE",
        8 : "8",
        9 : "SSW",
        10 : "SW",
        11 : "WSW",
        12 : "W",
        13 : "WNW",
        14 : "NW",
        15 : "NNW",
        16 : "N",
    }

}
##### END Global Master

def clrScreen():
    #print( str(os.system('clear') )
    if platform.system() == 'Windows':
        os.system('cls')  # Linux - 'clear'
    else:
        #### Linux and Mac version is untested
        os.system('clear')

def cl(input):
       ### Console.log - Write to the console with StdOut.
       ### If input is empty, just flush
    if len(input) > 0:
        sys.stdout.write(input)

    sys.stdout.flush()

def clb(input):
    #### Buffer the Display, don't flush
    sys.stdout.write(input)

def displayWeather(wxOBJ):

    def getSpacers(inputRow1, inputRow2):
        ### Outputs Row Whitespace, for nicely formatted columns. We could and should use format.
        ### But I enjoy the sisphyean challenge
        outputRow1 = ""
        outputRow2 = ""

        length_row1 = len(inputRow1)
        length_row2 = len(inputRow2)
        length_difference = -1

        if length_row1 > length_row2:
            ### row1 is bigger, get the difference and add that number of spaces to row2
            length_difference = length_row1 - length_row2

            for x in range(0, length_difference):
                outputRow2 += " "


        else:
            ### row2 is bigger, get the difference and add that number of spaces to row1
            length_difference = length_row2 - length_row1

            for x in range(0, length_difference):
                outputRow1 += " "

        return outputRow1, outputRow2

    #print(wxOBJ)

    ##################################################################################################
    #### There is definitely a more pythonic way to do this layout of columns and rows.
    #### I suspect most of this could be handled with string.format()
    #### In this case, I brute forced the layout and very likely unneccessarily reinvented the wheel
    ##################################################################################################

    ### Initialize Weather Message
    g["forecastMessage"] = ""

    ### Wrap the whole display Message in a try. I caught at least one art type that failed to load during
    ### testing. Unfortunately, I was unable to replicate the issue.
    ### Failure will return a generic try again message.
    try:
        ##############################################
        #### Verify Weather Value Exists
        ##############################################
        ### Check that Weather exists as a Key
        if "weather" in wxOBJ.keys():

            ### Check that the value of Weather, is a list
            if type(wxOBJ["weather"]) is list:
                #print("Is List")
                #### Make Sure List is not empty
                if len(wxOBJ["weather"]) > 0:
                    #print("WXOBJ has Length")

                    ### Check that Index 0 contains a dictionary
                    if type(wxOBJ["weather"][0]) is dict:

                        #print("Weather[0] is a dict")

                        #####################################
                        ### Verify wxID exists
                        #####################################
                        if "id" in wxOBJ["weather"][0].keys():
                            #print("WX ID Exists")

                            ### Yes, I'm converting a valid int to str. Why? Because Javascript leaves scars
                            wxID = str(wxOBJ["weather"][0]["id"])

                            ##########################################
                            ### Verify wxID exists artType
                            ##########################################
                            if wxID in g["artMain"]:
                                thisMain = g["artMain"][wxID]
                                #print("Main = " + thisMain)
                                g["forecastMessage"] += g["artImage"][thisMain]

                            ##########################################
                            ### Verify wxID exists in art package
                            ##########################################
                            if wxID in g["art"]:
                                g["forecastMessage"] += g["art"][wxID]
                            else:
                                ### Art doesn't exist, use plain text instead
                                #print("Going plain text")
                                ### Verify description Field exists
                                if "description" in wxOBJ["weather"][0].keys():
                                    g["forecastMessage"] += wxOBJ["weather"][0]["description"] + "\n"

                        ### END wxID exists

        ### Let's Display our information in a nicely formatted Table. I'm sure there are easier ways to do this
        ### But I like the heavy lifting.
        ### Start by organizing a layout dictionary by row then column
        layout = {
            "row1" : {
                "col1" : {
                    "text" : "Temp: ",
                    "value" : str(wxOBJ["main"]["temp"]) + "\u00B0f",
                },
                "col2" : {
                    "text": "Humidity: ",
                    "value": str(wxOBJ["main"]["humidity"]) + "% ",
                },
                "col3": {
                    "text": "Wind Speed: ",
                    "value": str(wxOBJ["wind"]["speed"]),
                }
            }, ### END Row1
            "row2" : {
                "col1" : {
                    "text" : "Feels Like: ",
                    "value" : str(wxOBJ["main"]["feels_like"]) + "\u00B0f",
                },
                "col2" : {
                    "text": "Pressure: ",
                    "value": str(wxOBJ["main"]["pressure"]) + " mb ",
                },
                "col3": {
                    "text": "Wind Dir: ",
                    "value": "N/A",
                }
            } ### END Row2
        } ### END Layout

        try:
            wind_deg = int(wxOBJ["wind"]["deg"])
        except:
            wind_deg = ""
        try:
            layout["row2"]["col3"]["value"] = g["compass"][int(wind_deg / 22.5)]
        except:
            layout["row2"]["col3"]["value"] = ""

            ### Format the Country Name For Display.
        displayCountry =  "* Forecast for: " + wxOBJ["name"] + " " + wxOBJ["sys"]["country"] + " *"

        g["forecastMessage"] += "\n"

        ### Build an * line the length of displayCountry. Because the formatting looks Cool
        ### This is just adding a * to the display message for the length of displayCountry
        for x in range(0, len(displayCountry)):
            g["forecastMessage"] += "*"
        g["forecastMessage"] += "\n"

        ### Add displayCountry to the forecast Message Plus a newline
        g["forecastMessage"] += displayCountry + "\n"

        ### Initialize the strings to hold each row
        displayRow1 = ""
        displayRow2 = ""

        ### The Spacer fields are used to align shorter of the columns
        col1_row1_spacer = ""
        col1_row2_spacer = ""

        ###############################################################################################################
        ### Spacers are the number of spaces to insert to align the columns.
        ### getSpacers, takes two strings in this case the length of text and value for each column
        ############### The Function determines which string is longer and returns the appropriate spacer value
        ### Note: returning two values from a function feels so weird. I'd normally use a dictionary or an object
        ###       to do the same thing. I like that I built a function that works in such a pythonic manner.
        ###############################################################################################################
        col1_row1_spacer,col1_row2_spacer = getSpacers(layout["row1"]["col1"]["text"] + layout["row1"]["col1"]["value"],layout["row2"]["col1"]["text"] + layout["row2"]["col1"]["value"])

        ### Build Column1
        displayRow1 += "* " + layout["row1"]["col1"]["text"] + col1_row1_spacer + layout["row1"]["col1"]["value"]
        displayRow2 += "* " + layout["row2"]["col1"]["text"] + col1_row2_spacer + layout["row2"]["col1"]["value"]

        ### Get Column2 Spacers
        col2_row1_spacer,col2_row2_spacer = getSpacers(layout["row1"]["col2"]["text"] + layout["row1"]["col2"]["value"],layout["row2"]["col2"]["text"] + layout["row2"]["col2"]["value"])

        ### Build Column2
        displayRow1 += " * " + layout["row1"]["col2"]["text"] + col2_row1_spacer + layout["row1"]["col2"]["value"]
        displayRow2 += " * " + layout["row2"]["col2"]["text"] + col2_row2_spacer + layout["row2"]["col2"]["value"]

        ### Get Column 3 Spacers
        col3_row1_spacer,col3_row2_spacer = getSpacers(layout["row1"]["col3"]["text"] + layout["row1"]["col3"]["value"],layout["row2"]["col3"]["text"] + layout["row2"]["col3"]["value"])

        #### Build Column3
        displayRow1 += " * " + layout["row1"]["col3"]["text"] + col3_row1_spacer + layout["row1"]["col3"]["value"]
        displayRow2 += " * " + layout["row2"]["col3"]["text"] + col3_row2_spacer + layout["row2"]["col3"]["value"]

        displayRow1 += "*\n"
        displayRow2 += "*\n"

        #### Build a line of asteriks that it equal to the row length.
        #### These asteriks will make things pretty
        asterisk_line = ""
        for x in range(0,len(displayRow1)):
            asterisk_line += "*"

        asterisk_line += "\n"
        g["forecastMessage"] += asterisk_line
        g["forecastMessage"] += displayRow1
        g["forecastMessage"] += asterisk_line
        g["forecastMessage"] += displayRow2
        g["forecastMessage"] += asterisk_line

    #### Properties
    # dt - Data Receiving Time
    # temp
    # humidity
    # pressure
    # wind : s
    #clrScreen()
    except Exception as e:
        ### Caught an error along the way
        g["forecastMessage"] = ""
        g["forecastMessage"] += "***************************************************************\n"
        g["forecastMessage"] += "There appears to be an issue formatting weather from that City.\n"
        g["forecastMessage"] += "Please try again.\n"
        g["forecastMessage"] += "***************************************************************\n"
        g["forecastMessage"] += str(e) + ":" + str(sys.exc_info()[0]) + "\n"
        g["forecastMessage"] += "***************************************************************\n"

    print(g["forecastMessage"])

    g["modeState"] = "wx"
    print("ESC to Quit / Any key for another forecast")

def drawScreen():
    ########################################################################################################
    #### clb - buffers text sys.stdout.write. This is similar to writing to a string and using print.
    ####       Theoretically, it's supposed to draw the screen faster. The difference is cosmetic
    #### cl - The equivalent of print without the Newline. It also displays any text buffered with clb
    ########################################################################################################
    clrScreen()
    clb(g["mainMessage"] + g["currentInput"] )
    clb("\n")
    clb("\n")
    ########################################################################################################
    ### Draw Diagnostic Message (if Any)
    ### it's helpful to send messages from different parts of the program here for info/debugging
    ### It's convenience function.
    ########################################################################################################

    if len(g["diag"]) > 0:
        clb("==============================================================================================================================================\n")
        clb(g["diag"] + "\n")
        clb("==============================================================================================================================================\n")

    ##############################################################################################################
    #### Initialize selectedIndex to 0 if Partial City has items
    #### If there is a list of partial city names, and none has been selected, choose the first one by default
    #### If User hits ENTER, this city will be selected
    ##############################################################################################################
    if g["selectedIndex"] == -1 and len(g["partialCity"]) > 0:
        g["selectedIndex"] = 0

    startIndex = 0

    ### Draws the selection arrow --> This trick draws the Selection list from selection -2 to selection +8.
    ### This draws a pretty list showing 2 prior selections, but only if the selection is 3 or greater.
    if g["selectedIndex"] > 2:
        startIndex = g["selectedIndex"]-2

    ### Draw choices: This iterates through the partialcity list, started at the selected index
    ### Which is used to manage drawing up to 10 items on the screen. The loop is broken by the criteria
    ### at the bottom of the loop.
    for x in range(startIndex,len(g["partialCity"])):

        if x == g["selectedIndex"]:
            ## I'm an f-String Convert
            if g['inputMode'] == 'city':
                clb(f"\t--> {g['partialCity'][x]} - {str(g['cityID'][g['partialCity'][x]])} \n")
            elif g['inputMode'] == 'zip':
                clb(f"\t--> {g['partialCity'][x]} - {g['zipCity'][g['partialCity'][x]]}\n" )
        else:
            if g['inputMode'] == 'city':
                clb(f"\t    {g['partialCity'][x]} \n")
            elif g['inputMode'] == 'zip':
                clb(f"\t    {g['partialCity'][x]} - {g['zipCity'][g['partialCity'][x]]}\n")

        ###############################################################################
        #### These limit the total number of choices to 10
        #### Explicitly handle the use cases of Selected Index 0,1,2 and > 2
        #### The list will be a maximum number of 10 items.
        #### If we don't break the List, we'll display everything
        #### Instead of a subset of 10
        ###############################################################################
        if g["selectedIndex"] == 0 and x > g["selectedIndex"] + 10:
            break

        if g["selectedIndex"] == 1 and x > g["selectedIndex"] + 9:
            break

        if g["selectedIndex"] == 2 and x > g["selectedIndex"] + 8:
            break

        if g["selectedIndex"] > 2 and x > g["selectedIndex"] + 8:
            break

    cl("")

def getMatches():
    g["partialCity"] = []
    g["selectedIndex"] = 0
    thisInput = g["currentInput"].upper()

    if thisInput in g["partialDict"].keys():
        g["partialCity"] = g["partialDict"][thisInput]
    else:
        g["partialCity"] = []

    return

def getWeather():
    #### Valid Selected City.
    #### Request Weather Info
    if g['inputMode'] == 'city':
        thisCityID = str(g["cityID"][g["currentInput"]])
        #### Combine then request call with the city ID and
        response = requests.get(g["requestCall"] + thisCityID + g["apiKey"])

    if g['inputMode'] == 'zip':
        thisZip = g["currentInput"]

        #### Combine then request call with the city ID and
        response = requests.get(g["requestZip"] + thisZip + g["apiKey"])

    return response.json()

def getZipMatches():
    g["partialCity"] = []
    g["selectedIndex"] = 0

    thisInput = g["currentInput"].upper()

    if thisInput in g["partialZip"].keys():
        g["partialCity"] = g["partialZip"][thisInput]
    else:
        g["partialCity"] = []

    return

def initialize():
    def parse_orig_city_list():
        #####################################################################################
        ### This code is unused and is only for reference
        #####################################################################################
        ### Original code below to parse the original Zip code and City List files.
        ### The Parsed files, were processed into dictionaries and exported to JSON
        ### This reduced the size of the attached data files from 33md to 8mb
        ### The zip are a straight forward csv file.
        ### The city list involved more cleaning. There are regions that have the
        ### same city name but have a different geographic location. The duplicates
        ### were removed and only the first city/region was used. Since we are searching
        #####################################################################################

        ### by city name, this felt appropriate
        #for key,value in g['zipCity'].items():
        #    print(f"{key}:{value}"



        print(str(len(g["zipList"])) + " Zip Codes")

        print("Loading Artwork")
        print("--------------------------------------------------------")
        loadArtwork()

        print("Building City List")
        print("--------------------------------------------------------")
        with open("city.list.json", encoding='utf-8') as f:
            rawCity = json.load(f)

        ### Determine Longest City Name / CityID Key
        maxCityLength = -1
        thisCityLength = -1
        g["tempDict"] = {} #Build a temporary Dictionary to check for duplicates

        for x in rawCity:
            #####################################################################################
            ### Build a list of cities
            ### These Names include State and Country.
            ### In order to differentiate from same City in different state and country
            ### These are used as a key for the city ID
            ### Some value have states, some dont, if no state don't include it
            #####################################################################################
            ### Some Regions have the same name, but different geographic coordinates
            ### This leads to multiple cities with the same name that reference
            ### the same city ID. Since handling by geographic coordinates seems a bit
            ### unwieldy, duplicate city names will be removed. Only the first city
            ### in the list will be kept/
            #####################################################################################

            thisCityName = ""

            ### Build the CityName, formatting depends on Whether the entry has a state value
            ### This helps provide a unique key for city names, and
            ### And for proper formatting when displaying the cityName
            if len(x["state"]) > 0:
                thisCityName = x["name"] + ", " + x["state"] + " " + x["country"]
            else:
                thisCityName = x["name"] + " " + x["country"]

            ### TempDict holds existing city names
            ### If CityName exists, skip it. This will cut down on duplicate city names with different geographic features.
            if thisCityName not in g["tempDict"].keys():
                #print("Unique City")
                g["tempDict"][thisCityName] = True
                ### Add City Name to the City List
                g["cityList"].append(thisCityName)

                ### Add Assign cityID to the CityName in the CityID dictionary.
                g["cityID"][thisCityName] = x["id"]

                ### Detemine if this is the longest city name, this is needed for building the autocomplete dictionaries
                if len(thisCityName) > maxCityLength:
                    maxCityLength = len(thisCityName)
            #### END each rawCity



        ### Empty the tempDict because we are done with it
        del g["tempDict"]

    def parse_zip_codes():
        g["zipList"] = {}
        g['zipCity'] = {}

        with open("uszips.csv", encoding='utf-8') as f:
            for line in f:
                rawLine = f.readline()
                rawLine = rawLine.split(",")

                zipCode = rawLine[0]
                ### Prependr 4 digit zips with 0
                if len(zipCode) == 3:
                    zipCode = "00" + zipCode

                if len(zipCode) == 4:
                    zipCode = "0" + zipCode

                g["zipList"].append(zipCode)
                #### Build the city Name, County and State from fields 1-3
                #### Also Trim trailing newline Character
                cityState = f"{rawLine[1]}, {rawLine[2]} {rawLine[3][:-1]}"

                #### Build the zipCity dictionary.
                #### Key: Zip Code  Value: City Name, County, State
                g['zipCity'][zipCode] = cityState

        ### Export the City List and Zip Codes to JSON
        outputDict = json.dumps(
            {"cityList": g["cityList"], "cityID": g["cityID"], "zipList": g["zipList"], "zipCity": g['zipCity']})
        f = open("cityList_processed.json", "w")
        f.write(outputDict)
        f.close()
        #### Quit here. This code is designed to update cityList_processed.json
        quit()

    clrScreen()

    print("============================================================================================================")
    print("I went a bit overboard with this project")
    print("I did a big chunk of this project on week one. Which is why some of my coding is not very pythonic.")
    print("Big Disclaimer: This project *only* works on Windows based O/S.")
    print("This code is reliant on the MSVCRT library, which is only included on the the Windows version of Python")
    print("This library allows the capturing of keystrokes, which is critical for incorporating a reatime")
    print("autocomplete feature with unicode support (Unicode keystrokes not supported).")
    print("============================================================================================================")
    print("Building the autocomplete dictionary at runtime takes a bit of time. This involves creating a list of cities")
    print("for every possible valid keystroke combination. Using a dictionary, allows the autocomplete feature to run")
    print("very quickly. The initial version involved building the autocomplete list in realtime. It felt very laggy.")
    print("The autocomplete dictionary could be saved as a 69mb. The file size felt cumbersome, building the dictionry")
    print("at runtime feels most appropriate.")
    print("============================================================================================================")
    print("cityList_processed.json is a parsed and processed version of the official Open Weather API city.list.json")
    print("The original file is 33mb. There is commented code buried in here describing how I originally parsed the file")
    print("File obtained from http://bulk.openweathermap.org/sample/")
    print("US Zip codes obtained from SimpleMaps.com was incorporated as well.")
    print("Zip Codes Provided by Simplemaps.com")
    print("https://simplemaps.com/data/us-zips")
    print("============================================================================================================")

    ### Original Parsing Code, now obsoleted as cities are included in city_List_processed.json
    #parse_orig_city_list()

    ### Loading from Processed JSON File.
    ### Load the File to tempDict, then assign Zip, CityList and CityID to master

    with open("cityList_processed.json", encoding='utf-8') as f:
        tempDict = json.load(f)

    g["cityList"] = tempDict["cityList"]
    g["zipList"] = tempDict["zipList"]
    g["cityID"] = tempDict["cityID"]
    g['zipCity'] = tempDict["zipCity"]

    ### Original zip code parsing code, now obsoleted as zips are included in city_List_processed.json
    #parse_zip_codes()

    ### Artwork loaded from local library to make the code more readable.
    ### There is a lot of artwork over there and it feels very cluttered.
    g['art'] = wxArtwork.build_artDict()
    g["artMain"] = wxArtwork.build_artMain()
    g["artImage"] = wxArtwork.build_artImage()

    ### Max City Length is 75 characters. We determined this fixed value when checking for duplicate city names when
    ### when originally processing the cities. Building an autocomplete dictionary out to 75 characters is ridiculous and
    ### and a lil impractical when two or three dictionaries will likely suffice. But why not? Because we can, works for me.

    maxCityLength = 75

    print("--------------------------------------------------------")
    print(str(len(g["zipList"])) + " Zip Codes")
    print("City Count: " + str(len(g["cityList"])))
    print("Max City Name Length: " + str(maxCityLength))
    print("--------------------------------------------------------")

    #####################################################################################################################
    # Build Autocomplete Dictionaries
    #####################################################################################################################
    # Build Dictionary Dictionary of partial types possibilities. Because matching in real-time takes too long
    # Build up to maxCityLength Indexes
    #####################################################################################################################
    print("Building Autocomplete dictionaries")
    print("It will take a little bit\n")
    for dictIndex in range(1, maxCityLength):
        ###############################################################
        ### First Loop up to max length of city List
        ###############################################################
        for x in g["cityList"]:

            ### Only process values when the length of the key value
            ### is less than the city names.
            if dictIndex <= len(x):

                thisKey = x[:dictIndex].upper()

                #### Convert Key to uppercase
                if (thisKey in g["partialDict"].keys()):

                    g["partialDict"][thisKey].append(x)

                else:

                    g["partialDict"][thisKey] = [x]

                #### END Build Keys

            ### END Appropriate size

        cl(".")
        ### END Each City - Loop Layer 2
    ### END Build Dictionary Keys - Loop Layer 1

    #### Build Zipcode auto complete dictionaries
    for dictIndex in range(0, 6):
        ### Loop Through all zipcode
        for x in g['zipList']:

            if dictIndex <= len(x):
                thisKey = x[:dictIndex]

                if (thisKey in g["partialZip"].keys()):

                    g["partialZip"][thisKey].append(x)

                else:

                    g["partialZip"][thisKey] = [x]
    #### END Build zipcode Dictionary
    print()
    input("Press ENTER to continue")
    #####################################################################################################
    ##### We Could technically, write partialDict to a file and have it load very fast every time.
    #### But Where is the fun in that? And it's 69mb.
    #####################################################################################################
    # outputDict = json.dumps(g["partialDict"])
    # f = open("partialDict.json","w")
    # f.write(outputDict)
    # f.close()

######################################################################################################
######################################################################################################
######################################################################################################
#### MAIN Code #######################################################################################
######################################################################################################
######################################################################################################
######################################################################################################

#######################################################################################################
#### mainLoop is an infinite while loop.
#### Thank you Python for not allowing a 100% process condition on the infinite while
#######################################################################################################
### mainLoop run infintitely. Actions are performed on keystroke.
### msvcrt.kbhit() is true when any keyboard key is pressed
### msvcrt.getch() captures the keystroke as a byte array
### Key processing is handled by converting byte to int
### Only valid keys are processed, everything else is ignored
### Explicit key definitions mean only known keystrokes are handled, creates builtin error handling
### Since we are handling keystrokes, context is very important. Several variables manage the current
### context. Where we have typed a number (zip code mode) or a letter (city mode) or whether we've
### used the arrow keys.
#######################################################################################################
def main():
    def handle_arrow_keys(rawInput):
        #########################################################################################
        ### takes the second Value of an arrow keystroke and processes the action
        ### Handling Up/Down Keystrokes AND checking if the keystroke will go out of bounds.
        ### If out of bounds, ignore the keystroke.
        #########################################################################################
        if ord(rawInput) == 72 or ord(rawInput) == 80:
            g["resetText"] = True
            ##################################################
            #### Error Handling
            ##################################################
            #### Do Nothing if selectedIndex is not assigned
            ##################################################
            if g["selectedIndex"] == -1:
                return
            ##################################################
            ### If Up arrow and Index is 0, Do Nothing
            ##################################################
            if ord(rawInput) == 72 and g["selectedIndex"] == 0:
                return
            ##########################################################
            ### If Down arrow and Index is at end of list, Do Nothing
            ##########################################################
            if ord(rawInput) == 80 and g["selectedIndex"] == len(g["partialCity"]) - 1:
                return

            #### Quit if no valid cities
            if len(g["partialCity"]) == 0:
                return

            ### Up Arrow: Decrement selectedIndex
            if ord(rawInput) == 72:
                g["selectedIndex"] -= 1

            ### Down Arrow: Decrement selectedIndex
            if ord(rawInput) == 80:
                g["selectedIndex"] += 1
            ##################################################################
            ### New Selected Index is valid
            ### set currentSelection to the selectedIndex of partialCity
            ##################################################################
            g["currentInput"] = g["partialCity"][g["selectedIndex"]]
            drawScreen()
            return

    def handle_enter():
        clrScreen()

        ### Check for empty Input.
        ### Update Diagnostic message informing user to make a choice
        ### DrawScreen, return to while loop for Input
        if len(g["partialCity"]) == 0:
            g["diag"] = "Please Enter or select a City"
            drawScreen()
            return

        ###########################################################################
        ### In City Mode, Check if selection matches an Item in the Dictionary
        ### If Yes Continue, If no, Assign the Current Input to the listed
        ### Partial City.
        ###########################################################################
        if g['inputMode'] == 'city':
            #### Check if Current City e
            if not g["currentInput"] in g["cityID"].keys():
                g["currentInput"] = g["partialCity"][g["selectedIndex"]]
                drawScreen()
                return

        ###########################################################################
        ### In Zip Mode, Check if selection matches an Item in the Dictionary
        ### If Yes Continue, If no, Assign the Current Input to the listed
        ### Partial City.
        ###########################################################################
        if g['inputMode'] == 'zip':
            if not g["currentInput"] in g["zipCity"].keys():
                g["currentInput"] = g["partialCity"][g["selectedIndex"]]
                drawScreen()
                return

        ### Selected City Matches a valid City ID.
        ### Let's get the Weather
        response = getWeather()

        ### Check for valid response
        if "cod" in response.keys():

            ### Check for Response Code.
            ### If 200, We are good display the response
            if response['cod'] == 200:
                #### Show the Weather
                displayWeather(response)
                ### Empty the current input. User will start with fresh input
                g["currentInput"] = ""
                g["selectedIndex"] = -1
                g['partialCity'] = []
                return
            else:
                ### There was some problem with the response, display the error
                g['diag'] = "We are having trouble getting a valid response from open Weather.\nPlease Try Again\n" + str(response) + "\n"
                ### Empty the current input. User will start with fresh input
                g["currentInput"] = ""
                g["selectedIndex"] = -1
                g['partialCity'] = []
                drawScreen()
                return
        else:
            ### COD not found in response.
            ### No Idea What is going on, show a generic error message along with the response value.
            ### Theoretically, this should never trip. But it's a good fail safe.
            ### NEVER trust the data!
            g['diag'] = "We are having trouble getting a valid response from open Weather.\nPlease Try Again\n" + str(response) + "\n"
            ### Empty the current input. User will start with fresh input
            g["currentInput"] = ""
            g["selectedIndex"] = -1
            g['partialCity'] = []
            drawScreen()
            return
        return ### END Handle_ENTER

#######################################
###END MAIN FUNCTIONS
#######################################

    ##########################################
    #### Initialization
    ##########################################
    initialize()
    mainLoop = True
    rawInput = ""
    drawScreen()

    ###################################################################################
    #### While Loop captures keystrokes
    #### drawScreen() - calls at the end of each action.
    #### Otherwise the loop would continually redraw the screen even without input
    #### Every action is based upon Keystroke which are converted to ASCII ordinals
    ###################################################################################
    while mainLoop:
        if msvcrt.kbhit():
            rawInput = msvcrt.getch()
            g["diag"] = ""


            ### Check for weather display mode
            if g["modeState"] == "wx":
                #### We are Displaying the weather.
                #### Reset the loop to start over

                #### Reset the mode
                g["modeState"] = "main"

                ### Any key EXCEPT the ESC key
                ### ESC is handled at the ESC function
                if ord(rawInput) != 27:
                    ### Redraw the screen and continue the Loop
                    drawScreen()
                    continue

            ########################
            ### Handle ENTER Key
            ########################
            if ord(rawInput) == 13:
                handle_enter()
                continue

            ########################
            ### Handle BackSpace
            ########################
            if ord(rawInput) == 8:
                ###################################
                #### Nothing Input Do Loop again
                ###################################
                if len(g["currentInput"]) == 0:
                    g["partialCity"] = []
                    drawScreen()
                    continue

                #### Trim last character from currentInput, draw screen, reset Loop
                g["currentInput"] = g["currentInput"][0:len(g["currentInput"])-1]
                if g['inputMode'] == 'city':
                    getMatches()
                elif g['inputMode'] == 'zip':
                    getZipMatches()

                drawScreen()
                continue

            ####################
            #### Handle Escape
            ####################
            if ord(rawInput) == 27:
                clrScreen()
                #### Quit here gracefully by closing the mainLoop
                mainLoop = False
                continue

            #####################################################################################################
            ### Handle Arrows
            ### Arrows are a two Byte sequence:
            ### the First msvcrt.getch() = 224, this indicates an arrow
            ### The Second indicates the direction. This sequence must be captured before standard key handler
            ### otherwise 72,80,75,77 show up as text
            #####################################################################################################
            ### UpArrow 72 downArrow 80 leftArrow = 75 rightArrow = 77
            #####################################################################################################
            if ord(rawInput) == 224:


                ### Arrow detected, grab next Character and pass to handle_Arrow_keys
                handle_arrow_keys(msvcrt.getch())
                continue ### Does nothing if Left and Right arrows pressed
            #### END handle Arrows


            #numbers 48-57
            #LeftArrow 22475
            #UpArrow 22472
            #downArrow 22480
            #rightArrow 22477
            #####################################################################################################
            ### Handle Valid Text
            ### This is a-z A-Z , (comma) and space
            #####################################################################################################
            ### Uppercase 65-90 LowerCase 97-122 Space Bar 32 Comma 44
            #####################################################################################################
            if 97 <= ord(rawInput) <= 122 or 65 <= ord(rawInput) <= 90 or ord(rawInput) == 32 or ord(rawInput) == 44:
                ############################################################
                #### Clear current input on text after up/Down Arrow
                ############################################################
                if g["resetText"] == True:
                    g["resetText"] = False
                    g["currentInput"] = ""

                ############################################################
                #### Clear current input if in Zip Mode
                ############################################################
                if g['inputMode'] == 'zip':
                    g["resetText"] = False
                    g["currentInput"] = ""

                ### We are in text/city mode
                g['inputMode'] = 'city'

                ##############################
                ##### Decode Text ############
                ##############################
                g["currentInput"] += rawInput.decode('utf-8')

                #### Build List of Cities that match the currently typed text
                getMatches()

                drawScreen()
                continue

            #####################################################################################################
            ### Handle Valid number key
            ### This is 0-9
            ### 0 = 48
            ### 9 = 57
            #####################################################################################################
            if 48 <= ord(rawInput) <= 57:
                ############################################################
                #### Clear current input on text after up/Down Arrow
                ############################################################
                if g["resetText"] == True:
                    g["resetText"] = False
                    g["currentInput"] = ""

                ############################################################
                #### Clear current input if in City Mode
                ############################################################
                if g['inputMode'] == 'city':
                    g["resetText"] = False
                    g["currentInput"] = ""


                ### We are in zipcode mode
                g['inputMode'] = 'zip'

                ##################################################
                ##### Max Zip Length is 5 characters.
                ##### Do not accept input if we already
                ##### have 5 characters
                ##################################################
                if len(g["currentInput"]) == 5:
                    continue

                ##############################
                ##### Decode Text ############
                ##############################
                g["currentInput"] += rawInput.decode('utf-8')

                #### Build List of Cities that match the currently typed zip code
                getZipMatches()

                drawScreen()
                continue

            #### END handle Keys

            ########################################################################
            ########################################################################
            ##### END mainLoop #####################################################
            ########################################################################
            ########################################################################

    print("Thank you for Checking the forecast")
    print("Unless you are an astronaut, we are all under the weather.")
if __name__ == "__main__":
    main()
