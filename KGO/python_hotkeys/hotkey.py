#//*** Check Box
#https://www.pythontutorial.net/tkinter/tkinter-checkbox/
#import keyboard #pip install keyboard
import win32gui, os, sys
#//*** Options are 0 or 2
sys.coinit_flags = 2

#import time, threading, pyperclip

#from pywinauto import application
import pyautogui

import tkinter as tk

from tkinterdnd2 import DND_FILES, DND_ALL, TkinterDnD

def updateField(txt):
	lb.delete("1.0", "end") 
	lb.insert(tk.END,txt) 
	print(lb.get("1.0", "end"))
	
win = TkinterDnD.Tk()  # notice - use this instead of tk.Tk()

win.title("Dalet Hotkeys")

from tkinter import *
from tkinter import ttk, filedialog
from tkinter.filedialog import askopenfile

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
#print("!")
#r = os.popen('tasklist /v').read().strip().split('\n')

#cmd = 'tasklist /FI "imagename eq DaletGalaxy.exe" /v'
#print(os.popen(cmd).read())

# https://pythonbasics.org/tkinter-filedialog/
# https://pythonguides.com/python-tkinter-text-box/
#//*** pyinstaller --onefile caprica_merge.py -n KGO_Caprica_CC_Merge


class widget_builder():

	def __init__(self):
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
		hook = None
		action = None
		target = None
		text = ""
		width = -1
		check_value = False
		padx = 0
		
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

			if verify_key == "columnspan":
				columnspan = input_obj["columnspan"]

			if verify_key == "width":
				width = input_obj["width"]

			if verify_key == "value":
				check_value = input_obj["value"]

			if verify_key == "padx":
				padx = input_obj["padx"]

		if row == -1:
			print("QUITTING widget: Widget missing Row attribute")
			print(input_obj)
			return

		if column == -1 and columnspan == -1:
			print(column,columnspan)
			print("QUITTING widget: Widget missing Column attribute")
			print(input_obj)
			return

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




				if hook == None:
					ttk.Button(win, text=options["text"], width=width, command=options['command']).grid(grid)
				else:
					#//*** Build Hooked Button
					self.widget_holder[hook] = ttk.Button(win, 
						text=options["text"], 
						width=width, 
						command=partial(options['command'],win) ,
						)

					#//*** Draw Hooked Button
					self.widget_holder[hook].grid(grid)

			if input_obj["type"] == "rule_checkbox":

				#//*** Build a Unique Variable name based Hook, row and Col values
				#hook = f"{row}_{hook}_{col}"
				var = BooleanVar(win, name=hook,value=check_value)
				
				self.widget_holder[hook] = Checkbutton(win, text=text, variable=var, width=width)
				#print(win.getvar(name=hook))
				
				self.widget_holder[hook].grid(grid)

			if input_obj["type"] == "label":

				#//*** Build a Unique Variable name based Hook, row and Col values
				Label(win, text=options["text"], padx=padx).grid(grid)
				
			if input_obj["type"] == "textbox":
				hook = f"{row}_{hook}_{column}"
				var = BooleanVar(win, name=hook,value=check_value)

				#//*** Build a Unique Variable name based Hook, row and Col values
				Entry(win, width=width).grid(grid)
				
			if input_obj["type"] == "dnd":

				hook = f"{row}_{hook}_{column}"
				var = BooleanVar(win, name=hook,value=check_value)

				#//*** Build a Unique Variable name based Hook, row and Col values
				#Entry(win, width=width).grid(grid)
				
				
				self.widget_holder[hook] = Entry(win)
				#lb.insert('end',"drag files to here")

				# register the listbox as a drop target
				self.widget_holder[hook].drop_target_register(DND_ALL)
				self.widget_holder[hook].dnd_bind('<<Drop>>', lambda e: self.updateField(e.data))	

		else:
			#//*** No type in keys, kinda can't do anything
			pass

		def updateField(self,txt):
			lb.delete("1.0", "end") 
			lb.insert(tk.END,txt) 
			print(lb.get("1.0", "end"))

		"""
		def updateField(txt):
			lb.delete("1.0", "end") 
			lb.insert(tk.END,txt) 
			print(lb.get("1.0", "end"))
		root = TkinterDnD.Tk()  # notice - use this instead of tk.Tk()

		lb = tk.Text(root)
		lb.insert('end',"drag files to here")

		# register the listbox as a drop target
		lb.drop_target_register(DND_ALL)
		lb.dnd_bind('<<Drop>>', lambda e: updateField(e.data))			
		"""
	
	def add_code(self,win):
		print("Add Code")
		print((win.params))
		win.params["elems"] += 1
		row = win.params["elems"]
		col = 6

		self.add_widgets({
		"type" : "rule_checkbox",
		"row" : row,
		"column" : col,
		"hook" : f"tran_{col}",
		"width" : 1,
		},win)

		col += 1
		self.add_widgets({
		"type" : "dnd",
		"row" : row,
		"column" : col,
		"hook" : f"code_{col}",
		"width" : 100,
		},win)

		
		win.update()
def update_window():
	time.sleep(3)
	print("update")
	print(win.getvar(name="b"))





#//*** Initialize Widget Builder Object
wb = widget_builder()

def build_first_rule_row():
	row=0
	col=0

	rule_row = Frame(win)

	widget_row = widget_builder()


	#//*** Build Label Line
	#for x in ["Name","CTRL","WIN","SHIFT","ALT","Keyboard Key"]:
	wb.add_widgets({
		"type" : "label",
		"text" : "Name",
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "CTRL",
		"row" : row,
		"column" : col,
		"padx" : -10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "WIN",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "SHIFT",
		"row" : row,
		"column" : col,
		"padx" : 0
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "ALT",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "Key",
		"row" : row,
		"column" : col,
		"padx" : 20
	},rule_row)
	col+=1

	wb.add_widgets({
		"type" : "label",
		"text" : "Codes",
		"row" : row,
		"column" : col,
		"padx" : 10
	},rule_row)
	col+=1
	return rule_row

def build_rule_row():


	row = 0
	col = 0

	rule_row = Frame(win)
	widget_row = widget_builder()
	
	rule_row.params = {
		"elems" : 0
	}
	
	widget_row.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		"hook" : "name",
		"width" : 15,
	},rule_row)

	for hook in ["CTRL","WIN","SHIFT","ALT"]:
		col = col + 1
		wb.add_widgets({
			"type" : "rule_checkbox",
			"row" : row,
			"column" : col,
			"hook" : hook,
			"width" : 1,
		},rule_row)

	col = col + 1
	wb.add_widgets({
		"type" : "textbox",
		"row" : row,
		"column" : col,
		"hook" : "key",
		"width" : 5,
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


#Label(win, text=options["text"]).grid(grid)


#Label(widget_row, text="1").grid(column=0, row=0)
#Label(widget_row, text="2").grid(column=1, row=0)
#Label(widget_row, text="3").grid(column=2, row=0)
#Label(widget_row, text="4").grid(column=3, row=0)
row=0
build_first_rule_row().grid(column=0, row=row, sticky="w")
row +=1

build_rule_row().grid(column=0, row=row, sticky="w")
row +=1
col=0
build_rule_row().grid(column=0, row=row, sticky="w")
row +=1
col=0
build_rule_row().grid(column=0, row=row, sticky="w")
#win.update()
#//*** Run the GUI
win.mainloop()
