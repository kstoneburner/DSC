####################################################################################################
####################################################################################################
####################################################################################################
#### course: DSC510
#### assignment: 2.1
#### date: 03/16/20
#### name: Kurt Stoneburner
#### Program Purpose: Collect information from user for a fiber cable installation
##################### Print/Display a receipt for the fiber installation
##################### The price varies depending on the order size
####################################################################################################
####################################################################################################
####################################################################################################
### Global Variables go in a master dictionary.
### This is a personal style, because Javascript leaves scars
####################################################################################################
master = {
    "title" : "",           # Header / receipt Artwork
    "artLine": "==--==--==--==--==--==--==--==--==--==--==--==--==--=--==--==--==--==--==", # For easy reuse
    "company_name" : "",
    "order_size" : -1,
    "order_foot_cost" : .87,
}
### Start with some Blank Space
for x in range(0,30):
    print("")
### Title is our artwork, we'll reuse it for the receipt
master["title"] = ""
master["title"] += "==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==\n"
master["title"] += "..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..\n"
master["title"] += "==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==\n"
master["title"] += "..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..\n"
master["title"] += "==..==..==   Shop smart, shop   ==..==..==..==..==..==..==..==..==..==\n"
master["title"] += "..==..==..   ________     ______  ___             _____     ..==..==..\n"
master["title"] += "==..==..==   __  ___/     ___   |/  /_____ _________  /_    ==..==..==\n"
master["title"] += "..==..==..   _____ \________  /|_/ /_  __ `/_  ___/  __/    ..==..==..\n"
master["title"] += "==..==..==   ____/ //_____/  /  / / / /_/ /_  /   / /_      ==..==..==\n"
master["title"] += "..==..==..   /____/       /_/  /_/  \__,_/ /_/    \__/      ..==..==..\n"
master["title"] += "==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==\n"
master["title"] += "..==..==..==..==..==..==.. Where bulk is value  ..==..==..==..==..==..\n"
master["title"] += "==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==\n"
master["title"] += "..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..==..\n"

##################################
#### Print Welcome Message
##################################
print (master["title"])
print("Thank you for choosing S-Mart for all of you fiber installation needs\n\n\n")
print("I'll need some information to complete your fiber installation order.\n\n")
print("First, what is the company for your order?\n")

##################################
### Get Company Name
##################################
master["company_name"] = input("Company Name: ")
for x in range(0,30):
    print("")
print(master["artLine"])
print("This order is an order of ")
print("S-Mart Brand 'Max Quality Fiber' Cable for: " + master["company_name"])
print(master["artLine"])
print("Orders are are in increments of one foot. If your order requires a ")
print("fraction of a foot, you will need to purchase the entire foot.")
print("Cable can be trimmed on-site for no additional fee")
print(master["artLine"])
print("Inclusive Fiber installation cost:")
print(master["artLine"])
print("\t 0-99ft = $.87 / foot ")
print("\t 100ft+ = $.80 / foot ")
print("\t 250ft+ = $.70 / foot ")
print("\t 500ft+ = $.50 / foot ")

### 100 feet they are charged $0.80 per foot.
### If the user purchases more than 250 feet they will be charged $0.70 per foot.
###  If they purchase more than 500 feet, they will be charged $0.50 per foot.
print("")
for x in range(0,10):
    print("")
print("How many feet would like to purchase?")
########################################
### Get Number of Feet For the Order
########################################
master["order_size"] = input("Feet: ")

try:
    #### Convert Input to INT
    master["order_size"] = int(master["order_size"])
except:
    #### Handle Non INT input. Display Polite error message and quit
    for x in range(0, 40):
        print("")
    print(master["artLine"])
    print("We only accept orders in whole feet. Please type numbers only.")
    print("Please start your order again")
    print(master["artLine"])
    for x in range(0, 10):
        print("")
    quit()

for x in range(0, 20):
    print("")

##################################
#### Determine the cost per foot
##################################

### Default cost initialized to .87 / ft

### If more than 100 ft, cost is .8 / ft
if master["order_size"] >= 100:
    master["order_foot_cost"] = .8

### If more than 250 ft, cost is .7 / ft
if master["order_size"] >= 250:
    master["order_foot_cost"] = .7

### If more than 500 ft, cost is .5 / ft
if master["order_size"] >= 500:
    master["order_foot_cost"] = .5

#######################
#### Display Receipt
#######################
print (master["title"])
print("Thank you for shopping at S-Mart")
print(master["artLine"])
print("We have one order of " + str(master["order_size"]) + "ft of")

### Add a trailing 0 to the display of the discounted rate. Otherwise .70 displays as .7
if master["order_size"] >= 100:
    print("S-Mart Brand 'Max Quality Fiber' Cable at $" + str(master["order_foot_cost"]) + "0 / ft")
else:
    print("S-Mart Brand 'Max Quality Fiber' Cable at $"+ str(master["order_foot_cost"]) +" / ft")
print("For delivery to: " + master["company_name"])
print("Please have a payment of $" + str(master["order_size"] * master["order_foot_cost"] )  + " ready upon receipt of goods")
print(master["artLine"])
