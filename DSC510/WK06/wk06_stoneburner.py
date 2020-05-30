####################################################################################################
####################################################################################################
####################################################################################################
#### course: DSC510
#### assignment: 6.1
#### date: 04/13/20
#### name: Kurt Stoneburner
#### Program Purpose: A very simple calculator
##################### The User can choose an operation: add, subtract, multiply, divide
##################### or Average
####################################################################################################
####################################################################################################
####################################################################################################
#### Functions: ordered alphabetically, except main which is last
####################################################################################################
#### clrScreen() - Clear Screen by writing a bunch of NEWLINEs
####################################################################################################
#### exit_gracefully() - Display a nicely formatted goodbye message before quitting
####################################################################################################
#### Process temperatures - Print Highest, lowest, and count of temps. Wait for ENTER to continue
####################################################################################################
#### Sanitize String - Cleans up user input. Converts illegal characters into valid numbers
####################################################################################################
#### main - main program loop
####################################################################################################
##print("�")
##print(str(ord("�")))

### Global Dictionary:
g = {
    'temperatures' : [],
    'welcome_message' : "",
}
g['welcome_message'] += "********************************************************************************\n"
g['welcome_message'] += "*** Please enter some temperatures. As many you'd like.                      ***\n"
g['welcome_message'] += "*** 1. All Input is accepted                                                 ***\n"
g['welcome_message'] += "*** 2. Only WHOLE and DECIMAL numbers are calculated                         ***\n"
g['welcome_message'] += "*** 3. Any input that is not a number, will be converted to a number for you ***\n"
g['welcome_message'] += "*** 4. You may input multiple values separated by a comma (,)                ***\n"
g['welcome_message'] += "********************************************************************************\n"


def clrScreen():
    ### Clear the screen with some NEWLINEs
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    return ### <-- Not technically needed, but it's weird not ending a function with a return.

def exit_gracefully():
    clrScreen()
    print(
        "*******************************************************\n"
        "*** Thank you for having your temperatures checked. ***\n"
        "*******************************************************\n\n\n\n\n\n"
    )

def process_temperatures():
    ### Check for empty list
    if len(g['temperatures']) == 0:
        #### We are empty, not exactly sure why, but we are quitting for safety!
        return

    ### Initialize Max/Min Values
    thisTemp_max = g['temperatures'][0]
    thisTemp_min = g['temperatures'][0]
    thisTemp_count = len(g['temperatures'])

    ### We could use a range loop, and skip the first val, because we already initialized the first value
    ### I prefer using pythonic methods when I can, even at aminor cost in efficiency.
    for temp in g['temperatures']:

        if temp > thisTemp_max:
            thisTemp_max = temp

        if temp < thisTemp_min:
            thisTemp_min = temp

    #### Display the Results
    clrScreen()
    results = ""
    results += "*"
    results += " Max Temperature: " + str(thisTemp_max) + " * "
    results += " Min Temperature: " + str(thisTemp_min) + " * "
    results += " Number of Temperatures: " + str(thisTemp_count) + " *"

    filler_Line = ""
    for i in range(0,len(results)):
        filler_Line += "*"

    results = filler_Line + "\n" + results + "\n" + filler_Line + "\n\n\n\n\n"

    print(results)

    #### Empty temperatures, or we'll have an INFINITE loop
    g['temperatures'] = []
    input("ENTER to continue >")

def sanitize_string(input):

    def isDecimal(input):
        #### Return true if period is in input String
        if "." in input:
            return True
        return False

    def make_it_an_int(input):
        ### Convert chr to an Ordinal as a string. If that fails return empty string
        try:
            return str(ord(input))
        except:
            return ""

    ### Check if empty. Stop here if yes
    if len(input) == 0:
        return input

    isNegative = False

    ## Check if First Value is a minus symbol, assume it's a negative number
    if input[0] == "-":
        isNegative = True
        ### Strip minus sign. We'll add it in later
        ### Any other minues symbols will be converted
        input = input[1:]

    clean_string = ""
    decimal_found = False
    ### Check if each character is a number
    for i in input:

        ### Check for decimal point
        if isDecimal(i):
            ### Is a decimal, check if we've already found one before
            if decimal_found == False:
                ### First Time we've found a decimal. We're FLOATING this puppy, add it to the string
                ### Make sure we only add one decimal
                decimal_found = True
                clean_string += i
                continue  ### Back to user_input We are done with this character
            else:
                ### Well Well Well. This is not the first decimal to be entered.
                ### perform a convenience conversion
                clean_string += make_it_an_int(i)
                continue  ### Back to user_input Loop
            ### END Decimal found
        else:
            ### IS NOT a decimal
            try:
                ### This Works if it's a number
                ### Holy Double Type conversion Batman!!!!
                ### Converting A string to and Integer back a string?!?!?
                ### There has to be a better way.
                ### I'm sure there is. But this is MY WAY muwhahahahahaha
                i = str(int(i))
            except:
                ### uh oh not a string
                ### Lets convert it
                i = make_it_an_int(i)
            finally:
                ### by Hook or by crook, we have a valid string
                ### If user entered a number, it gets added back in
                ### If user entered a non-number, make it a number for them
                clean_string += i
    ### END user_input
    if isNegative:
        clean_string = "-" + clean_string
    return clean_string

def main():
    clrScreen()
    print(g['welcome_message'])
    print(g['temperatures'])
    print("\n\n")
    ### NO Temperatures entered. QUIT HERE
    if len(g['temperatures']) == 0:
        ### Ask for input, sanitize it, assign it to user_input
        user_input = input("ENTER to quit : Type a Temperature> ")
    else:
        user_input = input("ENTER to Compute : Type a Temperature> ")

    ### Check for ENTER
    if len(user_input) == 0:
        ### User Pressed ENTER.
        ### Choice: QUIT or PROCESS TEMPS

        ### NO Temperatures entered. QUIT HERE
        if len(g['temperatures']) == 0:
            exit_gracefully()
            return ### Technically unnecessary, since loop ends. But this is good form in case the
                   ### program scope expands
        else:
            process_temperatures() ##<---Build This
            main()
            return ### Technically unnecessary, since loop ends. But this is good form in case the
                   ### program scope expands
    else:
        #### Split by commas. This way we can catch multiple values on one line.
        for i in user_input.split(","):
            ### Sanitize the Input, return a String
            i = sanitize_string(i)
            #### Only add values that have length. This ignores multiple Empty Commas
            if len(i) > 0:
                g['temperatures'].append(int(i))
        main()
### END Program if we missed something

if __name__ == "__main__":
    main()
