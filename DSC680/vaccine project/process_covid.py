from pathlib import Path
import pandas as pd
import numpy as np
import os
import requests
from datetime import datetime
from IPython.display import clear_output

class process_covid():
    
    def process_patient_impact(self,**kwargs):
        
        data_folder_name = "raw_data"
        
        #//*** Identify columns to process. Sum() the Yes Values of those COlumns
        base_cols = ["case_month","res_state","state_fips_code","res_county","county_fips_code"]
        process_cols = ['hosp_yn','icu_yn','death_yn','underlying_conditions_yn'] 

        #//*** Convert case_month to datetime format
        convert_date = True
        reset_index = True

        rename_cols = []

        for key,value in kwargs.items():

            if key == 'data_folder_name':
                data_folder_name = value
                
            if key == 'base_cols':
                base_cols = value

            if key == 'process_cols':
                process_cols = value
        
            if key == 'convert_date':
                convert_date = value

            if key == 'reset_index':
                reset_index = value

            if key == 'rename_cols':
                rename_cols = value

        current_dir = Path(os.getcwd()).absolute()
        data_dir = current_dir.joinpath(data_folder_name)
        base_filename = "covid_people.pkl.zip"
        out_df = pd.DataFrame()
        #//**** Load each file
        for filename in os.listdir(data_dir):
            if base_filename in filename:
                print("Processing:",filename)
                loop_df = pd.read_pickle(data_dir.joinpath(filename))
                print("Loaded: ", len(loop_df), " records", "Current Record Size:", len(out_df))
                
                #//*** Drop Rows with NaN county FIPS Code
                loop_df = loop_df.dropna(subset="county_fips_code")
                
                loop_df = self.sum_cols(loop_df, base_cols=base_cols, process_cols=process_cols)
                out_df = pd.concat([out_df,loop_df])
                
                
        columns = list(out_df.columns)
        
        #//*** Convert column names if specified

        for rc in rename_cols:

            find = rc[0]
            replace = rc[1]

            columns = [replace if item == find else item for item in columns]

        out_df.columns = columns

        if convert_date:
            out_df['case_month'] = pd.to_datetime(out_df['case_month'])

        if reset_index:
            out_df = out_df.reset_index(drop=True)

        return out_df
    
    def sum_cols(self,df,**kwargs):
        
        process_cols = None
        
        base_cols = None

        for key,value in kwargs.items():
            if key == 'process_cols':
                process_cols = value
        
            if key == 'base_cols':
                base_cols = value
                
        if process_cols == None:
            print("Needs to declare Process Cols. These are the columns to process and sum")
            return df
        
        if base_cols == None:
            print("Needs to declare Base Cols. These are the utility description columns to keep but not sum.")
            return df
        
        #//*** Declare output dataframe. Returned Results go here
        out_df = pd.DataFrame()
        
        
        #//*** COmbine the Base and Process columns
        use_cols = base_cols + process_cols

        #//*** Sum the cases by month, hate to lose the demographic data
        #//*** GRoup By Month
        for date_group in df[use_cols].groupby('case_month'):

            for col in date_group[1].columns:

                #//*** Convert Yes == 1, everything else to 0
                if col in process_cols:

                    #//*** Identify the non-Yes values
                    unique_replace = date_group[1][ date_group[1][col] != "Yes" ][col].unique()

                    #//*** Replace Non-Yes values to 0
                    for replace in unique_replace:
                        date_group[1][col] = date_group[1][col].replace(replace,0)

                    #//*** Change the Yes Values to 1
                    date_group[1][col] = date_group[1][col].replace("Yes",1)

            #//*** For Each Month Group by COunty
            for fips_group in date_group[1].groupby('county_fips_code'):

                tds =  fips_group[1].iloc[0].copy()


                for col in process_cols:

                    tds[col] = fips_group[1][col].sum()
            
                out_df = pd.concat([out_df,tds],axis=1)
            
        
        return out_df.transpose()



def download_data(**kwargs):

    data_folder_name = "raw_data"

    current_dir = Path(os.getcwd()).absolute()
    data_dir = current_dir.joinpath(data_folder_name)

    confirmed_data_filename = data_dir.joinpath("z_us_confirmed.csv")
    death_data_filename = data_dir.joinpath("z_us_death_cases.csv")
    vaccine_data_filename = data_dir.joinpath("z_us_vaccination.csv")
    county_vaccine_data_filename = data_dir.joinpath("z_us_county_vaccination.csv.zip")
    state_hospital_filename = data_dir.joinpath("z_state_hospital.csv")






    #//***********************************************************************************************
    #//*** California COVID Data website:
    #//**************************************
    #//*** https://data.chhs.ca.gov/dataset/covid-19-time-series-metrics-by-county-and-state
    #//***********************************************************************************************

    
    try:
        response = requests.get("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv")
        if response.ok:
            print("US Confirmed Data Downloaded")
            f = open(confirmed_data_filename, "w")
            f.write(response.text)
            f.close()
            print("US Confirmed Data Written to file.")
    except:
        print("US Confirmed Data: Trouble Downloading From Johns Hopkins Github")

    
    try:
        response = requests.get("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv")
        if response.ok:
            print("US Deaths Data Downloaded")
            f = open(death_data_filename, "w")
            f.write(response.text)
            f.close()
            print("US Death Data Written to file.")
    except:
        print("US Death Data: Trouble Downloading From Johns Hopkins Github")
        
    try:
        #response = requests.get("https://data.cdc.gov/api/views/8xkx-amqh/rows.csv?accessType=DOWNLOAD")
        response = requests.get("https://data.cdc.gov/api/views/unsk-b7fc/rows.csv?accessType=DOWNLOAD")
        if response.ok:
            print("Vaccination Data Downloading")
            f = open(vaccine_data_filename, "w")
            f.write(response.text)
            f.close()
            print("US Vaccination Data Written to file.")
    except:
        print("US Vaccine Data: Trouble Downloading From CDC")

    
    #//*** CDC Vaccination County Data
    #//*** Source: https://data.cdc.gov/Vaccinations/COVID-19-Vaccinations-in-the-United-States-County/8xkx-amqh
    print("County Vaccination Data Downloading")
    response = requests.get("https://data.cdc.gov/api/views/8xkx-amqh/rows.csv?accessType=DOWNLOAD")
    if response.ok:

        county_vaccine_data_filename = data_dir.joinpath("z_us_county_vaccination.csv")
        county_vaccine_data_filename_1 = data_dir.joinpath("z_1_us_county_vaccination.csv.zip")
        county_vaccine_data_filename_2 = data_dir.joinpath("z_2_us_county_vaccination.csv.zip")
        
        print("County Vaccination Data Downloaded")
        #//*** Write CSV File
        f = open(str(county_vaccine_data_filename).replace(".zip",""), "w")

        f.write(response.text)
        f.close()

        print("Loading Raw Vaccine File: ")
        tdf = pd.read_csv(county_vaccine_data_filename,low_memory=False)
        print("Saving First Half of DataFrame: ")
        tdf.iloc[:int(len(tdf)/2)].to_pickle(county_vaccine_data_filename_1)
        print("Saving Second Half of DataFrame: ")
        tdf.iloc[int(len(tdf)/2):].to_pickle(county_vaccine_data_filename_2)

        #df = pd.concat([pd.read_pickle(county_vaccine_data_filename_1),pd.read_pickle(county_vaccine_data_filename_2)])
        print("Delete Raw Vaccine File:",county_vaccine_data_filename)
        os.remove(county_vaccine_data_filename)


        print("US County Vaccination Data Written to file.")

    #Hospitalizations - State
    #https://healthdata.gov/api/views/g62h-syeh/rows.csv?accessType=DOWNLOAD

    try:
        #response = requests.get("https://data.cdc.gov/api/views/8xkx-amqh/rows.csv?accessType=DOWNLOAD")
        response = requests.get("https://healthdata.gov/api/views/g62h-syeh/rows.csv?accessType=DOWNLOAD")
        if response.ok:
            print("Hospitalization Data Downloading")
            f = open(state_hospital_filename, "w")
            f.write(response.text)
            f.close()
            print("US Hospitalization Data Written to file.")
    except:
        print("US Hospitalization: Trouble Downloading From Healthdata.gov")


def build_county_case_death(**kwargs):
    data_folder_name = "raw_data"
    confirmed_data_filename = "z_us_confirmed.csv"
    death_data_filename =  "z_us_death_cases.csv"
    county_daily_df_filename = "z_county_daily_df.csv.zip"

    for key,value in kwargs.items():
        if key == 'folder':
            data_folder_name = value

        if key == 'confirm':
            confirmed_data_filename = value

        if key == 'death':
            death_data_filename = value

        if key == 'export':
            county_daily_df_filename = value
        

    current_dir = Path(os.getcwd()).absolute()
    data_dir = current_dir.joinpath(data_folder_name)

    confirmed_data_filename = data_dir.joinpath(confirmed_data_filename)
    death_data_filename = data_dir.joinpath(death_data_filename)
    county_daily_df_filename = data_dir.joinpath("z_county_daily_df.csv.zip")
    #//****************************************************
    #//*** Prepare Confirmed Cases and Deaths For Merge
    #//****************************************************

    print("Loading Raw Confirm Cases Data....")
    confirm_df = pd.read_csv(confirmed_data_filename)

    confirm_df = confirm_df[confirm_df['Admin2'] != 'Unassigned']

    #//*** Convert Confirmed Date Columns to Date Objects
    cols = []
    confirm_date_cols = []
    for col in confirm_df.columns:
        if "/" not in col:
            cols.append(col)
        else:
            cols.append(datetime.strptime(col, "%m/%d/%y").date())
            confirm_date_cols.append(datetime.strptime(col, "%m/%d/%y").date())

    confirm_df.columns = cols

    print("Loading Raw Deaths Data....")

    death_df = pd.read_csv(death_data_filename)

    death_df

    death_df['Province_State'].unique()
    death_df = death_df[death_df['iso2'] =='US']
    death_df = death_df[death_df['Province_State'] != "Diamond Princess"]
    death_df = death_df[death_df['Province_State'] != "Grand Princess"]
    death_df = death_df[death_df['Admin2'] != 'Unassigned']
    death_df.dropna(inplace=True)
    death_df['FIPS'] = death_df['FIPS'].astype(int)


    #//*** Convert Confirmed Date Columns to Date Objects
    cols = []
    death_date_cols = []

    for col in death_df.columns:
        if "/" not in col:
            cols.append(col)
        else:
            cols.append(datetime.strptime(col, "%m/%d/%y").date())
            death_date_cols.append(datetime.strptime(col, "%m/%d/%y").date())

    death_df.columns = cols


    ##///**** REBUILD COUNTY_DAILY_DF - This takes a while 15ish Minutes


    #//*** Integrate Confirmed and Deaths with Vaccine Data. Build derived Values
    i = 0

    print("Begin Merge Confirm and Deaths Columns with Vaccination Rows....")
    county_daily_df = pd.DataFrame()

    for FIPS in death_df.sort_values(['FIPS'])['FIPS'].unique():

        
        i += 1

        attrib = death_df[death_df['FIPS'] == FIPS]



        #loop_df = pd.concat([loop_df] * (len(death_df[death_df['FIPS']==GEOID])),ignore_index=True)

        #//*** Merge Combined Key and Population. Grab a subset of FIPS from death_df
        #loop_df = loop_df.merge(death_df[death_df['FIPS']==GEOID][['FIPS','Combined_Key','Population']],left_on='GEOID',right_on='FIPS')

        #//*** Get Confirmed Values for FIPS County
        loop_df = confirm_df[confirm_df['FIPS']==FIPS][confirm_date_cols].transpose()

        loop_df = loop_df.reset_index()

        loop_df.columns = ['Date','tot_confirm']



        #//*** Build Total Deaths for FIPS County
        ds = death_df[death_df['FIPS']==FIPS][death_date_cols].transpose()

        ds = ds.reset_index()
        ds.columns = ['Date','tot_deaths']
        del ds['Date']

        #//*** Keep Relevant Columns

        for col in ['FIPS','Admin2','Province_State','Combined_Key','Population']:
            loop_df[col]=attrib[col].iloc[0]

        loop_df = loop_df[['Date','FIPS','Admin2','Province_State','Combined_Key','Population','tot_confirm']]

        #//*** Generate new rows based on length of death series
        #loop_df = pd.concat([loop_df] * len(ds),ignore_index=True)




        #//*** Join Confirmed Values
        #loop_df = loop_df.join(cs)

        #loop_df = cs

        #//*** Merge Death Values
        loop_df = loop_df.join(ds)

        #//*** Build New Confirmed Cases
        loop_df['New_Confirm']  = loop_df['tot_confirm'].diff()
        #//*** Reset Negative Cases to 0
        loop_df.loc[loop_df['New_Confirm'] < 0,f'New_Confirm']=0


        #//*** Build New Death Cases
        loop_df['New_Deaths']  = loop_df['tot_deaths'].diff()

        #//*** Reset Negative Deaths to 0
        loop_df.loc[loop_df['New_Deaths'] < 0,f'New_Deaths']=0
        #print(cs)
        #print(ds)

        #//*** Build New Confirmed 7 Day Average
        loop_df['case_7_day_avg']  = loop_df['New_Confirm'].rolling(7).mean()

        #//*** Build New Deaths 7 Day Average
        loop_df['death_7_day_avg']  = loop_df['New_Deaths'].rolling(7).mean()

        #//*** Build New Confirmed 100k 7 day  Average
        loop_df['case_100k_avg']  = loop_df['case_7_day_avg'] / (loop_df['Population'] / 100000 )

        #//*** Build New Confirmed 100k 7 day  Average
        loop_df['death_100k_avg']  = loop_df['death_7_day_avg'] / (loop_df['Population'] / 100000 )

        #//*** Set scaled Values to a max of 100 for heatmap purposes
        loop_df['case_scaled_100k'] = loop_df['case_100k_avg']
        loop_df['death_scaled_100k'] = loop_df['death_100k_avg']

        loop_df.loc[loop_df[f"case_scaled_100k"] > 100,f"case_scaled_100k"]=100
        loop_df.loc[loop_df[f"death_scaled_100k"] > 5,f"death_scaled_100k"]=5


        #loop_df['Date'] = loop_df['Date'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y").date())
        #print(vax_df[vax_df['FIPS']==GEOID])

        #loop_df = loop_df[ loop_df['Date'] >= vax_df['Date'].min() ]
        #del loop_df['FIPS']
        #loop_df = loop_df.merge(vax_df[vax_df['FIPS'] == GEOID],left_on='Date',right_on='Date',how='left')


        #//*** All Data merged and Calculated. Merge with temporary Dataframe()
        county_daily_df = pd.concat([county_daily_df,loop_df])

        if i % 100 == 0:
            print(f"Working: {i} of {len(death_df['FIPS'].unique())}")

    county_daily_df = county_daily_df.dropna()

    print(f"Writing county daily to File: {county_daily_df_filename}")
    county_daily_df.to_pickle(county_daily_df_filename)
    print("Done!")    

def load_data(**kwargs):
    data_folder_name = "raw_data"

    action = None

    filename = None

    min_date = None

    date_col = "Date"

    for key,value in kwargs.items():

        if key == "action":
            action = value

        if key == 'folder':
            data_folder_name = value

        if key == 'file':
            filename = value

        if key == 'min_date':
            min_date = value

        if key == 'date_col':
            date_col = value

    current_dir = Path(os.getcwd()).absolute()
    data_dir = current_dir.joinpath(data_folder_name)

    if action == "county_vaccine":
        county_vaccine_data_filename_1 = data_dir.joinpath("z_1_us_county_vaccination.csv.zip")
        county_vaccine_data_filename_2 = data_dir.joinpath("z_2_us_county_vaccination.csv.zip")


        #print("Loading Raw Vaccine Data")
        #//*** read Raw Vaccine csv
        county_vax_df = pd.concat([pd.read_pickle(county_vaccine_data_filename_1),pd.read_pickle(county_vaccine_data_filename_2)])


        #//*** Filter Columns to get just the Completed Values
        cols = ['Date','FIPS','Recip_County','Recip_State','Series_Complete_Pop_Pct','Series_Complete_Yes','Administered_Dose1_Pop_Pct','Administered_Dose1_Recip']


        #//*** remove States not in continental US
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "AK" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "HI" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "AS" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "GU" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "MP" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "PR" ]
        county_vax_df = county_vax_df[county_vax_df["Recip_State"] != "VI" ]
        county_vax_df = county_vax_df[county_vax_df["FIPS"] != "UNK" ]
        county_vax_df['FIPS'] = county_vax_df['FIPS'].astype(int)
        county_vax_df['Date'] = county_vax_df['Date'].apply(lambda x: datetime.strptime(x, "%m/%d/%Y").date())

        county_vax_df = county_vax_df[cols]

        #//*** Cleanup Column Names
        ren_cols = {
        'Administered_Dose1_Recip' : 'first_dose_count',
        'Administered_Dose1_Pop_Pct' : 'first_dose_pct',
        'Series_Complete_Yes' : 'total_vaccinated_count',
        'Series_Complete_Pop_Pct' : 'total_vaccinated_percent',
        }

        cols = list(county_vax_df.columns)

        for find,replace in ren_cols.items():
            cols = [replace if i==find else i for i in cols]

        county_vax_df.columns=cols
            
        return county_vax_df

    if filename != None and action == None:
        
        if ".zip" in filename:

            df = pd.read_pickle(data_dir.joinpath(filename))

        else:

            df = pd.read_csv(data_dir.joinpath(filename))

        if min_date != None:

            df = df [ df[date_col] >= min_date]

        return df

def merge_df(df1,df2,**kwargs):

    by = 'Date'
    left_col = None
    right_col = None
    date_col = "Date"

    for key,value in kwargs.items():

        if key == 'by':
            by = value

        if key == 'left_col':
            left_col = value

        if key == 'right_col':
            right_col = value

        if key == 'date_col':
            date_col = value

    out_df = pd.DataFrame()

    for group in df1.groupby(by):
        
        clear_output(wait=True)
        print("Processing: ", group[0])

        loop_df1 = group[1].copy()

        loop_df2 = df2[df2[by] == group[0]]

        del loop_df2[date_col]


        out_df = pd.concat([out_df,loop_df1.merge(loop_df2,left_on=left_col,right_on=right_col)])
    
    clear_output(wait=True)
    return out_df


        

        

