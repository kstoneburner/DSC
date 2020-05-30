####################################################################################################
####################################################################################################
####################################################################################################
### DSC 510
### Week 11
### Programming Assignment Week 11
### Author: Kurt Stoneburner
### 2020/05/18
### Program Purpose:
##################### Demonstrate knowledge of Python Object Oriented programming concepts
##################### by creating a simple cash register program
####################################################################################################
####################################################################################################
####################################################################################################
import locale

class CashRegister():
    def __init__(self):
        self.basket = []
        self.basketTotal = 0.00
        self.basketCount = 0

    def addItem(self,value):
        ### Receives an item Value
        ### Validates Item as float
        ### Adds Item to basket
        ### Updates the total value of the basket
        ### returns True if successful, false on error
        try:
            value = float(value)
        except:
            return False
        ### Don't add Zero or negative numbers
        if value <= 0:
            return False
        ### Number should be a float that is greater than Zero
        ### These numbers should be valid
        ### Let's test for unknowns. This is probably overkill. But as Agent Mulder says "Trust No One"
        ### Generate test values from the current basket and verify all increment / add operations
        ### We use the test/proxy values, in the unlikely event that one action succeeds and another fails.
        try:
            ### It's important to make a copy of list, not a reference to it
            testList = self.basket.copy()
            testTotal = self.basketTotal
            testCount = self.basketCount
            testList.append(value)
            testTotal += value
            testCount += 1
        except:
            return False

        ### Actions validated. Update the internal values.
        self.basket.append(round(value,2))
        ### Force the Float to round to two places
        self.basketTotal = round(self.basketTotal + value,2)
        self.basketCount += 1

        return True

    def getItems(self):
        return self.basket

    def getTotal(self):
        return self.basketTotal

    def getCount(self):
        return self.basketCount

    def getCartWork(self):
        cartWork = "\n\n"
        cartWork += "#####\n"
        cartWork += "     \\\\================\n"
        cartWork += "       |\/\/\/\/\/\/\/\|\t\tWelcome to Baskets\n"
        cartWork += "       |/\/\/\/\/\/\/\/|\t\tShopping Cart\n"
        cartWork += "       |\/\/\/\/\/\/\/\|\t\tCalculator\n"
        cartWork += "       |/\/\/\/\/\/\/\/|\n"
        cartWork += "        ===============\n"
        cartWork += "         ||\n"
        cartWork += "          \\\\\n"
        cartWork += "            \\\\\n"
        cartWork += "         ===============\n"
        cartWork += "          ()         ()\n"
        return cartWork

def cashLoop(inputBasket,state):

    if state == "BEGIN":
        print(inputBasket.getCartWork())
    elif state == "INVALID":
        print("\n\n\n")
        print("**************************************************************")
        print("* Please follow the rules of common cart summation courtesy! *")
        print("* 1. Only input prices.                                      *")
        print("* 2. Prices must be greater than Zero                        *")
        print("* 3. Prices are numbers only.                                *")
        print("**************************************************************")

    print("\n")
    print("================================================")
    print("Please input the price of your items in the Cart")
    print("================================================")
    print("")
    print(f"{inputBasket.getCount()} - Items in Cart ")

    print(f"{locale.currency(inputBasket.getTotal())} total")
    print("")
    user_response = input(f"ENTER to QUIT | Amount? ")

    ### Check for Quit
    if len(user_response) > 0:
        ### Add Item to Cart. Returns True if operation successful
        if inputBasket.addItem(user_response):
            cashLoop(inputBasket,"")
            return #Guarantee Function quits
        else:
            ### Invalid Input, restart cashLoop with INVALID statement
            cashLoop(inputBasket,"INVALID")
    else:
        ### Put the receipt header file in a string
        receipt_header = "Exit ticketing Summary Receipt"
        print("\n\n\n")
        print("=" * len(receipt_header))
        print(receipt_header)
        print("="*len(receipt_header))
        print("\n")
        ### Get a padding value that is 20% less than the length of the receipt header
        ### This method isn't very clear. Since the formatting can be dynamically assigned
        ### Based on the header length, the string has to be pre-built.
        padding = '{:>'+str(int(len(receipt_header) - (len(receipt_header) * .2)) )+'}'
        #### User indictates Quit
        for x in inputBasket.getItems():
            print(padding.format(locale.currency(x)))
        print("="*len(receipt_header))
        formatted_totals = f"{inputBasket.getCount()} items - {locale.currency(inputBasket.getTotal())}"
        print(padding.format(formatted_totals))
        return


def main():
    # Default settings based on the user's environment.
    locale.setlocale(locale.LC_ALL, '')

    thisBasket = CashRegister()
    cashLoop(thisBasket,"BEGIN")

if __name__ == "__main__":
    main()
