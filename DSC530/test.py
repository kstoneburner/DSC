import pandas as pd
import numpy as np
data = np.array([1,2,3,4,5])
ser = pd.Series(data)
print(ser+2)

py_array = [1,2,3,4,5]

for x in range(0,len(py_array)):
    py_array[x] = py_array[x] + 2

print(py_array)
