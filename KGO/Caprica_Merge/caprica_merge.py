# https://pythonbasics.org/tkinter-filedialog/
# https://pythonguides.com/python-tkinter-text-box/


# Import the required Libraries
from tkinter import *
from tkinter import ttk, filedialog
from tkinter.filedialog import askopenfile
from functools import partial

# Create an instance of tkinter frame
win = Tk()

# Set the geometry of tkinter frame
win.geometry("700x250")



class widget_builder():

	def __init__(self):
		self.widget_holder = {}
		self.merge_source_filename = None
		self.merge_target_label = None
	
	def open_file(self,target):
		name = filedialog.askopenfilename(filetypes=[('Python Files', '*.py')]) 

		print(self.widget_holder)
		if name:
			if target == "merge_source_filename":
				self.merge_source_filename = name
				self.widget_holder["merge_source_label"]["text"] = name

			if target == "merge_target_filename":
				self.merge_target_label = name
				self.widget_holder["merge_target_label"]["text"] = name

	def add_widgets(self,input_obj,win=win):

		options = {}


		if "options" in input_obj.keys():

			options = input_obj["options"]

		options["text"] = "No Text Specified"

		row = -1
		column = -1
		columnspan = -1
		obj_type = None
		hook = None
		action = None
		target = None
		text = None

		width = -1
		
		for verify_key in ["row","column", "type", "hook", "action", "target", "text", "columnspan", "width"]:

			if verify_key in input_obj.keys():

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

		grid = {}

		if row != -1:
			grid["row"] = row

		if column != -1:
			grid["column"] = column
		else:
			grid["columnspan"] = columnspan

		print(row,column)

		if "type" in input_obj.keys():

			if input_obj["type"] == "label":

				

				if "text" in input_obj.keys():
					options["text"] = input_obj["text"]

				options["width"] = width
				#label = Label(win, text="Click the Button to browse the Files", font=('Georgia 13'))

				#if "text" input_obj.keys():
				#options["text"] = input_obj["text"]

				if hook == None:
					#//*** No Hook, just draw the label
					Label(win,options).grid(grid)
				else:
					#//*** Build Label
					self.widget_holder[hook] = Label(win,options)

					#//*** Draw Label
					self.widget_holder[hook].grid(grid)


			if input_obj["type"] == "button":

				if action == "select_filename":

					options['command'] = self.open_file



					if hook == None:
						ttk.Button(win, text=options["text"], width=width, command=self.open_file).grid(grid)
					else:
						#//*** Build Hooked Button
						self.widget_holder[hook] = ttk.Button(win, text=options["text"], width=width, command=partial(self.open_file,target) )

						#//*** Draw Hooked Button
						self.widget_holder[hook].grid(grid)


		else:
			#//*** No type in keys, kinda can't do anything
			pass

wb = widget_builder()
widgets = [
{
	"type" : "label",
	"text" : "Source Caprica Files",

	"row" : 0,
	"columnspan" : 2,
	"options" : {
		"font" : "Georgia 15",
	}
},

{
	"type" : "button",
	"hook" : "merge_source",
	"text" : "Browse",
	"width" : 10,
	"row" : 1,
	"column" : 0,
	"action" : "select_filename",
	"target" : "merge_source_filename",
},

{
	"type" : "label",
	"text" : "No File Selected",
	"hook" : "merge_source_label",
	"width" : 50,
	"row" : 1,
	"column" : 1,
	"options" : {
		"font" : "Georgia 10",
	}
},

{
	"type" : "label",
	"text" : " ",

	"row" : 2,
	"columnspan" : 2,
	"options" : {
		"font" : "Georgia 20",
	}
},
{
	"type" : "label",
	"text" : "Target Caprica Files",

	"row" : 3,
	"columnspan" : 2,
	"options" : {
		"font" : "Georgia 15",
	}
},

{
	"type" : "button",
	"hook" : "merge_target",
	"text" : "Browse",
	"width" : 10,
	"row" : 4,
	"column" : 0,
	"action" : "select_filename",
	"target" : "merge_target_filename",
},

{
	"type" : "label",
	"text" : "No File Selected",
	"hook" : "merge_target_label",
	"width" : 50,
	"row" : 4,
	"column" : 1,
	"options" : {
		"font" : "Georgia 10",
	}
},
]

for widget in widgets:
	wb.add_widgets(widget)

# Add a Label widget
#label = Label(win, text="Click the Button to browse the Files", font=('Georgia 13'))
#label.pack(pady=10)
#label.grid(row=0, column=0)



# Create a Button
##ttk.Button(win, text="Browse", command=open_file).pack(pady=20)
#ttk.Button(win, text="Browse", command=open_file).grid(row=0,column=1)

message ='''
Dear Reader,

    Thank you for giving your
    Love and Support to PythonGuides.
    PythonGuides is now available on 
    YouTube with the same name.

Thanks & Regards,
Team PythonGuides '''

#text_box = Text(
#    win,
#    height=12,
#    width=40
#)
#text_box.pack(expand=True)
#text_box.grid(row=1,column=0)
#text_box.insert('end', message)
#text_box.config(state='disabled')

win.mainloop()