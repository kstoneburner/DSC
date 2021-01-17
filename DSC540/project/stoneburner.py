import requests
import json
def get_CA_url(url):
    
    #//*** Holds the column names in the API object
    colnames = []
    
    #//*** Dictionary that holds a list for each column. The Column name is the key that returns a list
    #//*** of values for the row.
    attrib_dict = {}
    
    #//*** Request the API webpage
    response = requests.get(url)
    
    #//*** If response is OK, assume the request was succesful
    if response.ok == True:
        print("we're OK")
        
        #//*** Convert the response content to an object via json
        rawOBJ=json.loads(response.content)
        
        #//*** Build Column Names and Column attributes
        rawFields = rawOBJ["result"]['fields']
        
        for loopOBJ in rawFields:
            #//*** Build attributes
            loopAttrib = {}

            #//*** All Columns have an info field except _id.
            if 'info' in loopOBJ.keys():
                loopAttrib = loopOBJ["info"]

            #//*** Add Type to loopAttrib
            loopAttrib['type'] = loopOBJ['type']

            #//*** The column name is the ID field.
            loopColname = loopOBJ['id']

            #//*** Add Column Name to the global api ethnic colnames 
            colnames.append(loopColname)

            #//*** Assign the attributes dictionary based on column name
            attrib_dict[loopColname] = loopAttrib

        #//**** Check Column names
        print(attrib_dict)

#        #//*** Check attributes
#        for x in g['api']['ethnic']['colnames']:
#            print(g['api']['ethnic']['attrib'][x])


def main():
    #//**** For Test Coding purposes
    url = "https://data.ca.gov/api/3/action/datastore_search?resource_id=7e477adb-d7ab-4d4b-a198-dc4c6dc634c9"
    get_CA_url(url)

if __name__ == "__main__":
    main()