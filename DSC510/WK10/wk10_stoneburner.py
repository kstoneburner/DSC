"""
                       ▗▄▄▄▄▄▄▄▟▄▄▄▄▄▄
                     ▐██████████████████▙▄▄
                     ███████████████████████▄
                    ▐████████████████████████▌
                    ██████████████████████████
                   ▐██████████████████████████▌
                   ███████████████████████████▌
                  ▗███████████████████████████▀
                  ▟███████████████████████████████████▄▄▖
                 ▐████████████████████████████████████████▄
    ▄            ▟██████████████████████████████████████████▖
    ▝▙▄▄        ▄▟▄▄▟███████████▀▀▀▀▀▀▀▀▀▜███████████████████
      ▀███████████████▖▀▛▘▀▀▀▐███         ▝▙▄▟███████████████
        ▝▀▜███████████▙     ▀███▛▀        ▗▛████████████████▛
           ▝▀▜████ ▟█▜▜▄    ██▀▀▀▀▚       ▐███████▙▄▝▀██████
               ▝▀█▖▘    ▘▛   ▝            ▐█▀▜██████▌  ▝███▘
                  ▘                        ▌   ▝██████▄▄▞▀
                       ▌▝▀                 ▘▌▝ ▟███████▛▀
                   ▘   ▗     ▄▘▘▖          ▝  ▗███▀▜███▛▘
                      ▗▄▟██████▄▟▄         ▖ ▄████▙
                   ▗▗███████▀▀▀▀▘▝▌        ▝▜████▖▀▚▖
                   ▝███▙▖▄▄▄▖  ▝▘▄█         ▐███▀▀▘
                    ▜██▖          █         ▟███▖
                     ▜██████▄▄▄▄▄▖▀         ▟█▛▜▙
                      ▜████████▙           ▗███▙▄
                       ▜█████▖▄    ▄▀▄  ▗▄▟███████▖
                   ▗▟█▘█▄▛▜▜██▙███▙▟███████████████▙
                 ▗███▛ ▜███▙▄▄ ▐████████████████████▙▄▄▄
  ▗▄▄▄▄▄▄▄███▛▀▗▄████▌▗▙█████████████████████████████████▄
  ▐█▀  ▄▄██▛▀▗▟██████▙████████████████████████████████████▙▖
   ▐ ▐██▌     ██████████████████████████████████████████████
   ▝ ▝▀▀▘     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
   ________               __      _   __                _
  / ____/ /_  __  _______/ /__   / | / /___  __________(_)____
 / /   / __ \/ / / / ___/ //_/  /  |/ / __ \/ ___/ ___/ / ___/
/ /___/ / / / /_/ / /__/ ,<    / /|  / /_/ / /  / /  / (__  )
\____/_/ /_/\__,_/\___/_/|_|  /_/ |_/\____/_/  /_/  /_/____/
              is the header file standard
"""
####################################################################################################
####################################################################################################
####################################################################################################
### DSC 510
### Week 10
### Programming Assignment Week 9
### Author: Kurt Stoneburner
### 2020/05/11
### Program Purpose:
##################### To retrieve words of Wisdom from chuckNorris.io
####################################################################################################
####################################################################################################
####################################################################################################


try:
    import requests
except:
    print("=========================================================================================================================================")
    print("You need to install the Requests library!")
    print("=========================================================================================================================================")

import os
import json
import time


### Global dictionary
g = {
    'url' : "https://api.chucknorris.io/jokes/random",
    "basic_chuck" : "",
    "chuck_flame1" : "",
    "chuck_flame2" : "",
    "os" : "OTHER",

}

def clrscreen():
    ### Clears the screen using OS commands for WINDOWS & LINUX
    ### OTHER OS gets no Print Screen
    ### This is a fail safe methodology

    if g['os'] == 'WINDOWS':
        os.system("cls")
    elif g['os'] == "LINUX":
        os.system("clear")

    ###Do nothing for OTHER OS

def detectOS():
    #### Detect OS. Check for WINDOWS OS. Assume other OS is LINUX.
    #### Run Clear Screen command. If it returns FALSE, then correct OS identified.
    #### Tested on WINDOWS
    #### responses are WINDOWS, LINUX, OTHER

    ### Check for Mondern Windows Install
    if os.name == "nt":
        ### Windows Machine
        if bool(os.system("cls")) == False:
        ### False means we are in Windows
            return "WINDOWS"
    else:
        ### Presume Linux or Mac
        if bool(os.system("clear")) == False:
        ### False means we are in LINUX / MAC
            return "LINUX"

    #### Not sure what OS we are dealing with. We'll use generic print commands
    return "OTHER"

def errorMsg(r):
    ### Handle errormessages when handling chucks wisdom from the remote API.
    ### Failure and shame is heaped on the user, for Chuck is perfection incarnate.
    ### We did not get a valid response. Blame the user and quit
    print("There is a problem receiving the Wisdom")
    print("The error is YOUR fault! Chuck is Wise and Divine,")
    print("--------------------------------------------------")
    print(f"{r}")
    print(f"Status Code: {r.status_code}")
    print(f"Headers: {r.headers}")
    print(f"Text: {r.text}")
    return
    #### This Will exit the program here


def initGFX():
    ########################################################
    ### I merged two pieces of ASCII art to make this.
    ### It was slim ASCII pickings for Chuck Norris
    ########################################################
    g['basic_chuck'] += "___________                                                               __\n"
    g['basic_chuck'] += "           ~~~~~~~~~~-------......_______                         __..--''  \\\n"
    g['basic_chuck'] += "                                         ~~~---...________.---'~~~           `.\n"
    g['basic_chuck'] += "   ________               __      _   __                _                      \\\n"
    g['basic_chuck'] += "  / ____/ /_  __  _______/ /__   / | / /___  __________(_)____         __/      `.\n"
    g['basic_chuck'] += " / /   / __ \/ / / / ___/ //_/  /  |/ / __ \/ ___/ ___/ / ___/      .-' \ `-.     \\\n"
    g['basic_chuck'] += "/ /___/ / / / /_/ / /__/ ,<    / /|  / /_/ / /  / /  / (__  )   .  /\   /  / /    /\n"
    g['basic_chuck'] += "\____/_/ /_/\__,_/\___/_/|_|  /_/ |_/\____/_/  /_/  /_/____/     `/ /  /  /.~    /\n"
    g['basic_chuck'] += "                                                                   `-.______.-----.\n"
    g['basic_chuck'] += "`--------------------------------.........._________                           |~~ `.\n"
    g['basic_chuck'] += "                                                    ~~--.._                    |___))\n"
    g['basic_chuck'] += "                                                           ~--._____________.------'\n"

    #### These are used for an animated flame effect
    g['chuck_flame1'] += "   (       )                          )\n"
    g['chuck_flame1'] += "   )\    ( /(                 )    ( /(     )    * \n"
    g['chuck_flame1'] += " (((_)   )\())         (   ( /(   ((_))\ ( /(  (  `     (      \n"
    g['chuck_flame1'] += " )\_____((_)\    (     )\ _)\())  (_()(_))\()) )\))(    )\    )    \n"
    g['chuck_flame1'] += "((/ ____| |()(   )\  (((_) (_)\   | \ | |(_)\ ((_)()\  ((_)  /(    \n"
    g['chuck_flame1'] += " | |    | ((_) _ ((_))\__| |((_)  |  \| | ((_)(_()((_)__ _ _(_)) \n"
    g['chuck_flame1'] += " | |    | '_ \| | | |/ __| |/ /   | . ` |/ _ \| '__| '__| / __/(\n"
    g['chuck_flame1'] += " | |____| | | | |_| | (__|   <    | |\  | (_) | |  | |  | \__ \))\n"
    g['chuck_flame1'] += "  \_____|_| |_|\__,_|\___|_|\_\   |_| \_|\___/|_|  |_|  |_|___/\n"

    g['chuck_flame2'] += "     )       (                          (\n"
    g['chuck_flame2'] += "   (/    ) \)                 (    ) \)     )   *\n"
    g['chuck_flame2'] += " )))_(   (\)((         )   ) \)   ))_((\ ) \)  ) ´      )\n"
    g['chuck_flame2'] += " (/_____))_(/    )     (/ _(/)((  )_)()_((/)(( (/(()    (/    (\n"
    g['chuck_flame2'] += "))\ ____| |)()   )/  )))_( )_(/   | \ | |)_(/ ))_()(/  ))_(  \)\n"
    g['chuck_flame2'] += " | |    | ))_(   ))_((/__| |))_(  |  \| | ))_()_)())_(__ _ _)_((\n"
    g['chuck_flame2'] += " | |    | '_ \| | | |/ __| |/ /   | . ` |/ _ \| '__| '__| / __/)\n"
    g['chuck_flame2'] += " | |____| | | | |_| | (__|   <    | |\  | (_) | |  | |  | \__ \((\n"
    g['chuck_flame2'] += "  \_____|_| |_|\__,_|\___|_|\_\   |_| \_|\___/|_|  |_|  |_|___/   \n"


def receive_wisdom_of_chuck():
    ### Clear Screen (if applicable)
    clrscreen()
    ### Print welcoming message, while wisdom is retrieved
    print("prepare yourself, for the Wisdom of Chuck")

    ### Requesting Wisdom
    r = requests.get(g['url'])

    ### Any response other than 200 is met with failure and shame.
    ### Blame the User and quit.
    if r.status_code != 200:
        errorMsg(r)
        return

    ### Convert Response to Dictionary
    r_dict = r.json()

    ### Validate there is a Value Key in r_dict
    ### If not Blame the User and quit
    if "value" not in r_dict.keys():
        errorMsg(r)
        return
    ### Add a Trailing space and split Chuck's wisdom into a word list of wisdom.
    ### Splitting the list allows Newlines to be inserted for nicer formatting
    ### Chuck is not concerned with your formatting failures.
    r_dict['value'] = r_dict['value'] + " "
    word_list = r_dict['value'].split(" ")

    #### if OTHER OS. skip the animation
    #### Most Compatible Mode. Simply displays the flame art and formatted wisdom.
    if g['os'] == 'OTHER':
        ### Static Display
        print(g['chuck_flame1'])
        print()
        chucks_message = ""
        #### Loop through each word
        for word in word_list:
            ### Compile each word into chucks message
            chucks_message += word + " "
            ### Check the length of the message.
            ### Split Message by newline, and check the length of the last line
            checkLen = chucks_message.split("\n")[-1]
            ### If the last line is longer than 60 characters, add a new line.
            if len(checkLen) > 60:
                chucks_message += "\n"

        ### Display Wisdom
        print(chucks_message)
    else:
        ### Animated Display
        chucks_message = ""
        #### There are two sections here:
        ### 1. animated flicker which alternated between chuck_flame1 and chuck_flame2
        ### 2. After the flicker, One word is added to the wisdom.
        ### Cycle repeats, flicker...add word.
        ### The flicker represents a basic animation and delay between each word.
        ### Very simple

        #### Loop through each Word
        for word in word_list:

            #### Draw the flickering flame animation twice, with the displayMessage
            for x in range(2):
                clrscreen()
                displayMessage = ""
                if x % 2 == 1:
                    displayMessage += (g['chuck_flame1'])
                else:
                    displayMessage += (g['chuck_flame2'])
                displayMessage += f"\n{chucks_message}\n"
                print(displayMessage)

                ### Some messages are longer than a line.
                ### Split the current Message by Newline, and get the last line
                ### This represents the current line of text.
                ### If this line is greater than 60, add a newline character
                checkLen = chucks_message.split("\n")[-1]
                if len(checkLen) > 60:
                    chucks_message += "\n"

                time.sleep(.1)
            ### END Flicker Loop


            ### Word added to Chucks Message last.
            ### This allows an initial flicker cycle before display.
            chucks_message += word + " "

        #A Little closing animation Flicker
        for x in range(10):
            clrscreen()
            displayMessage = ""
            if x % 2 == 1:
                displayMessage += (g['chuck_flame1'])
            else:
                displayMessage += (g['chuck_flame2'])
            displayMessage += f"\n{chucks_message}\n"
            print(displayMessage)
            time.sleep(.1)

    ### END Animation Display
    print("\n\n\n")
    print("Would you like more wisdom from the Master?")
    ### Ask user to continue
    if 'n' in input("[Y] / n : ").lower():
        ## An n anywhere in the response indicates a quit
        return
    ### Recurse until Quit!!!
    receive_wisdom_of_chuck()

def welcomeMessage():
    print("***************************************")
    print("* Are you prepared for the Wisdom of: *")
    print("***************************************")
    print( g['basic_chuck'])

    ### If Unable to detect OS. Default to basic display
    if g['os'] == 'OTHER':
        ### If n is anywhere in input return False to QUIT. Otherwise we are True for Wisdom
        if 'n' in input("[Y] / N ? ").lower():
            return False
        return True
    else:
        print("\n\n")
        print(f"A {g['os']} based operating system has been detected.\n")
        print("You can receive Chuck's Wisdom via:\n")
        print("(A) - Animated Mode. Must be run from the command line.")
        print("(B) - Basic Mode\n")
        print("If unsure, be (B)asic.\n")
        ###  Get User response.
        user = input("A / [B] ? ").lower()

        ### If user types an A or a in any part of the response, and Not 'b'. Just in case they typed BASIC.
        ### Then continue in animated mode.
        ### Otherwise default to basic mode.
        if 'a' in user and 'b' not in user:
            return True
        else:
            #### Force Basic Mode
            g['os'] = "OTHER"
            return True

def main():
    ### Determine if OS is WINDOWS, LINUX or OTHER
    ### WINDOWS and LINUX get animation. OTHER gets basic.
    g['os'] = detectOS()
    clrscreen()
    ### Load the ASCII art
    initGFX()
    ### Display welcome message
    ### There is one scenario that permits user to quit early.
    ### Hence the if statement
    if welcomeMessage():
        receive_wisdom_of_chuck()


if __name__ == "__main__":
    main()
