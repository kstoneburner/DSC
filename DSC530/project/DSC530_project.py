import xlrd # pandas dependency
import numpy as np
import pandas as pd
import os
###
g = {
    'remove_cols': ['username', 'payroll_id', 'fname', 'lname', 'number', 'group','local_day', 'local_start_time', 'local_end_time', 'tz', 'location', 'notes', 'approved_status'],
    'obsfuscate': {},
}
curDir = os.getcwd()

fileList = os.listdir(curDir + "\\orig")

employee_counter = 0

for fname in fileList:
    ### For each Excel File
    if ".xlsx" in fname:

        # //*** Build Generic Employee value
        employee_counter = employee_counter + 1

        # //*** Each employee is EMP_ with a number
        generic_name = f"EMP_{employee_counter}"

        loop_df = pd.read_excel(curDir+"\\orig\\"+fname,1)

        print(loop_df.loc[0,'fname'])
        print(loop_df.loc[0, 'lname'])

        loop_user_details = {
            'generic_name': generic_name,
            'fname': loop_df.loc[0, 'fname'],
            'lname': loop_df.loc[0, 'lname'],
            'group': loop_df.loc[0, 'group'],
        }
        print(loop_df.columns.values.tolist())

        ### Remove unneeded columns
        loop_df = loop_df.drop(columns=g['remove_cols'])


        print(loop_df.columns.values.tolist())
        print(loop_df.head(5))
        break





