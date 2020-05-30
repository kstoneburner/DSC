"""
Last week we got a taste of working with files. This week we’ll really dive into files by opening and closing files properly.

For this week we will modify our Gettysburg processing program from week 8 in order to generate a text file from the output rather than printing to the screen. Your program should have a new function called process_file which prints to the file (this method should almost be the same as the pretty_print function from last week. Keep in mind that we have print statements in main as well. Your program must modify the print statements from main as well.

Your program must have a header. Use the programming style guide for guidance.
Create a new function called process_fie. This function will perform the same operations as pretty_print from week 8
however it will print to a file instead of to the screen.
Modify your main method to print the length of the dictionary to the file as opposed to the screen.
This will require that you open the file twice. Once in main and once in process_file.
Prompt the user for the filename they wish to use to generate the report.
Use the filename specified by the user to write the file.
This will require you to pass the file as an additional parameter to your new process_file function.
"""

"""
https://wiki.python.org/moin/HandlingExceptions
"""
import re
import os
####################################################################################################
####################################################################################################
####################################################################################################
### DSC 510
### Week 9
### Programming Assignment Week 9
### Author: Kurt Stoneburner
### 2020/04/28
### Program Purpose:
##################### Open gettysburg.txt and print a histogram of each of the words.
####################################################################################################
####################################################################################################
####################################################################################################
#### Functions: ordered alphabetically, except main which is last
####################################################################################################
#### clrScreen() - Clear Screen by writing a bunch of NEWLINEs
####################################################################################################
#### exit_gracefully() - Display a nicely formatted goodbye message before quitting
####################################################################################################
#### main - main program loop
####################################################################################################
def clrScreen():
    ### Clear the screen with some NEWLINEs
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    return ### <-- Not technically needed, but it's weird not ending a function with a return.

def add_word():
    ###Adds Words to the dictionary
    print("Add Word")

def process_line(input_line, input_dict):
    def add_word(input_word):
        ### check if word is in dictionary
        if input_word in input_dict.keys():
            ### Key Exists, increment the value
            input_dict[input_word] += 1
        else:
            ### Key Does not exist. Create and initialize
            input_dict[input_word] = 1
    #END Add Word

    ### Process each line of the text file
    ### Trim trailing New Line
    line = input_line.replace("\n", "")
    raw_word_list = line.split(" ")
    for raw_word in raw_word_list:
        ### Remove NON-TEXT characters by the power of REGULAR EXPRESSIONS
        ### https://www.w3schools.com/python/python_regex.asp
        raw_word = re.sub("\W","",raw_word)

        ### Ignore empty words
        if len(raw_word) > 0:
            add_word(raw_word)

    return input_dict


def process_file(input_file, input_dict):
    def formatReverseLine(input_key, input_list):
        ### Take the dictionary key and list and make them pretty
        ### The lists can be long in some cases. We'll need to split them up
        out = ""
        tempLine = ""

        lineList = []

        ### Combine the words from input list. We'll need to split the list if over 60 characters
        for word in input_list:
            tempLine += word + ", "

            ### If line over 69 add it to the line list and trim the trailing characters
            if len(tempLine) > 60:
                lineList.append(tempLine[:-2])
                tempLine = ""

        ### add whatever is left over to the Line list
        lineList.append(tempLine[:-2])

        ### Loop through the lineList
        for x in range(len(lineList)):

            if x == 0:
                #### This is the first line:
                out += "{:<20} {}".format("Frequency: " + str(input_key), lineList[x] + "\n")
            else:
                out += "{:<20} {}".format(str(" "), lineList[x]+ "\n")

        return out[:-1] #Return the output minus the trailing newline

    out = ""
    ### Sorting a dictionary: https://stackoverflow.com/questions/613183/how-do-i-sort-a-dictionary-by-value
    ### Totally feels like cheating
    ####################################################################
    ### Code Below satisfies the requirements
    ### but does not satisfy me
    ####################################################################
    for key in sorted(input_dict, key=input_dict.get, reverse=True):
        out += ("{:<15}  {:<5}\n".format(key,input_dict[key]) )
    # out += ("===================================\n")
    # out += (f"Total Words: {len(input_dict)}\n")
    # out += ("===================================\n")

    #### Let's reverse the dictionary, and display the words using Frequency as a key
    reverseDict = {}
    for key in sorted(input_dict, key=input_dict.get, reverse=True):
        oldKey_newValue = key
        newKey_oldValue = input_dict[key]

        #### Build a dictionary of words based on frequency.
        #### The frequency = List of words with that frequency
        if newKey_oldValue in reverseDict:
            ### newKey exists, append newValue to the existing list
            reverseDict[newKey_oldValue].append(oldKey_newValue)
        else:
            ### newKey does not exist. Initialize the dictionary
            reverseDict[newKey_oldValue] = [ oldKey_newValue ]

    out += ("===================================\n")

    ### Sort the reverseDict by key value
    for key in sorted(reverseDict, reverse=True):
        #print(f"{key} - {reverseDict[key]}")
        out += (formatReverseLine(key,reverseDict[key])+"\n")


    with open(input_file, 'a') as fileHandle:  # open file for writing
        fileHandle.write(out)  # write data to file


def main():
    def handle_interrupt(e):
        ### This function is triggered when the user attempts to exit with a CTRL+C
        ### This function is outboarded so it can be recursive, preventting the user
        ### From ever exiting with a CTRL+C
        ### Just Like shelter in place, users
        try:
            print("WELL WELL WELL What did you do Ray?")
            print("You should think about what you did here.")
            print("And try again.")
            print(f"{e}")
            input("ENTER to continue")
        except KeyboardInterrupt as ie:
            handle_interrupt(ie)
        main()
        return

    def validate_filename(input_filename):
        bad_chars = ("<", ">", '"', "|", "?", "*")

        ### Test for Bad Characters!
        for bc in bad_chars:
            if bc in input_filename:
                print(f"{bc} cannot be used in a filename")
                print("Please try again.")
                print("\n")
                ### Go Recursion!
                ####### Go, Go, --- Go Recursion!
                ############## Go, Go, --- Go Recursion!
                ############################ Go, Go, --- Go Recursion!
                ### Can't Stop, won't stop, i'm addicted to valid input
                return (validate_filename(input("Please enter a valid filename: ")))

        ### Test for instances of period. One period is permitted
        ### Regex Time! Double Backslash indicates single backslash, which escaped the period.
        ### This forces regex to perform a string literal search. Important since dot is a reserverd
        ### regex character that is a wildcard. Which would return the exact opposite of what we are looking for.
        dotCount = len(re.findall("\\.", input_filename))

        ### Let's enforce some arbitrary good filenaming behavior.
        if dotCount == 0:
            ### No file extension found.
            ### We need a file extension for proper file formatting
            print("\n")
            print("Technically a file extension is optional")
            print("But not today.")
            print("\n")
            return (validate_filename(input("Please enter a properly formatted filename: ")))

        if dotCount > 1:
            ### Too many dots found!
            print("\n")
            print("Technically a file may contain multiple .")
            print("But not today.")
            print("Properly formatted filenames will contain one . and one . only")
            print("\n")
            return (validate_filename(input("Please enter a properly formatted filename: ")))

        ### The last character Cannot be a dot
        if input_filename[-1] == ".":
            print("\n")
            print("A filename cannot end with .")
            print("\n")
            return (validate_filename(input("Please enter a properly formatted filename: ")))

        ### Check if File exists
        if os.path.exists(input_filename):
            print()
            print(f"{input_filename} exists do you want to overwrite it?")
            overwiteResponse = input("Y\[N]")
            ### Restart the program on any resposnse other than Y.
            ### The user must positively state they want to overwrite the file.
            if overwiteResponse.lower() != 'y':
                main()
                quit()  #### Restart program, quit here

        ### Test Write to file. If this works we are good. File write is fully verified.
        try:
            with open(input_filename, 'w') as fileHandle:  # open file for writing
                fileHandle.write("")  # write data to file
        except Exception as e:
            ### Some novel error has occurred. Blame the user and start over
            print(f"There is something wrong with your filename: {input_filename}")
            print(str(e))
            input("Press ENTER to try again")
            main()
            quit()  #### Restart program, quit here

        ### On it's surface the filename is minimally good. We'll be right back here if the filename doesn't checkout
        ### Mark my words, we'll be back!!!!
        return input_filename

    try:
        histogram_dict = {}
        clrScreen()

        filePath = 'gettysburg.txt'
        with open(filePath,'r') as fileHandle:  # r for reading
            gba_file = fileHandle.readlines() # read into a variable

        for line in gba_file:
            histogram_dict = process_line(line, histogram_dict)

        clrScreen()
        disp = ""
        disp += "  , -----------.     |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|\n"
        disp += "(_\ Four score \\     | * * * * * * * * *  ::: Welcome to the     ::|\n"
        disp += "  | and seven   |    |* * * * * * * * * * 0000000000000000000000000|\n"
        disp += "  | years ago...|    | * * * * * * * * *  ::: Gettysburg address ::|\n"
        disp += " _|             |    |* * * * * * * * * * 0000000000000000000000000|\n"
        disp += "(_/ _____( *)__ /    | * * * * * * * * *  ::: histogram          ::|\n"
        disp += "              \\\\     |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|\n"
        disp += "                ))   |::::::::::::::::::::::: display-ifier      ::|\n"
        disp += "                ^    |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|\n"
        disp += "                     |:::::::::::::::::::::::::::::::::::::::::::::|\n"
        disp += "                     |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|\n"
        disp += "                     |:::::::::::::::::::::::::::::::::::::::::::::|\n"
        disp += "                     |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|\n"
        print(disp)
        print("\n\n")
        print("Where would you like to save this valuable histographic analysis?")
        this_fileName = validate_filename(input("Please enter a valid filename: "))

        # this_fileName has been rigourously validated. Presume it is valid

        ### initialize output variable for file writing
        out = disp + "\n"

        out += ("===================================\n")
        out += (f"Total Words: {len(histogram_dict)}\n")
        out += ("===================================\n\n")
        with open(this_fileName,'w') as fileHandle:  # open file for writing
            fileHandle.write(out) #write data to file

        process_file(this_fileName,histogram_dict)

        clrScreen()
        print(disp)
        print("\n\n")
        print("Thank you for preserving this important historical analysis.")
        print(f"Results can be viewed in {this_fileName}")
        print("\n\n\n\n")

    except KeyboardInterrupt as e:
        handle_interrupt(e)
    except Exception as e:
        print("Something untoward has occurred")
        print(f"{e}")
        return

if __name__ == "__main__":
    main()
