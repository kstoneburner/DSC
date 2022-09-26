
def getElem(element_type,input_value,element,first_elem_only=True,auto_fail=True):
	wait_time=10
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

	print("Searching by " + element_type + " for " + input_value + " in " + str(wait_time) + "s")

	try:
		#//*** Find Single Element
		#element = WebDriverWait(page_driver, wait_time).until( EC.presence_of_element_located((by_action, input_value)) )

		elements = WebDriverWait(element, wait_time).until( EC.presence_of_all_elements_located((by_action, input_value)) )
		
		print("Found")
		if first_elem_only:
			return elements[0]
		else:
			elements
	except:
		print("Element Not Found. Returning None")
		return None