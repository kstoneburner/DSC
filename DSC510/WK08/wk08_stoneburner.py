import re
####################################################################################################
####################################################################################################
####################################################################################################
### DSC 510
### Week 8
### Programming Assignment Week 8
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


def pretty_print(input_dict):
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

    ### Sorting a dictionary: https://stackoverflow.com/questions/613183/how-do-i-sort-a-dictionary-by-value
    ### Totally feels like cheating
    ####################################################################
    ### Code Below satisfies the requirements
    ### but does not satisfy me
    ####################################################################
    print("===================================")
    for key in sorted(input_dict, key=input_dict.get, reverse=True):
        print("{:<15}  {:<5}".format(key,input_dict[key]) )
    print("===================================")
    print(f"Total Words: {len(input_dict)} ")
    print("===================================")

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

    ### Sort the reverseDict by key value
    for key in sorted(reverseDict, reverse=True):
        #print(f"{key} - {reverseDict[key]}")
        print(formatReverseLine(key,reverseDict[key]))



def main():
    histogram_dict = {}
    clrScreen()
    gba_file = open('gettysburg.txt','r')
    for line in gba_file:
        histogram_dict = process_line(line,histogram_dict)


    pretty_print(histogram_dict)



if __name__ == "__main__":
    main()
