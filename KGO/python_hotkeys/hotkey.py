#//*** Check Box
#https://www.pythontutorial.net/tkinter/tkinter-checkbox/
#import keyboard #pip install keyboard
import win32gui, os, sys,io, json
#//*** Options are 0 or 2
#sys.coinit_flags = 2

#import time, threading, pyperclip

#from pywinauto import application
import pyautogui

import tkinter as tk

from hotkey_core_modules import *

#from tkinterdnd2 import DND_FILES, DND_ALL, TkinterDnD

def updateField(txt):
	lb.delete("1.0", "end") 
	lb.insert(tk.END,txt) 
	print(lb.get("1.0", "end"))

win = tk.Tk()
#win = TkinterDnD.Tk()  # notice - use this instead of tk.Tk()

win.title("Dalet Hotkeys")

from tkinter import *
from tkinter import ttk, filedialog
from tkinter.filedialog import askopenfile
from tkinter import dnd

from PIL import Image,ImageTk

import pywinauto 
from pywinauto import application
pywinauto.multi_threading_mode = True



# Import the required Libraries
from functools import partial
import json,sys,os,gzip,tarfile,shutil

#//*** Pyperclip documentation
#https://medium.com/analytics-vidhya/clipboard-operations-in-python-3cf2b3bd998c
#https://github.com/boppreh/keyboard

debug_mode = False

# Create an instance of tkinter frame
#win = Tk()

app = application.Application(backend="uia")


all_cols = ['icon','float','lock','page','slug','segment','brio5','brio6','brio7','brio8','anchor','cam','dur','stage','gfx','changes']
cols = ['page','slug','segment','anchor','cam','stage','gfx','changes']
master_hotkey_filename = "master_hotkeys.json"
connected = False
quit=False
transitions,transition_actions = load_transitions()
mos_variables = load_mos_object_variables()
alt_modes = load_alt_modes()
show_modes = load_show_modes()
hotkey_actions = load_hotkey_actions()
kl = load_keyboard_key_list()
enter_script_key = 'f7'
master_rules = load_master_rules(master_hotkey_filename)
colors = {
	"bg_error" : "#f99290",
	"bg_normal" : 'SystemButtonFace'
}
checkbox_names = ['ctrl','win','shift','alt']
default_filter_key_index = 1

print(kl)

print(show_modes)
# https://pythonbasics.org/tkinter-filedialog/
# https://pythonguides.com/python-tkinter-text-box/
#//*** pyinstaller --onefile caprica_merge.py -n KGO_Caprica_CC_Merge


class widget_builder():

	def __init__(self):
		self.widget_holder = {}
		self.mos_variables = mos_variables
		self.transitions = transitions
		self.unique_id = 0

	def get_id(self):
		out = self.unique_id
		self.unique_id = self.unique_id + 1
		return out

	def reset_widgets(self):
		self.widget_holder = {}

	def add_widgets(self,input_obj,win=win):

		#//*** Initialize empty options 
		options = {}

		#//*** Build Options if it exists
		if "options" in input_obj.keys():

			options = input_obj["options"]

		#//*** Add Default Text value
		options["text"] = "No Text Specified"

		#//*** Assign default values
		row = -1
		column = -1
		columnspan = -1
		obj_type = None
		#hook = None
		action = None
		target = None
		text = ""
		width = -1
		check_value = False
		padx = 0
		side = LEFT


		name = ""
		
		#//*** Assign values based on input_obj key.
		#//*** Items NOT listed in verify_key list will not be proccessed.
		#//*** This is an explicit whitelist process
		#for verify_key in ["row","column", "type", "hook", "action", "target", "text", "columnspan", "width"]:

		for verify_key in input_obj.keys():

			if verify_key == "row":
				row = input_obj[verify_key]


			if verify_key == "column":
				column = input_obj[verify_key]

			if verify_key == "type":
				obj_type = input_obj[verify_key]

			#if verify_key == "hook":
			#	hook = input_obj["hook"]

			if verify_key == "action":
				action = input_obj["action"]

			if verify_key == "target":
				target = input_obj["target"]

			if verify_key == "text":
				options["text"] = input_obj["text"]
				text = input_obj["text"]

			if verify_key == "columnspan":
				columnspan = input_obj["columnspan"]

			if verify_key == "width":
				width = input_obj["width"]

			if verify_key == "value":
				check_value = input_obj["value"]

			if verify_key == "padx":
				padx = input_obj["padx"]

			if verify_key == "side":
				side = input_obj["side"]

			if verify_key == "name":
				name = input_obj["name"]

		if obj_type == None:
			print("QUITTING widget: Widget missing type attribute")
			print(input_obj)
			return


		#//*** Get a unique ID for the hook
		hook = self.get_id()

		#//*** Process the object types: Labels, buttons, etc
		if "type" in input_obj.keys():

			if input_obj["type"] == "label":

				if "text" in input_obj.keys():
					options["text"] = input_obj["text"]

				options["width"] = width

				options['name'] = name

				#//*** Build Label
				self.widget_holder[hook] = Label(win,options)

				#//*** Draw Label
				#self.widget_holder[hook].grid(grid)
				self.widget_holder[hook].pack(side=side, padx=padx)

			if input_obj["type"] == "button":

				if action == "add_code":

					options['command'] = self.add_code

				if action == "delete_code":
					#//***destroy parent Frame
					options['command'] =win.destroy

				
				if action == "delete_code":
					#//*** Build Hooked Button
					self.widget_holder[hook] = ttk.Button(win, 
						text=options["text"], 
						width=width, 
						command=partial(options['command']) ,
						)
					
				else:
					#//*** Build Hooked Button
					self.widget_holder[hook] = ttk.Button(win, 
						text=options["text"], 
						width=width, 
						command=partial(options['command'],win) ,
						)
						
						
				#//*** Draw Hooked Button
				self.widget_holder[hook].pack(side=side)

			if input_obj["type"] == "rule_checkbox":

				#//*** Build a Unique Variable name based Hook, row and Col values
				#hook = f"{row}_{hook}_{column}"

				var = BooleanVar(win, name=str(hook),value=check_value)

				#print("Check Hook:",hook)
				
				self.widget_holder[hook] = Checkbutton(win, text=text, name=name, variable=var, width=width)
				self.widget_holder[hook].variable = var
				#print(win.getvar(name=hook))
				
				#self.widget_holder[hook].grid(grid)
				self.widget_holder[hook].pack(side=side)

				
			if input_obj["type"] == "textbox":
				
				self.widget_holder[hook] = Entry(win, width=width, name=name)
				self.widget_holder[hook].insert(0,text)
				self.widget_holder[hook].pack(side=side)
				
			if input_obj["type"] == "mos_variable_listbox":

				print("mos_variable_listbox")
				
				height = 10
				list_items = Variable(value=list(self.mos_variables.keys()), name=str(hook))
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    state="readonly",
					    values = list(self.mos_variables.keys()),name="mos_variable"
					)
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_mos_variable)
				self.widget_holder[hook].mode = "coded"

			elif input_obj["type"] == "mos_transition_listbox":
				
				tran_choices = ["selected_transition","stored_transition","ACTION"] +list( self.transitions.keys())

				list_items = Variable(value=tran_choices, name="transition")
				combo_holder = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = tran_choices,name="transition",width=width, state='readonly'
					)

				self.widget_holder[hook] = combo_holder
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_transition_combo)
				self.widget_holder[hook].mode = "coded"

			elif input_obj["type"] == "mos_transition_secondary_listbox":
				
				tran_choices = list( self.transitions.keys() )

				list_items = Variable(value=tran_choices, name=str(hook))
				combo_holder = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = tran_choices,name="transition_secondary",width=width, state='readonly'
					)

				self.widget_holder[hook] = combo_holder
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)

			
			elif input_obj["type"] == "key_filter_listbox":
				
				#tran_choices = ["stored_transition","selected_transition","ACTION"] +list( self.transitions.keys())

				choices = list(kl.keys())

				#list_items = Variable(value=tran_choices, name="transition")
				combo_holder = ttk.Combobox(
					    win,
					    state="readonly",
					    values = choices,name="key_filter",width=width
					)

				self.widget_holder[hook] = combo_holder
				
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_key_filter)
				self.widget_holder[hook].current(default_filter_key_index)
				self.widget_holder[hook].mode = self.widget_holder[hook].get()

			
			elif input_obj["type"] == "show_mode_listbox":
				
								
				list_items = Variable(value=['desk_studio'], name=str(hook),)
				
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = ['desk_studio'],
					    name="show_mode_listbox",
					    width=width,
					    state='readonly'
					)
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)

			elif input_obj["type"] == "alt_mode_listbox":
				#hook = f"{row}_{hook}_{column}_alt_mode"
				#list_items = Variable(value= ['base','alt1'], name="alt_mode_variable")
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    state="readonly",
					    values = alt_modes,
					    name="alt_mode_listbox",
					    width=width
					)
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_alt_mode_filtering)
				self.widget_holder[hook].mode = self.widget_holder[hook].get()

		else:
			#//*** No type in keys, kinda can't do anything
			pass

		def updateField(self,txt):
			lb.delete("1.0", "end") 
			lb.insert(tk.END,txt) 
			#print(lb.get("1.0", "end"))

	def add_code(self,win):

		codes = Frame(win)
		#print("Add Code")
		#print((win.params))
		

		self.add_widgets({
		"type" : "button",
		"width" : 5,
		"action" : "delete_code",
		"text" : "X",
		"padx" : 10,
		},codes)


		self.add_widgets({
		"type" : "mos_transition_listbox",
		"width" : 20,
		"side" : LEFT,
		},codes)


		self.add_widgets({
		"type" : "mos_variable_listbox",
		"width" : 20,
		"side" : LEFT,
		},codes)


		wb.add_widgets({
			"type" : "label",
			"text" : None,
			"name" : "name_shoticon",
			"padx" : 20
		},codes)

		wb.add_widgets({
			"type" : "label",
			"text" : None,
			"name" : "name_shotname",
			"padx" : 20
		},codes)

		codes.pack(side=LEFT)
		
		win.update()

	def select_transition_combo(self,event):

		#//*** Runs whenthe  Transition value ComboBox changes
		#//*** Changes the mos_variables dropdown between codes and actions

		#//*** Get Combobox element based on the event
		tran_combo = event.widget

		parent = tran_combo.master

		#//*** If Coded, check for ACTION elements
		if tran_combo.mode == "coded":
			if tran_combo.get() == "ACTION":
				#//*** Coded Section is switched to Action Section
				#//*** Update the mos_variable list with actions
				tran_combo.mode = "action"

				
				#//*** Loop through the parent element to find mos_variable
				for elem in parent.winfo_children():

					if elem.winfo_name() == "mos_variable":
						elem['values'] = hotkey_actions
						elem.set("")

					if elem.winfo_name() == "name_shotname":
						elem.configure(text="")
						elem.mode = "action"
						

					#//*** Remove Any Image associated with the shot
					if elem.winfo_name() == "name_shoticon":
						elem.image=None

					if elem.winfo_name() == "transition_secondary":
						elem.destroy()


				#//*** Destroy Every other rule element.
				#//*** There can only be a single action per Macro
				for rule_elem in parent.master.winfo_children():
					#//*** Only Process Frames
					if rule_elem.winfo_class() == "Frame":

						not_found = True
					
					
						for elem in rule_elem.winfo_children():
							#//*** Combo Found, Keep this element
							if elem == tran_combo:
								not_found = False
								break

						if not_found:
							rule_elem.destroy()

			else:
				#//*** Coded Selected Remove and Action Comboboxes

				#//*** Destroy any other Action Element in Rule
				#//*** Destroy Every other rule element.
				#//*** There can only be a single action per Macro
				for rule_elem in parent.master.winfo_children():
					#//*** Only Process Frames
					if rule_elem.winfo_class() == "Frame":
						for elem in rule_elem.winfo_children():
							if elem.winfo_name() == "transition":
								if elem.mode == "action":
									rule_elem.destroy()
								break





		#//*** If action element, check for non-action element						
		if tran_combo.mode == "action":

			if tran_combo.get() != "ACTION":
				#//*** Action Section is switched to Coded Section
				#//*** Update the mos_variable list with Codes
				tran_combo.mode = "coded"

				#//*** Loop through the parent element to find mos_variable
				for elem in tran_combo.master.winfo_children():

					if elem.winfo_name() == "mos_variable":
						elem['values'] = list(mos_variables.keys())
						elem.set("")


	def select_mos_variable(self,event):

		mos_combo = event.widget

		parent = event.widget.master

		rule_row = parent.master

		parent.configure(bg='SystemButtonFace')

		tran_combo = None
		shotname_label = None
		for elem in parent.winfo_children():
			if elem.winfo_name() == "transition":
				tran_combo = elem

			if elem.winfo_name() == "name_shotname":
				shotname_label = elem

			if elem.winfo_name() == "name_shoticon":
				name_shoticon = elem

		#print(tran_combo)
		#print(shotname_label)
		#print(mos_combo.mode)

		#print(mos_combo.get())

		selection = mos_combo.get()

		#//*** Only update the interface if a valid mos_variable is selected
		if selection in mos_variables.keys():
			shotName = mos_variables[mos_combo.get()]['shotName']
			if shotname_label != None:

				#//*** Update the Image
				image = Image.open( io.BytesIO(mos_variables[mos_combo.get()]['image']) )
				image = ImageTk.PhotoImage(image.resize((50,50)))
				name_shoticon.configure(image=image)
				name_shoticon.image=image

				#//*** Update the Shotname Label text
				shotname_label.configure(text=shotName)


				name_shoticon.update()
				return

		#//*** Check if a Transition Action is selected
		elif selection in transition_actions:

			for key,value in self.widget_holder.items():
				if value == mos_combo:
					print("Key:",key)
					break
			
			self.add_widgets({
			"type" : "mos_transition_secondary_listbox",
			"width" : 20,
			"side" : LEFT,
			},parent)
				
			return
		



	def select_key_filter(self,event):
		print("Handle key filters")
		combo = event.widget

		#print(combo.mode,combo.get(),combo.mode == combo.get())

		if combo.mode != combo.get():
			print("New Mode Selected")

			combo.mode = combo.get()

			parent = combo.master.master

			print(parent.winfo_children(), len(parent.winfo_children()))
			for elem in parent.winfo_children():
				print()
				if "rule_row" in elem.winfo_name():
					elem.destroy()

			#//*** Destroy the Save Button
			parent.winfo_children()[-1].destroy()

		build_base_rules_from_selected_keys(row=2)
			


	def select_alt_mode_filtering(self,event):
		print("Handle Alt Mode filtering")
		combo = event.widget

		#//*** Check for newly selected alt mode selection

		if combo.mode != combo.get():
			print("New Mode Selected")

			combo.mode = combo.get()

			parent = combo.master.master

			build_base_rules_from_selected_keys()





#//*** Initialize Widget Builder Object
wb = widget_builder()

def build_first_rule_row(row=0):
	
	col=0

	rule_row = Frame(win)

	widget_row = widget_builder()


	#//*** Build Label Line
	#for x in ["Name","CTRL","WIN","SHIFT","ALT","Keyboard Key"]:
	wb.add_widgets({
		"type" : "label",
		"text" : "Name",
		"name" : "name_label",
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "ctrl_label",
		"text" : "CTRL",
		"padx" : 10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "win_label",
		"text" : "WIN",
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "shift_label",
		"text" : "SHIFT",
		"padx" : 5
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "alt_label",
		"text" : "ALT",
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "first_row",
		"text" : "Key",
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "mode_label",
		"text" : "Mode",
		"padx" : 5
	},rule_row)
	col+=1
	wb.add_widgets({
		"type" : "label",
		"name" : "code_label",
		"text" : "Codes",
		"padx" : 50
	},rule_row)
	return rule_row

def build_rule_row(row,options={}):


	rule_row = Frame(options["win"], name=f"rule_row_{row}")
	
	

	wb.add_widgets({
		"type" : "textbox",
		"name" : "name",
		"width" : 15,
	},rule_row)

	for hook in ["ctrl","win","shift","alt"]:
		
		wb.add_widgets({
			"type" : "rule_checkbox",
			"name" : hook,
			"width" : 1,
		},rule_row)

	
	text = ""
	if 'key_assign' in options.keys():
		text = options['key_assign']

	#print(options,text)

	wb.add_widgets({
		"type" : "label",
		"name" : "key",
		"text" : text,
		"width" : 5,
	},rule_row)

	#print(rule_row.winfo_children())

	
	wb.add_widgets({
		"type" : "button",
		"width" : 5,
		"action" : "add_code",
		"text" : "+",
		"padx" : 10,
	},rule_row)

	return rule_row

def build_first_control_row(row=0):
	rule_row = Frame(win,name="control_row")
	

	col = 0
	wb.add_widgets({
	"type" : "show_mode_listbox",
	"width" : 13,
	"side" : LEFT,
	},rule_row)

	col += 1
	wb.add_widgets({
	"type" : "alt_mode_listbox",
	"width" : 5,
	"side" : LEFT,
	},rule_row)

	col += 1
	wb.add_widgets({
	"type" : "key_filter_listbox",
	"width" : 5,
	"side" : LEFT,
	},rule_row)

	col += 1

	return rule_row

def build_base_rules_from_selected_keys(row=2):
	key_filter_elem = None
	for row_elem in win.winfo_children():
		if row_elem.winfo_name() == "control_row":
			for elem in row_elem.winfo_children():
				print(elem.winfo_name())
				if elem.winfo_name() == "key_filter":
					key_filter_elem = elem

				if elem.winfo_name() == "alt_mode_listbox":
					alt_mode_elem = elem

				if elem.winfo_name() == "show_mode_listbox":
					show_mode_elem = elem


				#if key_filter_elem != None and alt_mode_elem != None:
				#	break

	if key_filter_elem == None:
		print("Can't find the key filter element")
		return

	wb.reset_widgets()

	keys_to_display = kl[key_filter_elem.get()]
	
	#print(keys_to_display)

	alt_mode = alt_mode_elem.get()
	show_mode = show_mode_elem.get()

	

	all_rule_canvas = Canvas(win,
		name="all_rules_frame",
		bg='#4A7A8C',
    	width=500,
    	height=100,
    	scrollregion=(0,0,1000,1000)


    	)

	all_rule_frame = Frame(all_rule_canvas)

	row=1
	for key in keys_to_display:
		row+=1
		options = {
			'key_assign' : key,
			'show_mode' : show_mode,
			'alt_mode' : alt_mode,
			'win' : all_rule_frame
		}

		#print("BUILDING RULE")

		rule_row = build_rule_row(row,options)
		rule_row.grid(column=0, row=row, sticky="w")

		print(key, key in master_rules.keys(),show_mode,alt_mode)

		if key in master_rules.keys():

			print("Key Found")


			#//*** Determine if Rule exists for current show mode 
			if show_mode in master_rules[key].keys():
				print("Show Mode Found")

				if alt_mode in master_rules[key][show_mode].keys():

					current_rule = master_rules[key][show_mode][alt_mode]

					print(current_rule)

					for elem in rule_row.winfo_children():

						if elem.winfo_name() == "name":
							elem.delete(0,END)
							elem.insert(0,current_rule['keystroke']['name'])
						elif elem.winfo_name() == "ctrl":
							
							#//*** Click on Checkbox if True							
							if current_rule['keystroke']['ctrl']:
								elem.invoke()

						elif elem.winfo_name() == "win":

							#//*** Click on Checkbox if True							
							if current_rule['keystroke']['win']:
								elem.invoke()

						elif elem.winfo_name() == "shift":

							#//*** Click on Checkbox if True							
							if current_rule['keystroke']['shift']:
								elem.invoke()

						elif elem.winfo_name() == "alt":

							#//*** Click on Checkbox if True							
							if current_rule['keystroke']['alt']:
								elem.invoke()
		
						elif "button" in elem.winfo_name():
							
							for code in current_rule['codes']:
								#//*** Click Add Button for Code Element
								elem.invoke()

								#//*** Get Frame containing Last Child
								code_element_frame = rule_row.winfo_children()[-1]
								
								
								#//*** Rule is the Last Child Added
								for rule_elem in code_element_frame.winfo_children():
									print(rule_elem.winfo_name())
									if rule_elem.winfo_name() == "transition":
										rule_elem.set(code['transition'])

									elif rule_elem.winfo_name() == "mos_variable":
										rule_elem.set(code['mos_variable'])
										#//*** Trigger Event Handling to Draw Images
										rule_elem.event_generate("<<ComboboxSelected>>")

								#//*** Rule is the Last Child Added
								for rule_elem in code_element_frame.winfo_children():
									print("Second Pass:", rule_elem.winfo_name())
								
									if rule_elem.winfo_name() == "transition_secondary":
										rule_elem.set(code['transition_secondary'])
							pass
		#print(row)

	
	yscrollbar=Scrollbar(all_rule_canvas,orient=VERTICAL,command=all_rule_canvas.yview)
	#yscrollbar.pack(side=RIGHT,expand=True,fill=BOTH)
	
	all_rule_canvas.pack(side=TOP)
	all_rule_frame.pack(side=TOP,expand=True,fill=BOTH)
	

	#xscrollbar=Scrollbar(all_rule_canvas,orient=HORIZONTAL,command=all_rule_canvas.xview)
	#xscrollbar.pack(side=BOTTOM,expand=True,fill=BOTH)
	

	all_rule_canvas.config(width=10,height=10)
	all_rule_canvas.config(scrollregion=all_rule_canvas.bbox("all"))
	#all_rule_canvas.config(scrollregion=all_rule_canvas.bbox("all"))
	
	#all_rule_canvas['yscrollcommand'] = yscrollbar.set
	#all_rule_canvas.pack(side=TOP,expand=True, fill=BOTH)
	


	#yscrollbar.config(command=all_rule_canvas.yview)
	all_rule_canvas.config( 
		yscrollcommand=yscrollbar.set,
		#xscrollcommand=xscrollbar.set,
		)
	#all_rule_frame.config(yscrollcommand = myscrollbar.set)
	row+=1
	row=5
	col=0

	saveButton = ttk.Button(win, 
		text="Save", 
		width=25, 
		name="save_button",
		command=partial(save_macros,win) ,
		)

	#saveButton.grid(column=col,row=row,stick="w")
	saveButton.pack(side=LEFT)
	quitButton = ttk.Button(win, 
		text="Cancel", 
		width=25,
		name="quit_button", 
		command=partial(quit_macros,win) ,
		)
	col=6
	#quitButton.grid(column=col,row=row,stick="e")
	quitButton.pack(side=RIGHT)

	return

def validate_rule(rule,rule_frame):

	valid = True
	error = {
		"name" : False,
		"modifier" : True,
		"mos_variable" : False,
	}

	#//*** Test for Rule Name
	rule_name = rule['keystroke']['name']

	#//*** Remove all Spaces
	rule_name = rule_name.replace(" ","")

	if len(rule_name) == 0:
		#//*** Needs Rule Name
		valid = False
		error["name"] = True

	#//*** Test if Modifier is selected
	for x in ['ctrl','win','shift','alt']:
		#//*** If Any modifier is True, then this section passes
		if rule['keystroke'][x]:
			error["modifier"] = False
			break

	if error["modifier"]:
		valid = False


	#//*** Draw background Color for All Elements

	#//*** Loop through each element
	for elem in rule_frame.winfo_children():
		
		if elem.winfo_name() == 'name':

			#//*** Draw Error Background
			if error["name"]:
				elem.configure(bg=colors["bg_error"])

			#//*** Draw Normal Background
			else:
				elem.configure(bg=colors["bg_normal"])

		#//*** Check if Checkbox Name
		if elem.winfo_name() in checkbox_names:
			if error["modifier"]:
				elem.configure(bg=colors["bg_error"])

			#//*** Draw Normal Background
			else:
				elem.configure(bg=colors["bg_normal"])


		if "frame" in elem.winfo_name():

			#//**** Check Each Codes Element in Frame
			frame = elem

			for rule_elem in frame.winfo_children():

				if 'mos_variable' in rule_elem.winfo_name():

					#//*** Check for Valid Value
					#//*** Throw Error if Empty
					if len(rule_elem.get()) == 0:
						frame.configure(bg=colors["bg_error"])
						valid = False

					#//*** Draw Normal Background
					else:
						frame.configure(bg=colors["bg_normal"])






	return valid

def quit_macros(win):
	win.destroy()

def save_macros(win):
	rules = []
	

	error_found = False
	show_mode = ""
	alt_mode = ""
	for rule_frame in win.winfo_children():
		
		first_row = False

		print(rule_frame.winfo_name())

		if rule_frame.winfo_name() == "control_row":
			for control_elem in rule_frame.winfo_children():
				
				if control_elem.winfo_name() == "show_mode_listbox":
					show_mode = control_elem.get()
					#rule['show_mode'] = elem.get()
				elif control_elem.winfo_name() == "alt_mode_listbox":
					#rule['alt_mode'] = elem.get()
					alt_mode = control_elem.get()
		

		if rule_frame.winfo_name() == "all_rules_frame":


			#//*** Drill down to rule Lists
			for rule_row in list(rule_frame.winfo_children())[0].winfo_children():

				print(rule_row.winfo_name())
				
				#if  "_label" in rule_row.winfo_name():
				#	first_row = True
				#	continue

				if "rule_row" in rule_row.winfo_name():
					rule = {

						"keystroke" : {},
						"codes" : [],
						'show_mode' :show_mode,
						"alt_mode" : alt_mode

					}

					for elem in rule_row.winfo_children():

						if elem.winfo_name() == "name":
							rule['keystroke']['name'] = elem.get()

						elif elem.winfo_name() == "ctrl":
							rule['keystroke']['ctrl'] = elem.variable.get() 
							
						elif elem.winfo_name() == "win":
							rule['keystroke']['win'] = elem.variable.get() 

						elif elem.winfo_name() == "shift":
							rule['keystroke']['shift'] = elem.variable.get() 

						elif elem.winfo_name() == "alt":
							rule['keystroke']['alt'] = elem.variable.get() 

						elif elem.winfo_name() == "key":
							rule['keystroke']['key'] = elem.cget("text")

						elif "frame" in elem.winfo_name():
							#//*** Handle Rule Elements


							#//*** Call elem frame for clarity
							frame = elem

							#//*** New Dictionary to handle the components. Maybe this should be a class?
							rule_component = {}

							#//*** Cycle through Rule elements and build rule_component dictionary
							for rule_elem in frame.winfo_children():

								#//*** Hard code Rule Values. Update this section when adding new Rules.
								print("Rule_Elem Name: ", rule_elem.winfo_name() )
								if rule_elem.winfo_name() == "transition":
									rule_component["transition"] = rule_elem.get()
								elif rule_elem.winfo_name() == "mos_variable":
									rule_component["mos_variable"] = rule_elem.get()
								elif rule_elem.winfo_name() == "transition_secondary":
									rule_component["transition_secondary"] = rule_elem.get()

							if rule_component["transition"] == "selected_transition":
								rule_component["use_tran"] = True
							else:
								rule_component["use_tran"] = False


							if rule_component["mos_variable"] in mos_variables.keys():
								
								rule_component["mos"] = mos_variables[ rule_component["mos_variable"] ]["mos"]

								#//*** If value is hard coded transition, assign transition value
								if rule_component["transition"] in list(transitions.keys()):
									rule['transition'] = rule_component["transition"]

							else:
								#//*** Is an Item Selected?
								if len(rule_component["mos_variable"]) == 0:
									#//*** MOS Variable is empty, skip this element
									continue

								if rule_component["transition"] == "ACTION":
									print("This is an Action ELement")
									print(rule_component["transition"],rule_component["mos_variable"])
									rule['function'] = rule_component["mos_variable"]

									if rule_component["mos_variable"] == "enter_exit_script":
										rule['key'] = enter_script_key

									#//*** Check if assigning a transition
									if rule_component["transition_secondary"] in rule_component.keys():
										rule["transition_secondary"] = rule_component["transition_secondary"]

								print(rule)

							

							
							#//*** Rule component to rule elements
							rule["codes"].append(rule_component)
					


							if len(rule["codes"]) == 0:
								#//*** No Codes assigned, skip rule, treat it as empty.
								continue
								
							valid_rule = validate_rule(rule,rule_frame)

							if not valid_rule:
								error_found = True


							rules.append(rule)

		#if first_row:
		#	continue
	#for rule in rules:
	#	print(rule)
	
	#//*** Add Rules to Master_Rules
	
	if not error_found:
		#//*** No Errors, Integrate into Master Rules

		for rule in rules:

			print(rule)

			keyboard_key = rule['keystroke']['key']
			show_mode = rule["show_mode"]
			alt_mode = rule["alt_mode"]

			#//*** Check if keyabord key exists in master_rules

			#//*** Build New Key. Store Rule under Show mode and Alt mode dictionaries
			if keyboard_key not in master_rules.keys():
				master_rules[keyboard_key] = { }
			
			#//*** Check if Show Mode Entry exists
			if show_mode not in master_rules[keyboard_key].keys():
				master_rules[keyboard_key][ show_mode ] = { }
				 
			#//*** Assign rule to alt mode value, overwriting existing
			master_rules[keyboard_key][ show_mode ][ alt_mode ] = rule


		#//*** Save Master Rules to Disk

		with open(master_hotkey_filename, "w") as outfile:
			outfile.write(json.dumps(master_rules, indent=4))

		

win.resizable(1,1)


row = 0
#//*** Build First Row Containing basic Controls
#build_first_control_row(row).grid(column=0, row=row, sticky="w")

build_first_control_row(row).pack(side=TOP, anchor=W)
row+=1


#//*** Build the First Rule Rule which Contain Labels
#build_first_rule_row(row).grid(column=0, row=row, sticky="w")
build_first_rule_row(row).pack(side=TOP,anchor=W)
row +=1

#//*** Draw Rules based on Default Filters
build_base_rules_from_selected_keys(2)



win.overrideredirect(False)
win.attributes('-topmost',True)

#ADDING A SCROLLBAR

win.mainloop()
