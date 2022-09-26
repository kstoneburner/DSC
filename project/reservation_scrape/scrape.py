#//*** Expected Conditions
#https://www.selenium.dev/selenium/docs/api/py/webdriver_support/selenium.webdriver.support.expected_conditions.html#selenium.webdriver.support.expected_conditions.presence_of_all_elements_located
import time, datetime, random, os, hashlib, json

from pathlib import Path

from selenium.webdriver.common.action_chains import ActionChains
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

page_driver = webdriver.Firefox()

def getElem(element_type,input_value,wait_time=10,element=page_driver,first_elem_only=True,auto_fail=True):
	
	by_action = None

	action_dict = {
		"id" : By.ID,
		"class" : By.CLASS_NAME,
		"xpath" : By.XPATH,

	}

	if element_type in action_dict.keys():
		by_action = action_dict[element_type]
	else:
		print("Invalid Element Type")
		print("Valid Inputs are:")
		for key in action_dict.keys():
			print("\t",key)
		return None

	#print("Searching by " + element_type + " for " + input_value + " in " + str(wait_time) + "s")

	try:
		#//*** Find Single Element
		#element = WebDriverWait(page_driver, wait_time).until( EC.presence_of_element_located((by_action, input_value)) )

		elements = WebDriverWait(element, wait_time).until( EC.presence_of_all_elements_located((by_action, input_value)) )
		
		#print("Found")
		if first_elem_only:
			return elements[0]
		else:
			#print("Returning Multiple ELements")
			return elements
	except:
		#print("Element Not Found. Returning None")
		return None

	
def isValid(input_element):
	if input_element == None:
		#print("Element is None")
		return False
	return True

def send_keystrokes(element,input_string):

	#Simulate Keystrokes by sending individual characters to a form with some delay
	for x in input_string:
		element.send_keys(x)

		#//*** Now Wait two tenths of a second

		

		delay = ( random.randint(1,9) ) * .015

		
		print("waiting " + str(delay) + "s")
		time.sleep(delay)


if __name__ == "__main__":
	g = {
		"url" : "https://compadmission.disney.com/reservations/new?locale=en&pass=MEP",
	}

	state = {
		"login_card" : False,
	}


	#//*** Loads Secrets
	with open("./ignore/ignore.me", 'r') as file:
	    for key,value in json.load(file).items():
	    	g[key] = value


	

	page_driver.get(g["url"])

	login_card = getElem("class","login_card")

	if isValid(login_card):
		print("Valid Login card")

		id_field = getElem("id", "login-username")
		
		if isValid(id_field):
			send_keystrokes(id_field,g['user'])

		next_button = getElem("id","login-next")
		if isValid(next_button):
			time.sleep(1)
			next_button.click()

		pass_field = getElem("id","login-password")

		if isValid(pass_field):
			send_keystrokes(pass_field,g['pass'])

		login_button = getElem("id","login-submit")

		if isValid(login_button):
			time.sleep(1)
			login_button.click()

		two_fa_button = getElem("id","mfa-sendpush")
		if isValid(two_fa_button):
			time.sleep(1)
			two_fa_button.click()

			accept_two_fa_button = getElem("id","mfa-trustedbrowsers-trust",120)

			if isValid(accept_two_fa_button):
				accept_two_fa_button.click()

				time.sleep(3)

				page_driver.get(g["url"])

				#//**** Process Calendar
				#//*** Get whole Calendar desktop element
				whole_calendar = getElem("class","calendar-desktop")

				#//*** Get Each Month
				for find_month in ['month-0','month-1','month-2','month-3','month-4','month-5','month-6','month-7','month-8','month-9']:

					month_element = getElem("class",find_month,10,whole_calendar)

					if isValid(month_element) == False:
						print("Month Not Found. Stopping")
						break

					#//*** Month is Valid
					#//*** Get Month Name
					month_title_element = getElem("class","datemonth",1,month_element)
					if isValid(month_title_element):
						month_name = month_title_element.text
						print(month_name)

						available_reservations = getElem("class","date-available",1,month_element,False)
						
						if isValid(available_reservations):
							for elem in available_reservations:
								print(+ f"Available: {month_name} - {elem.text}" )
						else:
							print("\t No Reservations")

						print()


	else:
		print("Login Card Not Found")

