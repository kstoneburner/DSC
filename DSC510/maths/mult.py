

import random

def mainLoop():
    ######################
    ### Clear Screen
    ######################
    for x in range(0,40):
        print("\n")

    ### Welcome Message
    print("Let's do 20 Multiplication Problems!")

    ### Ask for the largest number to multiply by
    maxNumber = input("What is the largest number you'd like to multiply? ")

    ### Check for a valid integer
    try:

        ### Convert Input to INT
        maxNumber = int(maxNumber)

        ### Initialize the correct answer count
        right_count = 0

        ### Loop 20 times
        for question_number in range(1,20):

            ### firstNum - Random Number between 1 and the user defined maximum
            firstNum = random.randint(1,maxNumber)

            ### secondNum - Random Number between 1-10 because she's in 3rd grade
            secondNum = random.randint(1,10)

            ### Display the problem. In classid style, firstNumber over the Second number with an x and a dasshed line
            ### The rjust is string right justify with 4 blank spacers. This helps with a nice clean looking format
            print(str(firstNum).rjust(4, ' '))
            print ("x  "+str(secondNum) + "\n")
            print ("-----\n")

            ### Wait for the answer. Display # correct and the question number of 20
            answer = input("(" + str(right_count) + " Correct : " + str(question_number) + "/ 20) > ")

            ### Test the input for an integer response. If answer is not a valid INT it is wrong.
            try:
                answer = int(answer)

                #### Test for the right Answer
                if answer == firstNum * secondNum:
                    print("")
                    ### Display a victory Message
                    print("Good Job! " + str(firstNum) + " x " + str(secondNum) + " = " + str(firstNum * secondNum))
                    print("")
                    ### Increment the total correct counter
                    right_count += 1

                else:
                    #### All other Integers are the wrong answer
                    print("")
                    ### Display Failure message
                    print("Wrong Answer! " + str(firstNum) + " x " + str(secondNum) + " = " + str(firstNum * secondNum))
                    print("")

            except:
                #### Anything NOT an integer is the wrong answer
                print("")
                print("Sorry Wrong Answer!")
                print("")
            ### END Try Answer

        ### END 20 Questions Loop - Do the above 20 times

        ### Display the total number of correct answers
        print("")
        print("")
        print("")
        print("You got " + str(right_count) + " of 20 math problems right!")
        print("")
        print("")
        print("")
        #### END Try Main Question Function
    except:
        #### Handle Non INT input. Display Polite error message and ask for input
        for x in range(0, 40):
            print("")
        print("You Must enter a Valid number!")
        print(" ")
        input("Press ENTER to continue")
        mainLoop()


    return
    ### END Main Loop

mainLoop()