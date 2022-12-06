import tkinter as tk

#from tkinterdnd2 import DND_FILES, DND_ALL, TkinterDnD

def updateField(txt):
	lb.delete("1.0", "end") 
	lb.insert(tk.END,txt) 
	print(lb.get("1.0", "end"))
#root = TkinterDnD.Tk()  # notice - use this instead of tk.Tk()
root = tk.Tk()  # notice - use this instead of tk.Tk()

lb = tk.Text(root)
lb = tk.LabelFrame(root)
#lb.insert('end',"drag files to here")

# register the listbox as a drop target
#lb.drop_target_register(DND_ALL)

#lb.dnd_bind('<<Drop>>', lambda e: updateField(e.data))
lb.drop_target_register(DND_TEXT)
lb.pack()
root.mainloop()