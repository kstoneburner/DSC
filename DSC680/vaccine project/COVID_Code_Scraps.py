#//*** Convert classifieres to integers. Keep a dictionary of the converted Values
"""
tdf["case_positive_specimen_interval"].unique()
tdf["case_onset_interval"].unique()
tdf["process"].unique()
tdf['hosp_yn'].unique()
tdf['death_yn'].unique()
tdf['underlying_conditions_yn'].unique()
tdf.corr()



classifier_dict = {
    'age_group' : {
        -1 : np.nan,
        0 : '0 - 17 years',
        1 : '18 to 49 years',
        2 : '50 to 64 years',
        3 : '65+ years'
    }
}


tdf = pd.read_pickle("./raw_data/AK_covid_people.pkl.zip")
#//*** Drop Rows with NaN county FIPS Code
tdf = tdf.dropna(subset="county_fips_code")

for col in tdf.columns:
    if col in base_cols:
        continue
    #print (col,tdf[col].dtype)
    
    #//*** Replace Float Value NaN with -1
    if tdf[col].dtype == 'float64':
        tdf[col] = tdf[col].replace(np.nan,-1)
        #print(tdf[col].unique())
        continue
    if tdf[col].dtype == 'object':
        #//*** Replace Nan  with -1
        tdf[col] = tdf[col].replace(np.nan,-1)
        #//*** Initialize Col if needed
        if col not in classifier_dict.keys():
            #//*** Initialize -1 as NaN
            classifier_dict[col] = {
                -1 : np.nan,
            }
        
        #//*** Create integer classifier for loop_dict
        for key,value in enumerate(tdf[col].unique()):
            
            if value == -1:
                continue
            #//*** add to dictionary if Value doesn't already exist
            if value not in classifier_dict[col].values():
                
                #//*** Double Check Key doesn't exist
                if key not in classifier_dict[col].keys():
                    classifier_dict[col][key] = value
                else:
                    print(f"key {key} already exists! Something is amiss here!")
            
            #//*** Update Dictionary
            #loop_dict[key] = value
            
        #//*** Replace Values with Classifier Integer
        for key,value in classifier_dict[col].items():
            tdf[col] = tdf[col].replace(value,key)
        
        continue
        
    print(f"Unknown Column Type: {col} - {tdf[col].dtype} ")

"""



#//*** Download 9gb Raw Dataset
"""
outcome_url = "https://data.cdc.gov/api/views/n8mc-b4w4/rows.csv?accessType=DOWNLOAD"
outcome_url = "https://data.cdc.gov/resource/n8mc-b4w4.json"
outcome_url = "https://data.cdc.gov/api/views/n8mc-b4w4/rows.csv?accessType=DOWNLOAD&api_foundry=true"
outcome_filename = "./raw_data/covid_outcomes.csv"
raw_outcome_filename = "./ignore/COVID-19_Case_Surveillance_Public_Use_Data_with_Geography.csv"
"""

"""
print(f"Downloading {outcome_url}")
response = requests.get(outcome_url)
if response.ok:
    print(f"{outcome_url} Downloaded")
    f = open(outcome_filename, "w")
    f.write(response.text)
    f.close()
    print(f"{outcome_filename} Data Written to file.")
"""
print()

#//*** Load 9gb File and split into individual statewide pickled compressed dataframes
#//*** 
"""
df = pd.read_csv(raw_outcome_filename)
df.head()

#//*** Group by state, save each state group as a compressed dataframe.
for group in df.groupby('res_state'):
    print(group[0])
    group[1].to_pickle(f"./raw_data/{group[0]}_covid_people.pkl.zip")
"""
print()


def cleanup_cols(cols,**kwargs):
    cols = list(cols)
    #//*** Explicit Column names to remove
    remove_cols = []
    
    #//*** Remove Column if text appears in column name
    remove_text = []
    
    for key,value in kwargs.items():
        if key == 'remove_cols':
            remove_cols = value
        
        if key == "remove_text":
            remove_text = value
    
    #//*** Output cleaned up columns
    out = []

    #//*** Loop through each column name
    for col in cols:
        
        #//*** if Column in remove_cols, skip it
        if col in remove_cols:
            continue
        
        #//*** Set to True if partial text found
        remove = False
        
        #//*** Loop through partial remove text
        for partial in remove_text:
            
            #//*** Flag if Partial is found in col
            if partial in col:
                remove = True
                break
        
        if remove:
            continue
        
        out.append(col)
        #.replace("_7_day_avg","")
    
    return out
"""
#//*** Let's do some cleanup
remove_cols = ['ccn','zip','address',"geocoded_hospital_address","hhs_ids","is_corrected",
               "staffed_icu_adult_patients_confirmed_covid_7_day_avg", 
               "total_pediatric_patients_hospitalized_confirmed_covid_7_day_avg",
               #"total_beds_7_day_avg",
               "total_adult_patients_hospitalized_confirmed_covid_7_day_avg",
               "all_adult_hospital_beds_7_day_avg",
               "all_adult_hospital_inpatient_beds_7_day_avg",
               "all_adult_hospital_inpatient_bed_occupied_7_day_avg",
               "total_adult_patients_hospitalized_confirmed_and_suspected_covid_7_day_avg",
               "total_pediatric_patients_hospitalized_confirmed_and_suspected_covid_7_day_avg",
               "total_staffed_adult_icu_beds_7_day_avg",
               
               "fips_code",
               "is_metro_micro"
                      ]
"""
#remove_text = ['influenza',"_sum","_coverage","previous_","vaccinated_",]

#disp_cols = cleanup_cols(hosp_df.columns, remove_cols=remove_cols, remove_text=remove_text)



#hosp_df[hosp_df['fips_code'] == 6037] [disp_cols]['hospital_name'].unique()

#hosp_df[hosp_df['hospital_name'] == "CEDARS-SINAI MEDICAL CENTER"] [disp_cols].sort_values("collection_week")
#hosp_df[hosp_df['fips_code'] == 6029] [disp_cols]['hospital_name'].unique()

#//*********************************************************************
#//**** Download and Process Code
#//**** Keeping a backup here because, there's a lot invested here
#//*********************************************************************

#//*** Download 
reload(process_covid)

perform_update = False

#//*** Full Update takes 26 Minutes
if perform_update:    
    import time
    
    start_time = time.time()
    #//***************************************************************************************************
    #//*** Download Latest Data - Updates Daily for Confirmed And Deaths
    #//***************************************************************************************************
    pc = process_covid.download_data()
    
    print(f"Data Downloaded: {int(time.time() - start_time)}s")
    
    #//*** Merge County Level Cases and Deaths. Converts Column based Days to Row based Days.
    process_covid.build_county_case_death(
        folder = data_folder_name,
        confirm = confirmed_data_filename,
        death = death_data_filename,
        export = county_daily_df_filename,
    )
    
    print(f"Total Elapsed Time: {int(time.time() - start_time)}s")
    
    #//***************************************************************************************************
    #//*** Build Weekly Aggregated hospital Values. Sum all hospital stats for each county by Week
    #//*** Exports to File
    #//***************************************************************************************************
    #//*** 4 - 5 Minute Process!
    #//***************************************************************************************************
    #//*** Load Raw Hospital Data
    raw_hosp_df = process_covid.load_data(filename="z_county_hospital.csv.zip")
    
    #//*** Columns to Display
    disp_cols = ['collection_week', 'fips_code','state', 'total_beds_7_day_avg','inpatient_beds_7_day_avg','inpatient_beds_used_7_day_avg', 'inpatient_beds_used_covid_7_day_avg', 'total_icu_beds_7_day_avg', 'icu_beds_used_7_day_avg','staffed_icu_adult_patients_confirmed_and_suspected_covid_7_day_avg']

    #//*** Descriptive Classification Columns: Will take a single value
    base_cols = ['collection_week', "fips_code",'state']

    #//*** Columns to Process, ie sum 
    process_cols = ['total_beds_7_day_avg','inpatient_beds_7_day_avg','inpatient_beds_used_7_day_avg', 'inpatient_beds_used_covid_7_day_avg', 'total_icu_beds_7_day_avg', 'icu_beds_used_7_day_avg','staffed_icu_adult_patients_confirmed_and_suspected_covid_7_day_avg']


    #//***************************************************************************************************
    #//*** Aggregate (sum) Raw Hospital Data
    #//*** Combine all Hospitals in each county on a given day.
    #//***************************************************************************************************
    process_covid.aggregate_columns(raw_hosp_df,
        by = "fips_code", #//*** All Granular Values to sum. All Hospitals in a County
        date_col = 'collection_week', #//*** Date Column 
        method = 'sum', #//*** Add Columns
        base_cols = base_cols, #//** Descriptive Columns
        process_cols = process_cols, #//*** Columns to Sum
        disp_cols = disp_cols, #//*** Columns to Display
        folder="raw_data",
        export=aggregate_hospital_filename, #//*** Filename to export DataFrame Too
    )
    print(f"Total Elapsed Time: {int(time.time() - start_time)}s")

    
    #//***************************************************************************************************
    #//*** Merge Cases & Deaths with Vaccines
    #//*** Daily Interval, by County
    #//***************************************************************************************************
    
    #//*** Load Vaccine Data. County Level, Daily Interval
    county_vax_df = process_covid.load_data(action="county_vaccine")
    display(county_vax_df)

    #//*** Load Confirmed Cases and Deaths
    county_daily_df = process_covid.load_data(file=county_daily_df_filename, min_date=county_vax_df['Date'].min())
    county_daily_df = county_daily_df[county_daily_df["Population"] > 0]
    display(county_daily_df)
    
    #//*** Merge Daily Cases
    process_covid.merge_df(county_vax_df,county_daily_df,by="Date",left_col="FIPS",right_col="FIPS",export=combined_daily_casevax_filename)
    
    #//***************************************************************************************************
    #//*** Convert Combined Cases & Deaths & Vaccines
    #//*** To Weekly Interval from Daily
    #//*** by County 
    #//***************************************************************************************************
    
    #//*** Load the Combined Daily Cases and Vaccinations by County
    daily_casevax_df = process_covid.load_data(filename=combined_daily_casevax_filename)

    #//*** Convert county daily to weekly interval
    #//*** 10 Minute Build
    process_covid.create_weekly_data(daily_casevax_df,export=weekly_combined_filename,dates=hosp_df['collection_week'].unique() )

    #//***************************************************************************************************
    #//*** Combine Aggregated Hospital Data with Weekly Cases & Deaths & Vaccines
    #//*** Weekly Interval
    #//*** By County
    #//***************************************************************************************************

    #//*** Load Weekly Case Death Vax by County
    casevax_weekly_df = process_covid.load_data(filename=weekly_combined_filename)
    
    #//*** Load Weekly Aggregated Hospital by County
    week_hosp_df = process_covid.load_data(filename=aggregate_hospital_filename)
    
    #//*** Convert collection_week to datetime
    week_hosp_df["collection_week"] = pd.to_datetime(week_hosp_df["collection_week"])

    #//*** Rename columns: collection_week --> Date
    week_hosp_df.columns = ['Date' if item == 'collection_week' else item for item in week_hosp_df.columns]
    #//*** Rename columns: fips_code --> FIPS
    week_hosp_df.columns = ['FIPS' if item == 'fips_code' else item for item in week_hosp_df.columns]

    #//*** Merge Hospital and Case Death Vax Dataframes
    process_covid.merge_df(casevax_weekly_df, #//*** Left Df
                           week_hosp_df,      #//*** Right DF
                           by="Date",         #//*** Aggregate using By Column (should always be a date column since this is a timeseries)
                           left_col="FIPS",   #//*** Left Col to Merge
                           right_col="FIPS",  #//*** Right Col to Merge
                           remove_cols = ['Recip_County'], #//*** Remove these columns for tidiness
                           export=weekly_combined_cdvh_df_filename)

    
    print(f"DONE! Total Elapsed Time: {int(time.time() - start_time)}s")
