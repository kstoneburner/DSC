####################################################################################################
####################################################################################################
####################################################################################################
#### course: DSC510
#### assignment: 5.1
#### date: 04/06/20
#### name: Kurt Stoneburner
#### Program Purpose: A very simple calculator
##################### The User can choose an operation: add, subtract, multiply, divide
##################### or Average
####################################################################################################
####################################################################################################
####################################################################################################
#### Functions: ordered alphabetically, except main which is last
####################################################################################################
#### calculateAverage()
####################################################################################################
#### clrScreen() - Clear Screen by writing a bunch of NEWLINEs
####################################################################################################
#### exitGracefully() - Display closing message and quit the program
####################################################################################################
#### get_int_from_str(input_string) - returns an integer from a string. returns -1 on error
####################################################################################################
#### handle_invalid_input(input_context) - Handles invalid input based upon the context
####################################################################################################
#### performCalculation(input_action) - prompts user for input, then performs an operation based on
####################################################################################################
#### quit_on_q() - Check if user has entered a Q in string. If yes, exit gracefully
#####################################   input_action: add, sub, mult, div
####################################################################################################
#### main - main program loop
####################################################################################################

### Global Dictionary: Primarily holds artwork, and the main while Loop Boolean
g = {
    "artwork" : "",
    "artwork_addition" : "",
    "artwork_subtraction" : "",
    "artwork_multiplication" : "",
    "artwork_division" : "",
    "artwork_average" : "",
    "main_loop" : True,
}
def calculateAverage():
    clrScreen()
    print(g['artwork_average'])
    print("How many numbers would you like to average?")
    total_number = input("Q to quit - how Many? ")

    if quit_on_q(total_number):
        g['main_loop'] = False
        return

    total_number = get_int_from_str(total_number)

    if total_number < 0:
        handle_invalid_input("average") ### Display Error message and restart
        return ### quit here

    #################################################
    ### 0 or 1 gets sent back to the main loop.
    ### Not going to deal with those losers
    #################################################
    if total_number < 2:
        return


    display_numbers = ""
    running_total = 0
    running_average = 0
    ### Total number is an int > 2 by this point
    ### Thanks to Jason Ismail for the dicussion that for range loops, stop at one less than the target
    ### Hence the total_number+1
    for x in range(1,total_number+1):
        answer = input("Q to quit: Number: " + str(x) + "/" + str(total_number) + " Total: " + str(running_total) + " avg: " + str(running_average)+ "> ")

        ### Check for q and Quit
        if quit_on_q(answer):
            g['main_loop'] = False
            return

        answer = get_int_from_str(answer)

        ### Check for invalid Input
        if answer == -1:
            handle_invalid_input("average")  ### Display Error message and restart
            return

        running_total += answer
        display_numbers += str(answer) + " + "
        running_average = running_total / x

    ### Print Results
    clrScreen()
    print(g['artwork_average'])
    ### Display all the numbers entered. Trim the last 2 characters which are ' +'

    print( "(" + display_numbers[:-3] + ") / " + str(total_number) )
    print( str(running_total) + " / "+ str(total_number) )
    outLine = ""

    ### Yeah it's a bit sloopy and hard to read. But this coder is running out of gas.
    ### Make a dash line as long as the display number line
    for x in range(0,len("(" + display_numbers[:-2] + ") / " + str(total_number))):
        outLine += "-"
    print(outLine)
    print("Average: " + str(running_total/total_number) + "\n\n\n")


    if quit_on_q( input("Q to Quit - ENTER to continue > ") ):
        g['main_loop'] = False


    return ### <-- Not technically needed, but it's weird not ending a function with a return.

def clrScreen():
    ### Clear the screen with some NEWLINEs
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    return ### <-- Not technically needed, but it's weird not ending a function with a return.

def exitGracefully():
    #### Display thank you kindly
    clrScreen()
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    print("$ Thank you for using Math Time Calculator $")
    print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
    print("\n\n\n")
    #### I'd like to Exit gracefully here
    #### quit()
    #### But that's not the instruction
    ### END exitGracefully

def get_int_from_str(input_string):
    ### Returns an integer version of the string
    ### -1 if int conversion fails

    ### Let's bolt on float support
    ### While still a string check for a decimal point or period

    if input_string.find(".") > -1:
        #### Period or decimal found, assume its either a float or bad input
        try:
            return float(input_string)
        except:
            return -1

    try:
        return int(input_string)
    except:
        return -1

def handle_invalid_input(input_context):
    #### Handle invalid input based upon the context
    #### Main - display error message and give option to quit or restart main
    #### Returns True / False based on Quit_on_q
    clrScreen()

    if input_context == "main":
        print("==============================")
        print("Only 1 - 5 or Q are accepted.")
        print("==============================")
        print("\n\n\n")
        return quit_on_q(input("Type: Q or ENTER to continue> "))

    elif input_context == "add" or input_context == "sub" or input_context == "mult" or input_context == "div" or input_context == "average":
        print("===========================")
        print("Only numbers are accepted.")
        print("==========================")
        print("\n\n\n")

        #### Quit on Q
        if quit_on_q(input("Type: Q or ENTER to continue> ")):
            g['main_loop'] = False
            return
        ### For average, restart the average function
        if input_context == "average":
            calculateAverage()
            return
        ### Everyone else, perform calculation
        performCalculation(input_context)
        return


    else:
        ### Display rude error message and quit
        print("Uh oh, problem with function: handle_invalid_input() ")
        print("Unhandled input_context: " + str(input_context))
        print("Looks like some A**hole forgot to call the function properly")
        print("Time to blame the CODER!")
        quit()



#### END handle_invalid_input

def performCalculation(input_action):
    ### Input action: add, sub, mult, div - This determines the calculation to perform

    clrScreen()

    display_operator = "" ### The Operator for displaying the results all Pretty like
    if input_action == "add":
        print(g['artwork_addition'])
        display_operator = "+"

    elif input_action == "sub":
        print(g['artwork_subtraction'])
        display_operator = "-"

    elif input_action == "mult":
        print(g['artwork_multiplication'])
        display_operator = "\u00D7"

    elif input_action == "div":
        print(g['artwork_division'])
        display_operator = "\u00F7"

    first_number = input("Q or Number #1 > ")
    ### Quit if user entered Q
    if quit_on_q(first_number):
        g['main_loop'] = False
        return

    ### convert string to int, -1 indicates invalid number
    first_number = get_int_from_str(first_number)

    if first_number == -1:
        ### non-integer detected, display error message and restart function
        handle_invalid_input(input_action)
        return

    second_number = input("Q or Number #2 > ")
    ### Quit if user entered Q
    if quit_on_q(second_number):
        g['main_loop'] = False
        return

    ### convert string to int, -1 indicates invalid number
    second_number = get_int_from_str(second_number)

    if second_number == -1:
        ### non-integer detected, display error message and restart function
        handle_invalid_input(input_action)
        return

    answer = -1
    if input_action == "add":
        answer = first_number + second_number

    elif input_action == "sub":
        answer = first_number - second_number

    elif input_action == "mult":
        answer = first_number * second_number

    elif input_action == "div":
        ### You cannot Divide by 0!!! any more than you can find the square root of -1
        ### I'll defer to Hobson's choice and give a 0
        if second_number == 0:
            answer = 0
        else:
            answer = first_number / second_number


    ##########################################
    ### Let's make a purdy display
    ##########################################
    clrScreen()

    ### Display the artwork Action
    if input_action == "add":
        print(g['artwork_addition'])

    elif input_action == "sub":
        print(g['artwork_subtraction'])

    elif input_action == "mult":
        print(g['artwork_multiplication'])

    elif input_action == "div":
        print(g['artwork_division'])

    ### Draw the answer like we are in grade school
    #### Convert all Answers to Strings
    first_number = str(first_number)
    second_number = str(second_number)
    answer = str(answer)

    ### First we need to get the width of the biggest number, by string size
    max_length = len(first_number)

    if max_length < len(second_number):
        max_length = len(second_number)

    if max_length < len(answer):
        max_length = len(answer)

    #### max_length becomes our fixed width for display
    #### Make room for the display_operator and white space
    max_length += 2

    #### filler and filler counter are used to build the fixed width fields. Essentially we are padding with spaces
    filler = " "
    filler_counter = 0

    filler_counter = max_length - len(first_number)

    thisLine = ""
    #### Add spaces based on the filler_counter
    for x in range(0,filler_counter):
        thisLine += filler

    print(thisLine + first_number)

    ### Subtract 2 since we will add in the display_operator
    filler_counter = max_length - len(second_number) -2

    thisLine = ""
    for x in range(0, filler_counter):
        thisLine += filler

    print(filler + display_operator + thisLine + second_number)

    ### Print ------ Line equal to max_length
    thisLine = ""
    for x in range(0, max_length):
        thisLine += "\u035E"
    print(thisLine)

    thisLine = ""
    filler_counter = max_length - len(answer)
    for x in range(0, filler_counter):
        thisLine += filler

    print(thisLine + answer + "\n\n\n\n\n")

    if quit_on_q( input("Q to Quit - ENTER to continue > ") ):
        g['main_loop'] = False

    return ### <-- Not technically needed, but it's weird not ending a function with a return.

def quit_on_q(input_string):

    #### Search for q if anywhere in string
    #### Convert to lowercase
    #### -1 means no Q, return input_string

    if (input_string.lower().find("q")) == -1:
        return False

    ### Q Found, Quit Gracefully
    return True

def main():

    while g['main_loop']:

        ### Clear the screen with some NEWLINEs
        clrScreen()

        ### Print the welcome message
        print(g['artwork'])

        ### Get User Input
        main_operation = input("Q, 1 - 5 > ")

        ### Check for quit: returns True if q is found in main_operation

        if quit_on_q(main_operation):
            ### Q Found, set us to quit
            g['main_loop'] = False
            continue

        ### get_int_from_str returns an integer from input.
        ### -1 indicates bad input
        main_operation = get_int_from_str(main_operation)
        

        if main_operation == -1:
            ### main_operation is -1 user did not enter an integer
            if handle_invalid_input("main"): ### Display error message. restart or quit
                ### Q Found, set us to quit
                g['main_loop'] = False
            continue ### Restarting Loop regardless of response

        else:
            ### Valid responses are integers 1,2,3,4,5
            ### Anything else, gets a polite error message
            if main_operation == 1:
                performCalculation("add")
            elif main_operation == 2:
                performCalculation("sub")
            elif main_operation == 3:
                performCalculation("mult")
            elif main_operation == 4:
                performCalculation("div")
            elif main_operation == 5:
                calculateAverage()
            else:
                if handle_invalid_input("main"):  ### Display error message. restart or quit
                    ### Q Found, set us to quit
                    g['main_loop'] = False
                continue ### <-- This is likely the end of the loop. We are guaranteeing that it remains so
        ### END else - User entered integer
    #############################################################################
    ### END While MainLoop
    #############################################################################
    exitGracefully()

### END main

##################################
### Begin AutoRun Code
##################################
### Load Artwork
##################################
g['artwork'] += "**************************************\n"
g['artwork'] += "*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*\n"
g['artwork'] += "*$****************************$$$$$$$*\n"
g['artwork'] += "*$* ╔╦╗┌─┐┌┬┐┬ ┬  ╔╦╗┬┌┬┐┌─┐ *$$$$$$$*\n"
g['artwork'] += "*$* ║║║├─┤ │ ├─┤   ║ ││││├┤  *$$$$$$$*\n"
g['artwork'] += "*$* ╩ ╩┴ ┴ ┴ ┴ ┴   ╩ ┴┴ ┴└─┘ *******$*\n"
g['artwork'] += "*$* ╔═╗┌─┐┬  ┌─┐┬ ┬┬  ┌─┐┌┬┐┌─┐┬─┐ *$*\n"
g['artwork'] += "*$* ║  ├─┤│  │  │ ││  ├─┤ │ │ │├┬┘ *$*\n"
g['artwork'] += "*$* ╚═╝┴ ┴┴─┘└─┘└─┘┴─┘┴ ┴ ┴ └─┘┴└─ *$*\n"
g['artwork'] += "*$**********************************$*\n"
g['artwork'] += "*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*\n"
g['artwork'] += "**************************************\n"
g['artwork'] += "Choose a mathematical operation:\n"
g['artwork'] += "1) Addition\n"
g['artwork'] += "2) Subtraction\n"
g['artwork'] += "3) Multplication\n"
g['artwork'] += "4) Division\n"
g['artwork'] += "5) Average Some Numbers\n"
g['artwork'] += "*********************************************\n"
g['artwork'] += "Please type a number: 1 - 5 and press ENTER *\n"
g['artwork'] += "                      Q - exit the program  *\n"
g['artwork'] += "*********************************************\n"

g['artwork_addition'] += "************************************************************************************************************\n"
g['artwork_addition'] += "* ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄        ▄   *\n"
g['artwork_addition'] += "* ▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░▌      ▐░▌ *\n"
g['artwork_addition'] += "* ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌░▌     ▐░▌ *\n"
g['artwork_addition'] += "* ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌▐░▌    ▐░▌ *\n"
g['artwork_addition'] += "* ▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌ ▐░▌   ▐░▌ *\n"
g['artwork_addition'] += "* ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌  ▐░▌  ▐░▌ *\n"
g['artwork_addition'] += "* ▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌   ▐░▌ ▐░▌ *\n"
g['artwork_addition'] += "* ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌          ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌ *\n"
g['artwork_addition'] += "* ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄      ▐░▌      ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░▌     ▐░▐░▌ *\n"
g['artwork_addition'] += "* ▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌      ▐░░▌ *\n"
g['artwork_addition'] += "* ▀         ▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀       ▀       ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀        ▀▀   *\n"
g['artwork_addition'] += "************************************************************************************************************\n"
g['artwork_addition'] += "\n\n\n"
g['artwork_addition'] += "Let's add two numbers.\n\n"

g['artwork_subtraction'] += "************************************************************************************************************\n"
g['artwork_subtraction'] += "*  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_subtraction'] += "* ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ *\n"
g['artwork_subtraction'] += "* ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀  ▀▀▀▀█░█▀▀▀▀  *\n"
g['artwork_subtraction'] += "* ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌     ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌      *\n"
g['artwork_subtraction'] += "* ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌     ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌               ▐░▌      *\n"
g['artwork_subtraction'] += "* ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░▌      ▐░▌     ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌               ▐░▌      *\n"
g['artwork_subtraction'] += "*  ▀▀▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌      ▐░▌     ▐░█▀▀▀▀█░█▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌               ▐░▌     *\n"
g['artwork_subtraction'] += "*           ▐░▌▐░▌       ▐░▌▐░▌       ▐░▌      ▐░▌     ▐░▌     ▐░▌  ▐░▌       ▐░▌▐░▌               ▐░▌     *\n"
g['artwork_subtraction'] += "*  ▄▄▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌      ▐░▌     ▐░▌      ▐░▌ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄      ▐░▌     *\n"
g['artwork_subtraction'] += "*  ░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌       ▐░▌     ▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌     ▐░▌     *\n"
g['artwork_subtraction'] += "*  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀         ▀       ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀       ▀      *\n"
g['artwork_subtraction'] += "************************************************************************************************************\n"
g['artwork_subtraction'] += "\n\n\n"
g['artwork_subtraction'] += "Let's Subtract two numbers.\n\n"

g['artwork_multiplication'] += "************************************************************************************************************\n"
g['artwork_multiplication'] += "*  ▄▄       ▄▄  ▄         ▄  ▄            ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄         ▄  *\n"
g['artwork_multiplication'] += "* ▐░░▌     ▐░░▌▐░▌       ▐░▌▐░▌          ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░▌       ▐░▌ *\n"
g['artwork_multiplication'] += "* ▐░▌░▌   ▐░▐░▌▐░▌       ▐░▌▐░▌           ▀▀▀▀█░█▀▀▀▀  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌          ▐░▌       ▐░▌ *\n"
g['artwork_multiplication'] += "* ▐░▌▐░▌ ▐░▌▐░▌▐░▌       ▐░▌▐░▌               ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌ *\n"
g['artwork_multiplication'] += "* ▐░▌ ▐░▐░▌ ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌          ▐░▌     ▐░█▄▄▄▄▄▄▄█░▌▐░▌          ▐░█▄▄▄▄▄▄▄█░▌ *\n"
g['artwork_multiplication'] += "* ▐░▌  ▐░▌  ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌          ▐░▌     ▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌ *\n"
g['artwork_multiplication'] += "* ▐░▌   ▀   ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌          ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌           ▀▀▀▀█░█▀▀▀▀  *\n"
g['artwork_multiplication'] += "* ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌               ▐░▌          ▐░▌     ▐░▌          ▐░▌               ▐░▌      *\n"
g['artwork_multiplication'] += "* ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄      ▐░▌      ▄▄▄▄█░█▄▄▄▄ ▐░▌          ▐░█▄▄▄▄▄▄▄▄▄      ▐░▌      *\n"
g['artwork_multiplication'] += "* ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌     ▐░▌     ▐░░░░░░░░░░░▌▐░▌          ▐░░░░░░░░░░░▌     ▐░▌      *\n"
g['artwork_multiplication'] += "*  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀       ▀       ▀▀▀▀▀▀▀▀▀▀▀  ▀            ▀▀▀▀▀▀▀▀▀▀▀       ▀       *\n"
g['artwork_multiplication'] += "************************************************************************************************************\n"
g['artwork_multiplication'] += "\n\n\n"
g['artwork_multiplication'] += "Let's Multiply two numbers.\n\n"


g['artwork_division'] += "****************************************************************************************\n"
g['artwork_division'] += "*  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄               ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_division'] += "* ▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░▌             ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌ *\n"
g['artwork_division'] += "* ▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀█░█▀▀▀▀  ▐░▌           ▐░▌  ▀▀▀▀█░█▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀  *\n"
g['artwork_division'] += "* ▐░▌       ▐░▌     ▐░▌       ▐░▌         ▐░▌       ▐░▌     ▐░▌       ▐░▌▐░▌           *\n"
g['artwork_division'] += "* ▐░▌       ▐░▌     ▐░▌        ▐░▌       ▐░▌        ▐░▌     ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_division'] += "* ▐░▌       ▐░▌     ▐░▌         ▐░▌     ▐░▌         ▐░▌     ▐░▌       ▐░▌▐░░░░░░░░░░░▌ *\n"
g['artwork_division'] += "* ▐░▌       ▐░▌     ▐░▌          ▐░▌   ▐░▌          ▐░▌     ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  *\n"
g['artwork_division'] += "* ▐░▌       ▐░▌     ▐░▌           ▐░▌ ▐░▌           ▐░▌     ▐░▌       ▐░▌▐░▌           *\n"
g['artwork_division'] += "* ▐░█▄▄▄▄▄▄▄█░▌ ▄▄▄▄█░█▄▄▄▄        ▐░▐░▌        ▄▄▄▄█░█▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_division'] += "* ▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌        ▐░▌        ▐░░░░░░░░░░░▌▐░░░░░░░░░░▌ ▐░░░░░░░░░░░▌ *\n"
g['artwork_division'] += "* ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀          ▀          ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀   *\n"
g['artwork_division'] += "****************************************************************************************\n"
g['artwork_division'] += "\n\n\n"
g['artwork_division'] += "Let's divide two numbers.\n"
g['artwork_division'] += "The first number is the numerator (top)\n"
g['artwork_division'] += "The second number is the denomerator (botton)\n\n"

g['artwork_average'] += "*****************************************************************************************************\n"
g['artwork_average'] += "*  ▄▄▄▄▄▄▄▄▄▄▄  ▄               ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_average'] += "* ▐░░░░░░░░░░░▌▐░▌             ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ *\n"
g['artwork_average'] += "* ▐░█▀▀▀▀▀▀▀█░▌ ▐░▌           ▐░▌ ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀▀▀▀▀▀  *\n"
g['artwork_average'] += "* ▐░▌       ▐░▌  ▐░▌         ▐░▌  ▐░▌          ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌           *\n"
g['artwork_average'] += "* ▐░█▄▄▄▄▄▄▄█░▌   ▐░▌       ▐░▌   ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄█░▌▐░▌ ▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_average'] += "* ▐░░░░░░░░░░░▌    ▐░▌     ▐░▌    ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌▐░░░░░░░░▌▐░░░░░░░░░░░▌ *\n"
g['artwork_average'] += "* ▐░█▀▀▀▀▀▀▀█░▌     ▐░▌   ▐░▌     ▐░█▀▀▀▀▀▀▀▀▀ ▐░█▀▀▀▀█░█▀▀ ▐░█▀▀▀▀▀▀▀█░▌▐░▌ ▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀  *\n"
g['artwork_average'] += "* ▐░▌       ▐░▌      ▐░▌ ▐░▌      ▐░▌          ▐░▌     ▐░▌  ▐░▌       ▐░▌▐░▌       ▐░▌▐░▌           *\n"
g['artwork_average'] += "* ▐░▌       ▐░▌       ▐░▐░▌       ▐░█▄▄▄▄▄▄▄▄▄ ▐░▌      ▐░▌ ▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄  *\n"
g['artwork_average'] += "* ▐░▌       ▐░▌        ▐░▌        ▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌ *\n"
g['artwork_average'] += "*  ▀         ▀          ▀          ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  *\n"
g['artwork_average'] += "*****************************************************************************************************\n"
g['artwork_average'] += "'If you are going to be average, you might as well be mean'\n"
g['artwork_average'] += "*****************************************************************************************************\n"
g['artwork_average'] += "\n\n\n"
g['artwork_average'] += "Let's from calculate the average of a series of numbers.\n"


if __name__ == "__main__":
    main()
