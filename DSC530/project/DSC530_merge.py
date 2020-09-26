import os
import pandas
g = {
    'obfuscate' : {},
}

curDir = os.getcwd()

with open("EMP_1.dat", 'r') as fileHandle:  # r for reading
    loop_raw_file = fileHandle.readlines()  # read into a variable

print(loop_raw_file)