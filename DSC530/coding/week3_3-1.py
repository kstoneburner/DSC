import os
import sys
workingPath = os.getcwd().replace("coding", "ThinkStats2\\code")
sys.path.insert(1, workingPath)
os.chdir(workingPath)

import nsfg
import thinkstats2
import thinkplot



def main():
    print("BEGIN")

    import first
    resp = nsfg.ReadFemResp()

    frequency_dict = {}



    for numkids in resp['numkdhh'].sort_values():

        if numkids not in  frequency_dict.keys():
            frequency_dict[numkids] = 1
        else:
            frequency_dict[numkids] = frequency_dict[numkids] + 1

    print(frequency_dict)



if __name__ == '__main__':
    main()

