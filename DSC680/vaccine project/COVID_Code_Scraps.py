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