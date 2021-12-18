#//*** This thread helped with the connection
#//***https://stackoverflow.com/questions/37692780/error-28000-login-failed-for-user-domain-user-with-pyodbc

#//**** Update the ODBC Driver
#//**** https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver15
import pyodbc
import datetime
import json
from datetime import date, timedelta
import pandas as pd
print(pyodbc.drivers())
import numpy as np
from sklearn.feature_extraction.text import TfidfVectorizer
import time

def harvest_terms(input_df,terms,**kwargs):
    
    post_story_count = 0
    post_filter = "PKG"
    post_filter_field = "storyslug"
    post_filter_all = False
    format_title_id = True
    pkg_only = False
    pkg_only_field = "storyslug"
    
    for key,value in kwargs.items():
        if key == "post_story_count":
            post_story_count = value
        
        if key == "post_filter":
            post_filter = value
        
        if key == "post_filter_field":
            post_filter_field = value
        
        if key == "post_filter_all":
            post_filter_all = value
        
        if key == "format_title_id":
            format_title_id = value
            
        if key == "pkg_only":
            pkg_only = value
    
    harvest_field = 'StoryText'
    df = input_df.copy()
    df['search'] = df[harvest_field].str.lower()
    
    combined_dex = []
    
    #//*** Terms are an OR operation.
    #//*** Get index values for each term, combine all index results to build dataframe
    for term in terms:
        term = term.lower()
        combined_dex = combined_dex + list(df[df['search'].str.contains(term)].index)
        
    #print(combined_dex)
    df = input_df.loc[combined_dex]
    
    origdex = df.index
    #//*** gather adjacent stories
    if post_story_count > 0:
        
        
        newdex = []

        for index in df.index:
            newdex.append(index)

            for x in range(1,post_story_count+1):
            	if (index+x) in input_df.index:
            		newdex.append(index+x)


        #print("Newdex: ", len(newdex),newdex)
        df = input_df.loc[newdex]
        df = df.drop_duplicates()  
    
        #//*** Check for Post Filters
        if len(post_filter) > 0:

            #//*** Validate post_filter_field
            if post_filter_field not in df.columns:
                print("Need valid post_filter_field.")
                print(f"post_filter_field={list(df.columns)}")
                return
            
            if post_filter_all:
                df = df[df[post_filter_field].str.contains(post_filter)]
            else:
                post_df = df[df[post_filter_field].str.contains(post_filter)]
                #print(list(origdex))
                #print(list(post_df.index))

                mergedex = sorted(list(origdex) + list(post_df.index))
                df = input_df.loc[mergedex]
    
    #//*** Post Filter Single Result
    else:
        #//*** Check for Post Filters
        if len(post_filter) > 0:

            #//*** Validate post_filter_field
            if post_filter_field not in df.columns:
                print("Need valid post_filter_field.")
                print(f"post_filter_field={list(df.columns)}")
                return
        
            df = df[df[post_filter_field].str.contains(post_filter)]
        
        
    
    #//*** Format title_id with a formatted header for easy copy and paste
    if format_title_id:
        #print(dir(df['start_date'].iloc[0]))
        months = df['start_date'].apply(lambda x: x.month_name())
        dow = df['start_date'].apply(lambda x: x.day_name())
        day = df['start_date'].apply(lambda x: x.day ).astype(str)
        year = df['start_date'].apply(lambda x: x.year ).astype(str)
        df['title_id'] = dow + ", " + months + " " + day + ", " + year + ", ABC7 News " 
        df['title_id'] = df['title_id'] + df['rundown'].str.replace("Weekday","")
        df['title_id'] = df['title_id'] + "(" + df['time'] + ")"
        
        dm = df['start_date'].apply(lambda x: x.month ).astype(str)
        
        df['start_date'] = dm + "-" + day + "-" + year
    
    #//*** If PKG Only, keep only stories with PKG in the slug
    if pkg_only:
        df = df[df[pkg_only_field].str.contains("PKG")]
    
    
    #//*** Apply Title Case to all storytext Scripts.
    #df['StoryText'] = df['StoryText'].apply(lambda x: x.title())
    
    #//*** Drop any Duplicates
    df = df.drop_duplicates()        
    return df

#harvest_terms(qtr_df,["melanie woodrow","dan noyes"],
#              post_story_count=0, 
#              post_filter = "PKG",
#              post_filter_field="storyslug",
#              pkg_only = True
#              )

#babba_df = qtr_df[qtr_df['StoryText'].str.contains("building a better bay area")].copy()

#for index in babba_df.index:
   


def convert_duration(x):
    mins = str(x // 60)
    secs = str(x % 60)
    
    if len(secs) == 1:
        secs = "0" + secs
    
    return mins + ":" + secs


# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
server = 'tcp:OM-CASF-DB01' 
server = 'OM-CASF-DLSQL' 
# server = '10.218.97.2'
database = 'DaletDB' 

with open('./ignore_folder/misc.json') as f:
    data = json.loads(f.read())

username = data["user"] 
password = data["password"]
del data
#cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cnxn = pyodbc.connect('Trusted_Connection=yes;DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

#//************************************************************
#//************************************************************
#//*** get all Rundowns in given Quarter
#//************************************************************
#//************************************************************

#//*** Table: titles
#//*** Search Titles by Date to get Rundown IDs
#//*** Titles Contains All titled Objects including scripts rundowns and MOS objects
#//*** title_type_id = 25 <--- Rundown Objects
#//*** duration > 900000 <--- Rundowns Longer than 15 minutes (15 * 60 Seconds * 1000 ms)
#//***                        Automatically filters out short content like cutins
title_cols = ['title_id','title_type_id','title','duration','start_date']
import datetime


tgt_year = 2021
quarter = "Q4"

#//*** Build the BETWEEN portion of the query based on quarter and YEAR

quarter_query = ""
if quarter == "Q1":
    quarter_query = f"'{tgt_year}-01-01T00:00:00' AND '{tgt_year}-03-31T23:59:59'"

elif quarter == "Q2":
    quarter_query = f"'{tgt_year}-04-01T00:00:00' AND '{tgt_year}-06-30T23:59:59'"

elif quarter == "Q3":
    quarter_query = f"'{tgt_year}-07-01T00:00:00' AND '{tgt_year}-09-30T23:59:59'"

elif quarter == "Q4":
    quarter_query = f"'{tgt_year}-09-01T00:00:00' AND '{tgt_year}-12-31T23:59:59'"

query = f"""
SELECT *
FROM titles 
WHERE title_type_id = 25 
    AND duration > 900000
    AND start_date BETWEEN {quarter_query}
    AND title <> 'Prepak'
    AND title <> 'Tool Kit'
    AND title <> 'Tricaster'
    AND title <> 'PRODUCER HOLD'
    AND title <> 'Promo'
    AND title <> 'Breaking News'
    AND title <> 'Dalet OD XPression'
    AND title <> 'PRACTICE'
    AND title <> '7AM DIGITAL'
"""


cursor.execute(query)
results = cursor.fetchall()
#results = cursor.fetchmany(100)

all_rundowns_df = pd.read_sql(query,cnxn)

print(all_rundowns_df.columns)

all_rundowns_df = all_rundowns_df[title_cols]

#//*** Filter out shows that SAY DO NOT USE
all_rundowns_df = all_rundowns_df[all_rundowns_df['title'].str.contains('DO NOT USE')==False]

#//*** Convert Start_Date to Date only
all_rundowns_df['start_date'] = all_rundowns_df['start_date'].apply(lambda x: x.date())

all_dates = all_rundowns_df['start_date'].unique()

#//*** Pick one day to test with
one_day_df = all_rundowns_df[all_rundowns_df['start_date'] == all_dates[-3]]


print("Quarterly Shows : ", len(all_rundowns_df))
print("Quarterly Show Hours: ", all_rundowns_df['duration'].sum() / 60000 / 60)

qtr_df = pd.read_excel(f'{tgt_year}_{quarter}_Stories.xlsx')
#//*** Trim unnamed First Column (original Index)
del qtr_df[qtr_df.columns[0]]

#qtr_df['search'] = qtr_df['StoryText'].str.lower()
print(qtr_df)




#//***************************************************************************
#//***************************************************************************
#//*** Scrape All Stories For the Given Quarter and export to XLS
#//***************************************************************************
#//***************************************************************************
qtr_df = pd.DataFrame()
for date in all_rundowns_df['start_date'].unique():
    one_day_df = all_rundowns_df[all_rundowns_df['start_date'] == date]
    print(date, "/", all_rundowns_df['start_date'].unique()[-1])
    for row in one_day_df.iterrows():
        loop_rundown = row[1]
        loop_title_id = loop_rundown['title_id']
        #print("Rundown ID: ", loop_title_id, loop_rundown['title'])

        #print(loop_rundown)
        #//*** Get the Blocks associated with the Selected Rundown
        query = f"""
        SELECT block_id
        FROM items 

        WHERE clock_id = '{loop_title_id}'
        """
        loop_blocks = pd.read_sql(query,cnxn)['block_id'].unique()

        #//*** Find the A-Block of Selected Rundown
        #//**** Block Query gets just the A BLOCK from the Rundown Block
        #//*** Combines all Blocks into a single query and returns only the A-Block
        block_query = ""
        for block_id in loop_blocks:
            if block_id == loop_blocks[0]:
                block_query += f"(block_id='{block_id}' "
            else:
                block_query += f"OR block_id='{block_id}' "
        block_query += ") AND title='A BLOCK'"

        query = f"""
        SELECT *
        FROM blocks 
        WHERE {block_query}
        """

        tdf = pd.read_sql(query,cnxn)
        #//*** A Block of Selected Rundown
        if len(tdf) == 0:
            print("================")
            print("NO A-Block Found")
            print("================")
            print(one_day_df)
            continue

        a_block = tdf["block_id"].values[0]
        #print("A Block:",a_block)

        #//******************************
        #//*** Get A-Block Story Titles 
        #//******************************
        query = f"""
        SELECT title_id
        --SELECT block_id,item_id,title_id
        FROM spots 
        WHERE block_id = '{a_block}'
        """

        title_id_list = pd.read_sql(query,cnxn)['title_id'].values


        #//****************************************************
        #//*** Get title_id, Story Slug, and Duration
        #//*** Only get Stories with Greater than 0 Duration
        #//****************************************************

        #//*** Build Single Query to get all Titles from Selected Rundown

        title_id_query = ""
        for title_id in title_id_list:
            if title_id == title_id_list[0]:
                title_id_query += f"title_id='{title_id}' "
            else:
                title_id_query += f"OR title_id='{title_id}' "

        query = f"""
        SELECT title_id,title_type_id,title,duration
        FROM titles 
        WHERE {title_id_query}
        """

        titles_df = pd.read_sql(query,cnxn)

        #//*** Remove Stories with Zero Duration
        #//*** This Removes stories with no text
        titles_df = titles_df[titles_df['duration'] > 0]

        #//*** Remove stories with the word tease in slug
        titles_df = titles_df[titles_df['title'].str.lower().str.contains('tease') == False]
        #print(titles_df)
        #//*** Get StoryBody Text
        story_id_list = titles_df['title_id'].values
        story_id_query = ""
        for story_id in story_id_list:
            if story_id == story_id_list[0]:
                story_id_query += f"TitleId='{story_id}' "
            else:
                story_id_query += f"OR TitleId='{story_id}' "

        query = f"""
        SELECT TitleId,StoryText
        FROM StoryContent
        WHERE {story_id_query}
        """

        text_df = pd.read_sql(query,cnxn)
        #print(text_df)

        #//*** Build Stories_df List of all Stories in show with Text and Title
        #//*** Merge titles_df and text_df 
        stories_df = titles_df.merge(text_df,left_on='title_id',right_on='TitleId')

        #//*** Delete the duplicate column
        del stories_df['TitleId']

        #//********************
        #//*** Clean the Text
        #//********************

        #//*** Remove Brackets [[ ]]
        stories_df['StoryText'] = stories_df['StoryText'].str.replace('\[\[\*\*\*.*?\*\*\*\]\]','\\n',regex=True)

        #//*** Remove paranthesis (( ))
        stories_df['StoryText'] = stories_df['StoryText'].str.replace('\(\(.*?\)\)','\\n',regex=True)

        #//*** Covert \r\n to \n
        stories_df['StoryText'] = stories_df['StoryText'].str.replace('\\r\\n','\\n',regex=True)

        #//*** Convert Multiple \n to single \n
        stories_df['StoryText'] = stories_df['StoryText'].str.replace('\\n\\W*\\n','\\n',regex=True)

        #//*** Delete leading \n
        stories_df['StoryText'] = stories_df['StoryText'].str.replace('^\\W*\\n','',regex=True)
        #print(stories_df.iloc[7]['StoryText'])

        #//*** Rename title column to storyslug
        stories_df.columns = ['storyslug' if x=='title' else x for x in list(stories_df.columns)]


        #//*** Start Date, Title, from the current rundown. This Column will have the same value for all rows.
        static_cols = ['start_date','title']

        for col in static_cols:
            stories_df[col] = loop_rundown[col]

        #//*** Shift the static_cols to the beginning of the column list for readability
        cols = (static_cols + list(stories_df.columns))[:(len(static_cols)*-1)]

        stories_df = stories_df[cols]


        #//*** Rename title column to storyslug
        stories_df.columns = ['rundown' if x=='title' else x for x in list(stories_df.columns)]


        #print(cols)
        #print(stories_df)
        qtr_df = pd.concat([qtr_df,stories_df],ignore_index=True)
        #//*** End Get Single Rundown Stories
    
    #//*** End Each Day of Rundowns

#//*** Remove Stories with 0 length Text
qtr_df['StoryText'] = qtr_df['StoryText'].astype(str)
qtr_df['length'] = qtr_df['StoryText'].apply(lambda x : len(x))
qtr_df = qtr_df[qtr_df['length'] > 20]

if 'title_type_id' in qtr_df.columns:
    del qtr_df['title_type_id']
    
if 'length' in qtr_df.columns:
    del qtr_df['length']
#tdf = qtr_df
qtr_df['duration'] = (qtr_df['duration'] /1000).astype(int)    

qtr_df['time'] = qtr_df['duration'].apply(lambda x: convert_duration(x))

#//**** Move StoryText to the last Column
cols = list(qtr_df.columns)
cols.remove('StoryText')
cols.append('StoryText')
qtr_df = qtr_df[cols]

#//*** Drop Duplicate Scripts
qtr_df = qtr_df.drop_duplicates(subset=['StoryText'])

# Create a Pandas Excel writer using XlsxWriter as the engine.
writer = pd.ExcelWriter(f'{tgt_year}_{quarter}_Stories.xlsx', engine='xlsxwriter')
qtr_df.to_excel(writer,sheet_name='sheet1')
writer.save()

qtr_df
#print("Done")

    
 #tgt_year = 2021
#quarter = "Q4"



    
search_df = pd.read_excel("Searches.xlsx",sheet_name="search")
#//*** Drop Rows where Name is N/A
search_df = search_df.dropna(subset=["name"])

search_df['pkg_only'] = search_df['pkg_only'].astype(bool)

#//*** Replace NaN with empty String, these are blank parameters
search_df = search_df.replace(np.nan,"")

out = {}
#print(search_df)
for row in search_df.iterrows():
    
    #try:
        
    name = row[1]["name"]
    post_story_count = int(row[1]["post_story_count"])
    #post_filter = row[1]["post_filter"]
    #post_filter_field = row[1]["post_filter_field"]
    pkg_only = row[1]["pkg_only"]
    search_terms = row[1]['search_terms'].split(",")

    #print(name,":",search_terms,post_story_count,post_filter,post_filter_field,pkg_only)
    #print(post_filter,post_filter_field)

    out[name] = harvest_terms(qtr_df,search_terms,
              post_story_count=post_story_count, 
              #post_filter = post_filter,
              #post_filter_field= post_filter_field,
              pkg_only = pkg_only,
              ),
    #except:
    #    print("=======================================================================")
    #    print(f"Something went wrong Processing {row[0]}")
    #    print("Skipping that line and leaving a thoroughly unhelpful error message")
    #    print("=======================================================================")
    
# Create a Pandas Excel writer using XlsxWriter as the engine.
writer = pd.ExcelWriter(f'{tgt_year}_{quarter}_Collected_Stories.xlsx', engine='xlsxwriter')

for sheet,df in out.items():
    df[0].to_excel(writer,sheet_name=sheet)
#qtr_df.to_excel(writer,sheet_name='sheet1')
try:
    writer.save()    
except:
    print("Trouble Saving the Spreadsheet. It's Probably Open Somewhere. Close it and Retry")