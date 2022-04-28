#//*************************************************************************************************************************
#//*** Build Executable:
#//*** https://towardsdatascience.com/convert-your-python-code-into-a-windows-application-exe-file-28aa5daf2564
#//*************************************************************************************************************************

import pandas as pd
import os
from pathlib import Path
from io import StringIO
#import matplotlib.pyplot as plt

# Defining main function
def main():
	current_dir = Path(os.getcwd()).absolute()

	for filename in os.listdir(current_dir):
		if ".csv" in filename.lower():
			print(filename)

			#df = pd.read_csv(filename)
			i = 0
			head_1 = ""
			head_2 = ""
			out = ""
			with open(filename,'r') as f:
				found = False
				for line in f.readlines():
					if "freeform table" in line.lower():
						found = True

					if found == True:

						if i == 2:
							head_1 = line[1:]

						if i == 3:
							out=f'{line.split(",")[0]},{head_1}'

						if i > 3:
							out += line
						i+=1

			
			df = pd.read_csv(StringIO(out))
			cols = list(df.columns)
			df[cols[0]] = pd.to_datetime(df[cols[0]])
			
			export_df = df.groupby(pd.Grouper(key=cols[0], axis=0, freq='30min')).sum()

			output_filename = str(filename)
			output_filename = output_filename.replace(".csv",".xlsx")
			# Create a Pandas Excel writer using XlsxWriter as the engine.
			writer = pd.ExcelWriter(output_filename, engine='xlsxwriter')
			df.to_excel(writer,sheet_name="Unique Viewers")
			try:
				writer.save()
			except:
				print("Trouble Saving the Spreadsheet. It's Probably Open Somewhere. Close it and Retry")    


			#plt.figure(figsize=(12, 8))
			#plt.style.use('fivethirtyeight')
			#plt.plot(df[cols[0]],df[cols[1]], label=cols[1])
			#plt.legend()
			#plt.xlabel(cols[0])
			#plt.ylabel(cols[1])

			# saving the file 
			#plt.savefig(str(filename).replace(".csv",".jpg")) 

			

# Using the special variable 
# __name__
if __name__=="__main__":
    main()