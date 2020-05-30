####################################################################################################
####################################################################################################
####################################################################################################
#### name: Kurt Stoneburner
#### Program Purpose: Parse and generate a running total of Covid-19 deaths based on
##################### the johns hopkins data set located on github.
##################### https://github.com/CSSEGISandData/COVID-19
##################### File - time_series_covid19_deaths_global.csv
####################################################################################################
####################################################################################################

import re ### Regex - Because everyone likes regular expressions
import os

### Define primary global dictionary as g
g = {
    "path" : {
        "usdeaths" : "\\PycharmProjects\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_deaths_US.csv",
        "usconfirmed" : "\\PycharmProjects\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_confirmed_US.csv",
        #"usdeaths" : "C:\\Users\\stonk013\\PycharmProjects\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_deaths_US.csv",
        #"usconfirmed": "C:\\Users\\stonk013\\PycharmProjects\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\time_series_covid19_confirmed_US.csv",
    },
    "dateIndex" : 12, #The next Column is where the Death Dates Start
    "columns" : [],
}

class deathStats():
    ### Init DeathStats
    ### The datasets hold the top level construct, USDEATHS, USCONFIRMED etc
    def __init__(self):
        self.columns = []

    class datablock():
        def __init__(self):
            self.national = self.stats()
            self.states = {}
            self.counties = {}
            self.date = ""
            self.index = -1

        def incrementTotal(self, options):
            field = options['field']
            value = options['count']
            if field == 'national':
                self.national.daily_total += value

            elif field == 'state':
                thisState = options['state']

                if thisState in self.states.keys():
                    self.states[thisState].daily_total += value
                else:
                    thisStats = self.stats()
                    thisStats.daily_total = value
                    self.states[thisState] = thisStats
            elif field == 'county':
                #'field': 'county', 'count': death_count, 'county'
                thisCounty = options['county']

                if thisCounty in self.counties.keys():
                    self.counties[thisCounty].daily_total += value
                else:
                    thisStats = self.stats()
                    thisStats.daily_total = value
                    self.counties[thisCounty] = thisStats


            else:
                print("Error in increment Total. Unhandled Field: " + field)
                quit()

        def getVals(self):
            return (str(self.date), str(self.national), str(self.states), str(self.counties))

        def __str__(self):
            return (f"{self.index} {self.date} : {self.national}")

        class stats():
            ### daily_total - Already summed value of daily deaths US
            ### death_daily_change - The Change in deaths from the previous day
            ### double_running_total - Number of days to reach half national total. Number of days to double Looking back
            ### double_running_daily - Number of days to reach half daily total. Number of days to double Looking back
            ### double_running_total_5day_avg - 5 day average of double_running_total. Useful for looking at trends
            ### double_running_daily_5day_avg - 5 day average of double_running_daily. Useful for looking at trends
            ### daily_double_running_total - (1 / double_running_total) = daily doubling rate per day.
            ### daily_double_running_daily - (1 / double_running_daily) = daily doubling rate per day.
            ### daily_double_running_total_5day_avg - (1 / double_running_total_5day_avg) = 5 day Avg doubling rate per day.
            ### daily_double_running_daily_5day_avg - (1 / double_running_daily_5day_avg) = 5 day Avg doubling rate per day.
            def __init__(self):
                self.daily_total = 0
                self.death_daily_change = 0

            def __str__(self):
                return (f"Daily Total: {self.daily_total} Death daily Change: {self.death_daily_change}")

    def initialize_columns(self, input_line):

        ### The Indexes greater than 11 are all dates.
        ### Initialize the deathDay dictionary by looping through the column keys
        ### We use to a range loop since we are testing index values (not the data)
        # for date_index in range(0, len(g["keys"]) ):
        counter = 0
        for column_name in input_line.split(","):
            ### Sets the Key to the date

            ### Dirty Leading Zero Date conversion
            tempCol = column_name
            tempCol = tempCol.replace("/1/", "/01/")
            tempCol = tempCol.replace("/2/", "/02/")
            tempCol = tempCol.replace("/3/", "/03/")
            tempCol = tempCol.replace("/4/", "/04/")
            tempCol = tempCol.replace("/5/", "/05/")
            tempCol = tempCol.replace("/6/", "/06/")
            tempCol = tempCol.replace("/7/", "/07/")
            tempCol = tempCol.replace("/8/", "/08/")
            tempCol = tempCol.replace("/9/", "/09/")

            ### Add Leading Zero to date for fixed width
            if "/" in tempCol:
                tempCol = tempCol.split("/")

                if len(tempCol[0]) == 1:
                    tempCol[0] = "0" + tempCol[0]

                tempCol = tempCol[0] + "/" + tempCol[1] + "/" + tempCol[2]

                ### Initialize a new datablock with the counter and tempCol as Date

                thisDataBlock = self.datablock()

                thisDataBlock.date = tempCol
                thisDataBlock.index = counter

                print(str(counter) + ":" + tempCol)
                self.columns.append(thisDataBlock)
            counter += 1


    ### END initialize columns

    ### Death stats version of convert_file_to_dict
    def convert_file_to_dict(self, file_path, death_dict_name):

        print("Begin deathsStats Convert: " + death_dict_name)

        file = open(file_path, "r")

        firstPass = True

        for rawLine in file:
            ### Trim trailing Newline character
            rawLine = rawLine[:-1]

            ### Process the header line separately
            ### Use the header to populate a list that will be used as a key
            if firstPass == True:
                firstPass = False
                ### Build Columns if it doesn't exist
                if len(self.columns) == 0:
                    self.initialize_columns(rawLine)
                continue

            ### END FirstPass - Build Keys

            ### Need to remove the commas from the combined key, because it distorts our CSV
            ### Use a regular Expression to extract the combined key which is denoted by quotes " "
            findText = re.findall('\".+\"', rawLine)[0]
            ### Replace Text is the cleaned up find Text
            replaceText = findText.replace(",", "")

            ### Clean the results with a find / replace
            rawLine = rawLine.replace(findText, replaceText)

            #########################################################################################################
            ### We need to extract the State information for this key.
            ### This Processing is done before we enter the loop where we just get data death data based on date
            ### Ignore Data that does not explicitly have a State in it.
            ### This excludes territories, Grand Princess, and Out State References
            #########################################################################################################
            isState = False

            if 'USA' in rawLine:
                isState = True

            if "Out of" in rawLine or "Unassigned" in rawLine or "Grand Princess" in rawLine:
                isState = False

            ### Parse Each Line and add the value to the date Dictionary. This will sum the deaths for the day, nationally
            ### Convert the rawLine to a list
            rawLine = rawLine.split(",")

            ### Continue if State is found
            ###
            thisState = str(rawLine[6])
            thisCounty = str(rawLine[5])

            ### END State Processing

            ### Loop through list looking for the date columns which begin at 12
            for date_index in range(0, len(rawLine)):

                #### Date with Deaths by County
                if date_index >= g['dateIndex']:

                    try:
                        ### get value to be added to deathDay
                        death_count = int(rawLine[date_index])
                    except:
                        ### Seems to be tripping up on the last value, very likely an EOF or a NEWLINE
                        ### We'll just skip this element
                        continue

                    # Generate the Column Index. Solumns start at zero, so we need to subtract the starting Index

                    colIndex = date_index - g['dateIndex']
                    ### Add one to usConfirmed which has one less field than usdeaths
                    if death_dict_name == 'usconfirmed':
                        colIndex = date_index - g['dateIndex'] + 1
                    # print (self.columns)
                    #print(f"{date_index} - {g['dateIndex']} = {colIndex}: {self.columns[colIndex].index}  - {self.columns[colIndex].date} {self.columns[colIndex]}-- {int(rawLine[date_index])} --")
                    self.columns[colIndex].incrementTotal({'field': 'national', 'count': death_count})
                    self.columns[colIndex].incrementTotal({'field' : 'state', 'count' : death_count, 'state' : thisState})
                    self.columns[colIndex].incrementTotal({'field': 'county', 'count': death_count, 'county': thisCounty})

                    # print(thisCounty + " " + thisState)
                    """
                    ### Death Day Key is column_date, increment by one for usconfirmed, dirty pool for not including population in confirmed
                    if death_dict_name == 'usconfirmed' and date_index >= g['dateIndex']:
                        ### Calculate Total Deaths
                        #g['columns'][date_index + 1][death_dict_name]["running_total"] += death_count

                        print(f"{date_index+1} : {columns[date_index+1].index}  - {columns[date_index+1].date}")
                        ### Add Value to State Dictionaries

                        if isState:
                            #### Initialize states dictionary
                            if 'states' not in g['columns'][date_index + 1][death_dict_name].keys():
                                g['columns'][date_index + 1][death_dict_name]['states'] = {}

                            ### Initialize state in state dictionary
                            if thisState not in g['columns'][date_index + 1][death_dict_name]['states'].keys():
                                g['columns'][date_index + 1][death_dict_name]['states'][thisState] = {
                                    "running_total": 0}
                            else:
                                g['columns'][date_index + 1][death_dict_name]["states"][thisState][
                                    "running_total"] += death_count
                        if isState:
                            #### Initialize states dictionary
                            if 'states' not in g['columns'][date_index][death_dict_name].keys():
                                g['columns'][date_index][death_dict_name]['states'] = {}

                            ### Initialize state in state dictionary
                            if thisState not in g['columns'][date_index][death_dict_name]['states'].keys():
                                g['columns'][date_index][death_dict_name]['states'][thisState] = {"running_total": 0}
                            else:
                                g['columns'][date_index][death_dict_name]["states"][thisState][
                                    "running_total"] += death_count
                    else:
                        ### Calculate Total Deaths
                        #g['columns'][date_index][death_dict_name]["running_total"] += death_count
                        print(f"{date_index} : {columns[date_index].index}  - {columns[date_index].date}")
                        """

                ### END Process Date/Field

            ### END For each rawLine Item

        file.close()
        for datablock in self.columns:
            print("-->" + str(datablock))
        # thisDataBlock = self.datablock()
        # print("Data Set: " + str(self.dataset))

    def build_derived_stats(self):
        for date_index in range(len(self.columns)):
            thisColumn = self.columns[date_index]
            print(thisColumn)
        print("DING!")
    def getLast(self):
        return self.columns[len(self.columns) - 1]






def convert_file_to_dict(file_path,death_dict_name):
    def initialize_columns(input_line):
        ### The Indexes greater than 11 are all dates.
        ### Initialize the deathDay dictionary by looping through the column keys
        ### We use to a range loop since we are testing index values (not the data)
        # for date_index in range(0, len(g["keys"]) ):
        for column_name in input_line.split(","):
            ### Sets the Key to the date

            ### Dirty Leading Zero Date conversion
            tempCol = column_name
            tempCol = tempCol.replace("/1/", "/01/")
            tempCol = tempCol.replace("/2/", "/02/")
            tempCol = tempCol.replace("/3/", "/03/")
            tempCol = tempCol.replace("/4/", "/04/")
            tempCol = tempCol.replace("/5/", "/05/")
            tempCol = tempCol.replace("/6/", "/06/")
            tempCol = tempCol.replace("/7/", "/07/")
            tempCol = tempCol.replace("/8/", "/08/")
            tempCol = tempCol.replace("/9/", "/09/")

            ### Add Leading Zero to date for fixed width
            if "/" in tempCol:
                tempCol = tempCol.split("/")

                if len(tempCol[0]) == 1:
                    tempCol[0] = "0" + tempCol[0]

                tempCol = tempCol[0] + "/" + tempCol[1] + "/" + tempCol[2]

            deathOBJ = {"date": tempCol}

            g['columns'].append(deathOBJ)
    ### END initialize columns

    def initialize_key(death_dict_name):

        for deathOBJ in range(0, len(g['columns'])):
            g['columns'][deathOBJ][death_dict_name] = {"running_total": 0, "daily_total": 0, }

            ### index values less the dateIndex are not displayed.
            if deathOBJ < g['dateIndex']:
                g['columns'][deathOBJ]['display'] = False
            else:
                g['columns'][deathOBJ]['display'] = True
    ### END Initialize Key

    file = open(file_path, "r")

    firstPass = True

    for rawLine in file:
        ### Trim trailing Newline character
        rawLine = rawLine[:-1]

        ### Process the header line separately
        ### Use the header to populate a list that will be used as a key
        if firstPass == True:
            firstPass = False
            ### Build Columns if it doesn't exist
            if len(g['columns']) == 0:
                initialize_columns(rawLine)
            ### Build dictionary Key and Initialize values
            initialize_key(death_dict_name)
            continue

        ### END FirstPass - Build Keys

        ### Need to remove the commas from the combined key, because it distorts our CSV
        ### Use a regular Expression to extract the combined key which is denoted by quotes " "
        findText = re.findall('\".+\"', rawLine)[0]
        ### Replace Text is the cleaned up find Text
        replaceText = findText.replace(",","")

        ### Clean the results with a find / replace
        rawLine = rawLine.replace(findText,replaceText)


        #########################################################################################################
        ### We need to extract the State information for this key.
        ### This Processing is done before we enter the loop where we just get data death data based on date
        ### Ignore Data that does not explicitly have a State in it.
        ### This excludes territories, Grand Princess, and Out State References
        #########################################################################################################
        isState = False

        if 'USA' in rawLine:
            isState = True

        if "Out of" in rawLine or "Unassigned" in rawLine or "Grand Princess" in rawLine:
            isState = False


        ### Parse Each Line and add the value to the date Dictionary. This will sum the deaths for the day, nationally
        ### Convert the rawLine to a list
        rawLine = rawLine.split(",")

        ### Continue if State is found
        ###
        thisState = str(rawLine[6])

        ### END State Processing



        ### Loop through list looking for the date columns which begin at 12
        for date_index in range(0, len(rawLine)):

            #### Date with Deaths by County
            if date_index > g['dateIndex'] and len(rawLine[date_index]) > 0:

                try:
                    ### get value to be added to deathDay
                    death_count = int(rawLine[date_index])
                except:
                    ### Seems to be tripping up on the last value, very likely an EOF or a NEWLINE
                    ### We'll just skip this element
                    continue

               ### Death Day Key is column_date, increment by one for usconfirmed, dirty pool for not including population in confirmed
                if death_dict_name == 'usconfirmed' and date_index >= g['dateIndex']:
                    ### Calculate Total Deaths
                    g['columns'][date_index+1][death_dict_name]["running_total"] += death_count

                    ### Add Value to State Dictionaries
                    if isState:
                        #### Initialize states dictionary
                        if 'states' not in g['columns'][date_index+1][death_dict_name].keys():
                            g['columns'][date_index+1][death_dict_name]['states'] = {}

                        ### Initialize state in state dictionary
                        if thisState not in g['columns'][date_index+1][death_dict_name]['states'].keys():
                            g['columns'][date_index+1][death_dict_name]['states'][thisState] = {"running_total": 0}
                        else:
                            g['columns'][date_index+1][death_dict_name]["states"][thisState]["running_total"] += death_count
                else:
                    ### Calculate Total Deaths
                    g['columns'][date_index][death_dict_name]["running_total"] += death_count

                    if isState:
                        #### Initialize states dictionary
                        if 'states' not in g['columns'][date_index][death_dict_name].keys():
                            g['columns'][date_index][death_dict_name]['states'] = {}

                        ### Initialize state in state dictionary
                        if thisState not in g['columns'][date_index][death_dict_name]['states'].keys():
                            g['columns'][date_index][death_dict_name]['states'][thisState] = {"running_total": 0}
                        else:
                            g['columns'][date_index][death_dict_name]["states"][thisState]["running_total"] += death_count

            ### END Process Date/Field

        ### END For each rawLine Item

    file.close()


def generate_derived_stats(death_dict_name):
    def days_to_double(index, death_dict, key):
        if index < 2:
            return 0
        ### Look backwards to find half the current number
        currentDeathOBJ = g["columns"][index][death_dict]
        target_val = int(currentDeathOBJ[key] / 2)
        back_index = index

        while back_index > 0:
            back_index -= 1
            back_total = g['columns'][back_index][death_dict][key]
            if back_total == 0:
                return 0
            if back_total < target_val:
                total_days = index - back_index
                overage = target_val - back_total
                percent_modifier = overage / target_val

                return float("%0.2f" % ( total_days + percent_modifier ) )

        return 0
    ### END days_to_double

    def running_average(index, death_dict, key, count):
        ### Rolling average looking backwards
        if index <= count:
            return 0

        target_index = index - count

        runningTotal = 0

        while index > target_index:

            currentDeathOBJ = g["columns"][index][death_dict]

            if key not in currentDeathOBJ.keys():
                return 0

            runningTotal += float(currentDeathOBJ[key])

            index -= 1

        return (runningTotal / count)
    ### END running_average

    #### BEGIN Generate Derived Stats
    ####################################################################################################################
    ### daily_total - Already summed value of daily deaths US
    ### death_daily_change - The Change in deaths from the previous day
    ### double_running_total - Number of days to reach half national total. Number of days to double Looking back
    ### double_running_daily - Number of days to reach half daily total. Number of days to double Looking back
    ### double_running_total_5day_avg - 5 day average of double_running_total. Useful for looking at trends
    ### double_running_daily_5day_avg - 5 day average of double_running_daily. Useful for looking at trends
    ### daily_double_running_total - (1 / double_running_total) = daily doubling rate per day.
    ### daily_double_running_daily - (1 / double_running_daily) = daily doubling rate per day.
    ### daily_double_running_total_5day_avg - (1 / double_running_total_5day_avg) = 5 day Avg doubling rate per day.
    ### daily_double_running_daily_5day_avg - (1 / double_running_daily_5day_avg) = 5 day Avg doubling rate per day.
    ####################################################################################################################

    for date_index in range(g["dateIndex"],len(g['columns'])):
        deathOBJ = g['columns'][date_index][death_dict_name]

        prevDeathOBJ = g['columns'][date_index - 1][death_dict_name]

        ### Build the Daily Totals
        deathOBJ['daily_total'] = deathOBJ["running_total"] - prevDeathOBJ["running_total"]
        deathOBJ['death_daily_change'] = deathOBJ['daily_total'] - prevDeathOBJ['daily_total']

        ### Build State Values
        if 'states' in deathOBJ.keys():
            for state in deathOBJ['states']:
                if 'states' in prevDeathOBJ.keys():
                    ### Daily Totals
                    deathOBJ['states'][state]['daily_total'] = deathOBJ['states'][state]["running_total"] - prevDeathOBJ['states'][state]["running_total"]
                    deathOBJ['states'][state]['death_daily_change'] = deathOBJ['states'][state]["daily_total"] - prevDeathOBJ['states'][state]["daily_total"]
                else:
                    deathOBJ['states'][state]['daily_total'] = 0
                    deathOBJ['states'][state]['death_daily_change'] = 0

        if deathOBJ["running_total"] > 0:
            deathOBJ['daily_percentage'] = deathOBJ['daily_total'] / deathOBJ["running_total"]
        else:
            deathOBJ['daily_percentage'] = 0.0

        ### Look Backwards to determine how many days it took to reach this number
        deathOBJ['double_running_total'] = days_to_double(date_index,death_dict_name,'running_total')
        deathOBJ['double_running_daily'] = days_to_double(date_index,death_dict_name,'daily_total')

        ### Convert doubling days, to daily percentage, avoid dividing by zero
        if deathOBJ['double_running_total'] == 0:
            deathOBJ['daily_double_running_total'] = 0.0
        else:
            deathOBJ['daily_double_running_total'] = float("%0.2f" % (1 / deathOBJ['double_running_total']))

        if deathOBJ['double_running_daily'] == 0:
            deathOBJ['daily_double_running_daily'] = 0.0
        else:
            deathOBJ['daily_double_running_daily'] = float("%0.2f" % (1 / deathOBJ['double_running_daily']))

        ### Update global death Object <- This is bad form, but it works
        g['columns'][date_index][death_dict_name] = deathOBJ

        ## index 74 is our peak doubling
        deathOBJ['double_running_total_5day_avg'] = float("%0.2f" % running_average(date_index, death_dict_name, 'double_running_total', 5))
        deathOBJ['double_running_daily_5day_avg'] = float("%0.2f" % running_average(date_index, death_dict_name, 'double_running_daily', 5))

        if deathOBJ['daily_double_running_total'] == 0:
            deathOBJ['daily_double_running_total'] = 0
        else:
            deathOBJ['daily_double_running_total_5day_avg'] = float("%0.2f" % (1 / deathOBJ['daily_double_running_total']))

        if deathOBJ['daily_double_running_daily'] == 0:
            deathOBJ['daily_double_running_daily_5day_avg'] = 0
        else:
            deathOBJ['daily_double_running_daily_5day_avg'] = float("%0.2f" % (1 / deathOBJ['daily_double_running_daily']))


        g['columns'][date_index][death_dict_name] = deathOBJ

    ### END Generate Derived Values

def main():
    def build_daily_report(input_list):

        sep = " : "
        sep = "   "
        ### Build a string for display based on items in a list entered as an object.
        out = ""

        threshold = { 'found': False, 'field' : '', 'value' : -1}
        for thisDict in input_list:
            if 'head' in thisDict:
                thisDict['width'] = len(thisDict['head'])
            else:
                thisDict['width'] = 7
            if 'threshold' in thisDict.keys():
                threshold['found'] = True
                threshold['field'] = thisDict['k2']
                threshold['value'] = thisDict['threshold']

        ### Build Header
        out += "Date     "
        for thisDict in input_list:
            if 'head' in thisDict:
                out+= thisDict['head'] + sep
            else:
                out += "       ---"
        out+="\n"

        spacer = ""

        for i in range(1,len(out)):
            spacer += "="
        out = spacer + "\n" + out + spacer + "\n"


        for i in range(0, len(g['columns'])):
            thisLine = ""
            deathOBJ = g['columns'][i]

            if deathOBJ['display']:
                ### Add Date
                thisLine += g['columns'][i]['date'] + " "

                ### Loop through input_list

                for loopOBJ in input_list:
                    modifier = 0

                    if 'compare' in loopOBJ.keys():

                        modifier = loopOBJ['compare']

                    if "state" not in loopOBJ.keys():
                        ### Build the Key and subkey elements. These are loop k1 - top level, loop k2 - sub level
                        ### Add in string converion.
                        try:
                            thisValue = str(g['columns'][i + modifier ][loopOBJ['k1']][loopOBJ['k2']])
                        except:
                            thisValue = "==="

                    else:
                        try:
                            thisValue = str(g['columns'][i + modifier][loopOBJ['k1']]['states'][loopOBJ['state']][loopOBJ['k2']])
                        except:
                                thisValue = "==="
                    tempVal = "{:>" + str(loopOBJ['width']) + "s}"
                    thisLine += tempVal.format(thisValue)
                    thisLine += sep
                thisLine += "\n"

                if threshold['found']:
                    ### Keep line if threshold value is exceeded
                    if g['columns'][i + modifier ][loopOBJ['k1']][loopOBJ['k2']] > threshold['value']:
                        out+=thisLine
                else:
                    out += thisLine

        return out

    ### END daily report
    def get_last(input_dict):
        #### Get the last Value from a given key
        k1 = input_dict['k1'];
        k2 = input_dict['k2']
        last_index = len(g['columns'])-1
        if "state" not in input_dict.keys():
            return g['columns'][last_index][k1][k2]
        else:
            state = input_dict['state']
            return g['columns'][last_index][k1]['states'][state][k2]

    ### END get Last

    def get_last_date():
        last_index = len(g['columns']) - 1
        return g['columns'][last_index]['date']
    ### END get Lasy Daye

    def get_at(input_dict):

        index = input_dict['index']
        k1 = input_dict['k1']
        k2 = input_dict['k2']

        return g['columns'][index][k1][k2]

    #### End get_at

    def timeline (day,input_deaths):

        if day == 0:
            infection_time = 23

            target = len(g['columns']) - infection_time

            if target < g["dateIndex"]:
                ### Invalid Date
                return "Day 0 - ######"
            else:
                thisDate = g['columns'][target]['date']
                return("Day  0: " + thisDate + " - Infection - " + str(input_deaths * 100) + " estimated infected (assume 1% mortality)")
        elif day == 5:
            infection_time = 18
            target = len(g['columns']) - infection_time

            if target < g["dateIndex"]:
                ### Invalid Date
                return "Day  5 - ######"
            else:
                thisDate = g['columns'][target]['date']
                return "Day  5: " + thisDate + " - Symptons"
        elif day == 11:
            infection_time = 12
            target = len(g['columns']) - infection_time

            if target < g["dateIndex"]:
                ### Invalid Date
                return "Day 11 - ######"
            else:
                thisDate = g['columns'][target]['date']
                confirmed = get_at({'k1' : 'usconfirmed', 'k2' : 'daily_total', 'index' : target })
                return "Day 11: " + thisDate + " - Hospitalization - " +str(input_deaths * 20) + " estimated (20% of infected) - Confirmed: " + str(confirmed)
        elif day == 23:
            return "Day 23: " + get_last_date() + " - Death "

        return ""
    ### END timeline

    ### Build initial paths based on username


    ### Adds C:\Users\username to the path. It's Ghetto, but functional

    quickKey = ["usdeaths", "usconfirmed"]
    for x in quickKey:
        g["path"][x] = "c:\\users\\" + os.getlogin() + g["path"][x]
    """
    ### Performs initial data read of File and converts to a dictionary
    convert_file_to_dict(g["path"]["usdeaths"],'usdeaths')
    convert_file_to_dict(g["path"]["usconfirmed"],'usconfirmed')

    ### perform light maths on dictionary. Gives us running totals, daily doubling, 5day avg daily double
    generate_derived_stats("usdeaths")
    generate_derived_stats("usconfirmed")
    """

    mainStats = deathStats()
    mainStats.convert_file_to_dict(g["path"]["usdeaths"],'usdeaths')
    mainStats.build_derived_stats()
    #lastBlock = mainStats.getLast()

    #for state in lastBlock.states:
    #    print(state + ":" + str(lastBlock.states[state]))

    #for county in lastBlock.counties:
    #    print(county + ":" + str(lastBlock.counties[county]))

    print("END")
    quit()
    out = build_daily_report([
        {'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Total Deaths'},
        {'k1' : 'usdeaths', 'k2' : 'double_running_total', 'head' : "dbling Days"},
        {'k1' : 'usdeaths', 'k2' : 'daily_double_running_total', 'head' : "Daily Change"},
        {'k1' : 'usdeaths', 'k2' : 'daily_total', 'head' : 'Deaths /day'},
        {'k1' : 'usdeaths', 'k2' : 'double_running_daily', 'head' : 'dbling days'},
        {'k1' : 'usdeaths', 'k2' : 'daily_double_running_daily', 'head' : 'Daily Change'},
        ])
    ### END build Daily Report

    print(out)

    out = build_daily_report([
        {'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Total Deaths'},
        {'k1' : 'usconfirmed', 'k2' : 'running_total', 'head' : 'Total Confirmed'},
        {'k1' : 'usdeaths', 'k2' : 'daily_total', 'head' : 'Deaths /day'},
        {'k1' : 'usdeaths', 'k2' : 'daily_double_running_daily', 'head' : 'Daily Change'},
        {'k1' : 'usconfirmed', 'k2' : 'daily_total', 'head' : 'Confirm /day'},
        {'k1' : 'usconfirmed', 'k2' : 'daily_double_running_daily', 'head' : 'Daily Change'},
        {'k1': 'usdeaths', 'k2': 'daily_double_running_daily', 'compare' : -18,'head': 'Death Daily Change -18'},
        ])
    print(out)

    file = open("usDeaths_out.txt", "w")
    file.write(out)
    file.close()

    last_daily_deaths = get_last(
        {'k1' : 'usdeaths', 'k2' : 'daily_total'}
        )
    last_date = get_last_date()
    #print("On " + last_date + " there were " + str(last_daily_deaths) + " deaths")
    #print("Timeline:")
    #print(timeline(0,last_daily_deaths))
    #print(timeline(5,last_daily_deaths))
    #print(timeline(11,last_daily_deaths))
    #print(timeline(23, last_daily_deaths))
    #print(locals())
    #print(globals())

    out = build_daily_report([
        {'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Total Deaths'},
        {'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Deaths /day', 'threshold' : 1793},
        ])

    out = build_daily_report([
#        {'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Total Deaths'},
       {'k1': 'usdeaths', 'k2': 'running_total', 'head': 'CA Total Deaths', 'state': 'California'},
       {'k1' : 'usdeaths', 'k2' : 'daily_total', 'head' : 'CA death_daily_change', 'state' : 'California' },
        #{'k1' : 'usdeaths', 'k2' : 'running_total', 'head' : 'Total Deaths', 'state' : 'New York'},
        ])
    print(out)

    last_daily_death = get_last(
        {'k1': 'usdeaths', 'k2': 'running_total', 'state' : 'California'}
    )

    #print(last_daily_deaths)
    #for x in g['columns']:
        #if 'states' in x['usdeaths'].keys():
            #print(f"{x['usdeaths']['states']['New York']} {x['usdeaths']['states']['California']}")

### Launch main
if __name__ == '__main__':
    main()

