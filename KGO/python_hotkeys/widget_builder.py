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
