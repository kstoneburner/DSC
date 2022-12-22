#//*** Check Box
#https://www.pythontutorial.net/tkinter/tkinter-checkbox/
#import keyboard #pip install keyboard
import win32gui, os, sys
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
base_vo = "<mos><mosID>kgo.pcr2.ovd.mos</mosID><itemID>0</itemID><mosAbstract>v3 VO - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Video Only</mosAbstract><objSlug>v3 VO - Ross Video - Transition: 1_CUT _CLRG1 - Audio AFV: Video Only</objSlug><mosPlugInID>Ross.Inception</mosPlugInID><objID>5bc956d2910de</objID><mosItemEditorProgID>RossClem.RossEditor</mosItemEditorProgID><objDur>1</objDur><objTB>60</objTB><abstract/><itemSlug/><mosExternalMetadata><mosScope>PLAYLIST</mosScope><mosSchema>http:'rossvideo.com/schemas/MOS/external/1.0</mosSchema><mosPayload><shotID>33135</shotID><dbAppVersion><major>18</major><minor>4</minor><revision>11</revision><build>6170</build></dbAppVersion><dbTemplate><templateNumber>1101</templateNumber><shotName>v3 VO</shotName><imageURL>/icons/KGO/v2 Server/v2 VO.png</imageURL><transition><id>39</id><name>1_CUT _CLRG1</name></transition><mleList><id>37741</id></mleList><afvLevel>-3</afvLevel><additionalAudioList><additionalAudio><id>-1</id><order>1</order><audio><id>35975</id><name>BRIO STUV##ME##0##BUS##program</name><type>DEVICE</type></audio><customLevel>50</customLevel><overrideState>OVERRIDE_ON</overrideState></additionalAudio></additionalAudioList><floorDirectorCueNote/><floorDirectorCueNoteEnabled>false</floorDirectorCueNoteEnabled></dbTemplate><icon>/icons/KGO/v2 Server/v2 VO.png</icon></mosPayload></mosExternalMetadata></mos>"
connected = False
quit=False
transitions = load_transitions()
mos_variables = load_mos_object_variables()
alt_modes = load_alt_modes()
show_modes = load_show_modes()
hotkey_actions = load_hotkey_actions()
kl = load_keyboard_key_list()

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
		hook = None
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

			if verify_key == "hook":
				hook = input_obj["hook"]

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

		#if row == -1:
		#	print("QUITTING widget: Widget missing Row attribute")
		#	print(input_obj)
		#	return

		#if column == -1 and columnspan == -1:
		#	print(column,columnspan)
		#	print("QUITTING widget: Widget missing Column attribute")
		#	print(input_obj)
		#	return

		if obj_type == None:
			print("QUITTING widget: Widget missing type attribute")
			print(input_obj)
			return

		#//*** Build Grid Object to handle row, column, columspan values
		grid = { "sticky" : "W"}

		if row != -1:
			grid["row"] = row

		if column != -1:
			grid["column"] = column
		else:
			grid["columnspan"] = columnspan

		#//*** Process the object types: Labels, buttons, etc
		if "type" in input_obj.keys():

			if input_obj["type"] == "label":

				if "text" in input_obj.keys():
					options["text"] = input_obj["text"]

				options["width"] = width

				options['name'] = name


				if hook == None:
					#//*** No Hook, just draw the label
					Label(win,options).grid(grid)

				else:
					#//*** Build Label
					self.widget_holder[hook] = Label(win,options)

					#//*** Draw Label
					self.widget_holder[hook].grid(grid)


			if input_obj["type"] == "button":

				if action == "add_code":

					options['command'] = self.add_code

				if action == "delete_code":
					#//***destroy parent Frame
					options['command'] =win.destroy

				if hook == None:
					ttk.Button(win, text=options["text"], width=width, command=options['command']).pack(side=side)
				else:
					
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
				hook = f"{row}_{hook}_{column}"

				var = BooleanVar(win, name=hook,value=check_value)

				#print("Check Hook:",hook)
				
				self.widget_holder[hook] = Checkbutton(win, text=text, name=name, variable=var, width=width)
				self.widget_holder[hook].variable = var
				#print(win.getvar(name=hook))
				
				#self.widget_holder[hook].grid(grid)
				self.widget_holder[hook].pack(side=side)

			if input_obj["type"] == "label":

				#//*** Build a Unique Variable name based Hook, row and Col values
				Label(win, text=options["text"], name=name, padx=padx).grid(grid)
				
			if input_obj["type"] == "textbox":
				hook = f"{row}_{hook}_{column}"

				#var = BooleanVar(win, name=name,value=check_value)

				#//*** Build a Unique Variable name based Hook, row and Col values
				#Entry(win, width=width).grid(grid)
				
				entry = Entry(win, width=width, name=name)
				entry.insert(0,text)
				entry.pack(side=side)
				
			if input_obj["type"] == "mos_variable_listbox":

				hook = f"{row}_{hook}_{column}"

				print("mos_variable_listbox")
				
				height = 10
				list_items = Variable(value=list(self.mos_variables.keys()), name=hook)
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = list(self.mos_variables.keys()),name="mos_variable"
					).pack(side=side)

			elif input_obj["type"] == "mos_transition_listbox":
				hook = f"{row}_{hook}_{column}"
				
				tran_choices = ["stored_transition","selected_transition","ACTION"] +list( self.transitions.keys())

				list_items = Variable(value=tran_choices, name="transition")
				combo_holder = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = tran_choices,name="transition",width=width
					)

				self.widget_holder[hook] = combo_holder
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_transition_combo)
				self.widget_holder[hook].mode = "coded"
			
			elif input_obj["type"] == "key_filter_listbox":
				hook = f"{row}_{hook}_{column}"
				
				#tran_choices = ["stored_transition","selected_transition","ACTION"] +list( self.transitions.keys())

				choices = list(kl.keys())

				#list_items = Variable(value=tran_choices, name="transition")
				combo_holder = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = choices,name="key_filter",width=width
					)

				self.widget_holder[hook] = combo_holder
				
				self.widget_holder[hook].pack(side=side)
				self.widget_holder[hook].bind("<<ComboboxSelected>>", self.select_key_filter)
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].mode = self.widget_holder[hook].get()

			
			elif input_obj["type"] == "show_mode_listbox":
				hook = f"{row}_{hook}_{column}"
				
								
				list_items = Variable(value=['desk_studio'], name=hook,)
				
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = ['desk_studio'],
					    name="show_mode_listbox",
					    width=width
					)
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)

			elif input_obj["type"] == "alt_mode_listbox":
				hook = f"{row}_{hook}_{column}_alt_mode"
				#list_items = Variable(value= ['base','alt1'], name="alt_mode_variable")
				self.widget_holder[hook] = ttk.Combobox(
					    win,
					    #state="readonly",
					    values = alt_modes,
					    name="alt_mode_listbox",
					    width=width
					)
				self.widget_holder[hook].current(0)
				self.widget_holder[hook].pack(side=side)


#show_mode_listbox
#show_modes
#alt_modes
		else:
			#//*** No type in keys, kinda can't do anything
			pass

		def updateField(self,txt):
			lb.delete("1.0", "end") 
			lb.insert(tk.END,txt) 
			print(lb.get("1.0", "end"))

	def add_code(self,win):

		codes = Frame(win)
		print("Add Code")
		print((win.params))
		win.params["elems"] += 1
		row = win.params["elems"] +1
		col = 6


		self.add_widgets({
		"type" : "button",
		"row" : row,
		"column" : col,
		"hook" : "delete_code",
		"width" : 5,
		"action" : "delete_code",
		"text" : "X",
		"padx" : 10,
		},codes)


		col += 1
		self.add_widgets({
		"type" : "mos_transition_listbox",
		"row" : row,
		"column" : col,
		"hook" : f"tran_var__{col}",
		"width" : 20,
		"side" : LEFT,
		},codes)


		col += 1
		self.add_widgets({
		"type" : "mos_variable_listbox",
		"row" : row,
		#"column" : col,
		"hook" : f"mos_var__{col}",
		"width" : 20,
		"side" : LEFT,
		},codes)

		codes.pack(side=LEFT)
		
		win.update()

	def select_transition_combo(self,event):

		#//*** Runs whenthe  Transition value ComboBox changes
		#//*** Changes the mos_variables dropdown between codes and actions

		#//*** Get Combobox element based on the event
		combo = event.widget

		#//*** If Coded, check for ACTION elements
		if combo.mode == "coded":
			if combo.get() == "ACTION":
				#//*** Coded Section is switched to Action Section
				#//*** Update the mos_variable list with actions
				combo.mode = "action"

				#//*** Loop through the parent element to find mos_variable
				for elem in combo.master.winfo_children():

					if elem.winfo_name() == "mos_variable":
						elem['values'] = hotkey_actions

						elem.set("")

		#//*** If action element, check for non-action element						
		if combo.mode == "action":
			if combo.get() != "ACTION":
				#//*** Action Section is switched to Coded Section
				#//*** Update the mos_variable list with Codes
				combo.mode = "coded"

				#//*** Loop through the parent element to find mos_variable
				for elem in combo.master.winfo_children():

					if elem.winfo_name() == "mos_variable":
						elem['values'] = list(mos_variables.keys())
						elem.set("")

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
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "ctrl_label",
		"text" : "CTRL",
		"row" : row,
		"column" : col,
		"padx" : -10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "win_label",
		"text" : "WIN",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "shift_label",
		"text" : "SHIFT",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "alt_label",
		"text" : "ALT",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "first_row",
		"text" : "Key",
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"name" : "code_label",
		"text" : "Codes",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1
	return rule_row

def build_rule_row(row,options={}):

	col = 0

	rule_row = Frame(win, name=f"rule_row_{row}")
	widget_row = widget_builder()
	
	rule_row.params = {
		"elems" : 0
	}
	
	widget_row.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		#"hook" : "name",
		"name" : "name",
		"width" : 15,
	},rule_row)

	for hook in ["ctrl","win","shift","alt"]:
		col = col + 1
		wb.add_widgets({
			"type" : "rule_checkbox",
			"row" : row,
			"column" : col,
			#"hook" : hook,
			"name" : hook,
			"width" : 1,
		},rule_row)

	col = col + 1
	text = ""
	if 'key_assign' in options.keys():
		text = options['key_assign']
	print(options,text)
	wb.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		"hook" : "key",
		"name" : "key",
		"text" : text,
		"width" : 5,
	},rule_row)

	print(rule_row.winfo_children())

	"""
	col += 1
	wb.add_widgets({
	"type" : "show_mode_listbox",
	#"row" : row,
	#"column" : col,
	"hook" : f"mode_var__{col}",
	"width" : 13,
	"side" : LEFT,
	},rule_row)
	"""

	col += 1
	wb.add_widgets({
	"type" : "alt_mode_listbox",
	#"row" : row,
	#"column" : col,
	"hook" : f"alt_mode_var__{col}",
	"width" : 5,
	"side" : LEFT,
	},rule_row)


	col = col + 1
	wb.add_widgets({
		"type" : "button",
		"row" : row,
		"column" : col,
		"hook" : "add_rule",
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
	#"row" : row,
	#"column" : col,
	"hook" : f"mode_var__{col}",
	"width" : 13,
	"side" : LEFT,
	},rule_row)

	col += 1

	wb.add_widgets({
	"type" : "key_filter_listbox",
	#"row" : row,
	#"column" : col,
	"hook" : f"key_filter_var__{col}",
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
					break


			break

	if key_filter_elem == None:
		print("Can't find the key filter element")
		return

	keys_to_display = kl[key_filter_elem.get()]
	print(keys_to_display)

	all_rule_frame = Frame(win,name="all_rules_frame")

	for key in keys_to_display:
		row+=1
		options = {
			'key_assign' : key
		}

		print("BUILDING RULE")

		rule_row = build_rule_row(row,options)
		rule_row.grid(column=0, row=row, sticky="w")
		
		print(row)


	row+=1
	col=0

	saveButton = ttk.Button(win, 
		text="Save", 
		width=25, 
		command=partial(save_macros,win) ,
		)

	saveButton.grid(column=col,row=row,stick="w")

	return

x_coord = {
	"name" : 0,
	"ctrl" : 60,
	"win" : 90,
	"shift" : 120,
	"alt" : 160,
	"key" : 200,
}

def save_macros(win):
	rule = {}
	for rule_frame in win.winfo_children():
		first_row = False
		#print("Frame Level")
		#print(rule_frame)
		#print(rule_frame.winfo_children())
		print("Row Level")
		for elem in rule_frame.winfo_children():
			#print(elem)
			print("Name: ",elem.winfo_name())
			if  "_label" in elem.winfo_name():
				first_row = True
				break
			#print(dir(elem))
			#print(elem.widgetName, elem.widgetName == 'checkbutton',elem.widgetName == 'ttk::button', elem.widgetName =='entry')
			#if elem.widgetName == 'entry':
			#	print(elem.winfo_name())
			#	print("Entry:", elem.get())

			if elem.winfo_name() == "name":
				rule['name'] = elem.get()

			elif elem.winfo_name() == "ctrl":
				rule['ctrl'] = elem.variable.get() 
				
			elif elem.winfo_name() == "win":
				rule['win'] = elem.variable.get() 

			elif elem.winfo_name() == "shift":
				rule['shift'] = elem.variable.get() 

			elif elem.winfo_name() == "alt":
				rule['alt'] = elem.variable.get() 

			elif elem.winfo_name() == "key":
				rule['key'] = elem.get() 
				



			print(elem.winfo_cells())
		if first_row:
			continue
			
		print(rule)

	win.destroy()


win.resizable(1,1)


row = 0
build_first_control_row(row).grid(column=0, row=row, sticky="w")
row+=1

build_first_rule_row(row).grid(column=0, row=row, sticky="w")
row +=1



build_base_rules_from_selected_keys(2)



win.overrideredirect(False)
win.attributes('-topmost',True)
win.mainloop()
