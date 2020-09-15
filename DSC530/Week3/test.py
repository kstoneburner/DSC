#from __future__ import print_function, division

#Set Home working directory
import os
os.chdir("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC530\\ThinkStats2\\code")

# Imports from nsfg.py

import sys
import numpy as np
import thinkstats2

from collections import defaultdict

### This is pretty much straight from nsfg.pu

dct_file='2002FemResp.dct'
dat_file='2002FemResp.dat.gz'

dct = thinkstats2.ReadStataDct(dct_file)
preg = dct.ReadFixedWidth(dat_file, compression='gzip', nrows=None)


print(preg.head())
