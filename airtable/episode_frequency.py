####################################################################################################
####################################################################################################
####################################################################################################
### KGO Airtable Segment Histograp,
### Author: Kurt Stoneburner
### 2020/0
### Program Purpose:
##################### Parse a CSV file from airtable, get the frequency of each segment.
####################################################################################################
####################################################################################################
####################################################################################################
####################################################################################################
#### main - main program loop
####################################################################################################
g={
    'network_workflow_file' : "Network Workflow Tab-Network Workflow Tabs.csv",
    'headDict' : {},
    'episodeDict' : {},
}
import re
import csv
def getField(findField, rawInput):
    ### Change commas with Quotes to Pipes
    #cleanup = re.findall('\\".+\\"',rawInput)

    #for findX in cleanup:
    #    replaceX = findX.replace(",","|")
    #    rawInput = rawInput.replace(findX,replaceX)

    ### Split Fields
    #fields = rawInput.split(",")

    ### If findField Index matches current field, return the value
    for x in range(0,len(rawInput)):
        if x in g['headDict'].keys():
            if g['headDict'][x] == findField:
                #print("Found: " + str(len(fields[x])) + ":" + fields[x])
                return(rawInput[x])
    ### Return Nothing if not found
    return ""
#Episodes Used (Linked)
def main():
    with open(g['network_workflow_file'], 'r') as csvfile:  # open file for writing
        bigFile = csv.reader(csvfile, delimiter=',', quotechar='"')

        lineCounter = 0
        for line in bigFile:

            if lineCounter == 0:
                #### Build Header on first Line
                counter = 0
                ### Build Dictionary, associate Index Value with Header Name
                for header in line:
                    if counter == 0:
                        header = header[3:]
                    g['headDict'][counter] = header
                    counter += 1
                print(g['headDict'])
                lineCounter += 1
                continue

            #print(line)
            ### Skip Lines that don't have a Show name
            #if len(fields[0]) <= 1 :
            #    continue

            ### Get the episodes
            episodes = getField("Episodes Used (Linked)",line)
            showName = getField("Show Name",line)
            netStartDate = getField("Net start date", line)
            series  = getField("Series", line)
            ### If no episodes continue loop
            if len(episodes) == 0:
                continue
            ### Trim whitespace from episodes
            episodes = episodes.replace(" ","")

            for episode in episodes.split(","):
                ### Initialize new Episode Key
                if episode not in g['episodeDict'].keys():
                    g['episodeDict'][episode] = {"showName" : [ showName ], "netStartDate" : [ netStartDate ], "series" : [ series ], "count" : 1 }
                else:
                    g['episodeDict'][episode]["count"] += 1
                    g['episodeDict'][episode]["showName"].append(showName)
                    g['episodeDict'][episode]["netStartDate"].append(netStartDate)
                    g['episodeDict'][episode]["series"].append(series)

            lineCounter += 1

    maxCount = 0
    for episode,vals in g['episodeDict'].items():
        print(episode,vals)
        if vals['count'] > maxCount:
            maxCount = vals['count']
    print(f"Max Count: {maxCount}")
    print(f"Total Episodes: {len(g['episodeDict'].items())}")
    counterList = []
    for x in range(0,maxCount):
        counterList.append(0)
    print(counterList)

    for episode,vals in g['episodeDict'].items():
        counterList[ vals['count'] - 1 ] += 1
        if vals['count'] == 3:
            print(f"{episode} {vals['netStartDate']} {vals['series']} {vals['showName']}")


    print(counterList)

if __name__ == "__main__":
    main()
