import os
import sys
sys.path.insert(1, 'C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC530\\ThinkStats2\\code')
os.chdir("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC530\\ThinkStats2\\code")

import nsfg
import thinkstats2
import thinkplot



def main():
    print("BEGIN")

    import first
    resp = nsfg.ReadFemResp()

    print(resp['numkdhh'])

if __name__ == '__main__':
    main()

