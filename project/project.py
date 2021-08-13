import json
import pandas as pd
import time
from datetime import datetime
import numpy as np

from sklearn.metrics import r2_score
from sklearn.metrics import mean_squared_error
from sklearn.metrics import mean_absolute_error
from math import sqrt

#//******************************************************************************
#//*** Builds the URL request based on the symbol and type of data requested.
#//*** Initially, this does the daily numbers.
#//*** Can easily be scaled up to add many different URL request types
#//******************************************************************************
def build_url(input_action,input_symbol,m=1,y=1):
    
    
    f = open("./ignore_folder/alpha_vantage_api.json", "r")

    #//*** Fugley Pythonic type conversion
    #//*** Loads the file into Dictionary via JSON.loads
    #//*** Gets the API key value using the 'api' key
    #//*** prepends apikey= so the resulting value is URL ready :]
    av_apikey = json.loads(f.read())['apikey']
    f.close()

    #//*** Valid Actions:
    #//*******  Daily: Gets the historical daily closing price for up to 20 years
    print(input_symbol,input_action)
    if input_action == 'daily':
        action = "TIME_SERIES_DAILY"
        out = ""
        out += f'https://www.alphavantage.co/query?'
        out += f'function={action}'
        out += f'&symbol={input_symbol}'
        out += f'&outputsize=full'
        out += f'&apikey={av_apikey}'
        
        return out
    
    if input_action == '1min':
        action = "TIME_SERIES_INTRADAY_EXTENDED"
        out = ""
        out += f'https://www.alphavantage.co/query?'
        out += f'function={action}'
        out += f'&symbol={input_symbol}'
        out += f'&outputsize=full'
        out += f'&slice=year{y}month{m}'
        out += f'&interval=1min'
        #out += "datatype=json"
        #out += f'&adjusted=true',
        #out += "&slice=year1month1",
        out += f'&apikey={av_apikey}'
        
        return out
    
    if input_action == '60min':
        action = "TIME_SERIES_INTRADAY_EXTENDED"
        out = ""
        out += f'https://www.alphavantage.co/query?'
        out += f'function={action}'
        out += f'&symbol={input_symbol}'
        out += f'&outputsize=full'
        out += f'&slice=year{y}month{m}'
        out += f'&interval=60min'
        #out += "datatype=json"
        #out += f'&adjusted=true',
        #out += "&slice=year1month1",
        out += f'&apikey={av_apikey}'

    return out
    print(f"Invalid Action: {input_action}")
    print(f"No URL Returned, PLease try again")
    return None
    

#//*** Prepare the raw stock information for modeling
#//*** 1. Convert Time Date to Date Formatting
#//*** 2. Generates the target predictions for training. targets is an integer list used generate future targets. 
#//***    This allows multiple independent variables to be generated in a single pass. Although the current model 
#//***    Only Processes one independent variable per run. This can be scaled to multiple predictions if needed
#//***    in the future
#//*** 3. Reorder Stocks in Descending order.
def build_stocks(symbol,interval,targets):
    
    stock_df = pd.read_csv(f"./stocks/{symbol}_{interval}.csv.zip")
    stock_df
    
    if 'date' in stock_df.columns:
        stock_df['date'] = pd.to_datetime(stock_df['date'])
        stock_df = stock_df.rename(columns={'date':'time'})
    else:
        stock_df['time'] = pd.to_datetime(stock_df['time'])
    
    for offset in targets:
        #//*** create a list of nan values of x length
        nan_list = list(np.empty( offset )* np.nan )

        #//*** Create target variable Price which is stocks + x columns in advance
        #//*** Takes the closing price starting at x and gets the remainder, this generates the offset
        #//*** nan_list fills the missing x values with nans
        target_list = nan_list + list(stock_df['close'])
        target_list.pop()
        stock_df[f'target_{offset}'] = target_list 
    
    stock_df = stock_df[:offset*-1]
    
    #//*** Reorder by time descending
    stock_df.sort_values('time',inplace=True, ignore_index=True)
    
    return stock_df


#//****************************************************************************************
#//*** Generates an inverse data set centered around a reference data set.
#//*** The value as a technical indicator is very much in the discovery phase
#//*** Presently used to used to invert actual prices around a simple moving average
#//*** The idea is to negate the lag in a simple moving average.
#//*** It's an interesting concept that has a value of dubious veracity
#//****************************************************************************************
#//*** Also looking at reversing values as the primary crosses the reference
#//*** It would be like generating an inverted curve that is entirely positive or negative 
#//*** Relative to the reference.
#//****************************************************************************************
def build_inverted_curve(primary,reference):
    
    #diff = primary - reference
    #print(primary + (diff*2))
    #return primary + (diff*2)
    
    df = pd.DataFrame()
    df['primary'] = primary
    df['reference'] = reference
    
    out = []
    for row in df.iterrows():
        
        #//*** Ignore Nan
        if np.isnan(row[1]['primary']):
            out.append(np.nan)
            continue

        if np.isnan(row[1]['reference']):
            out.append(np.nan)
            continue
            
        #//*** Generate Difference
        diff = ((row[1]['primary'] - row[1]['reference']))
        diff *= 1.5
        
        #//*** Combine results.
        result = row[1]['primary']+diff
        
        out.append(result)
        
    
    return pd.Series(out)

#//*** Calculate the Exponential Moving Average. 
#//*** Code acquired from 3rd party
def calculate_ema(prices, days, smoothing=2):
    #print(len(prices))
    ema = [sum(prices[:days]) / days]
    for price in prices[days:]:
        ema.append((price * (smoothing / (1 + days))) + ema[-1] * (1 - (smoothing / (1 + days))))
    #print(len(ema))
    
    ema = (list(np.empty(len(prices)-len(ema))*np.nan) + ema)
    #print(len(ema))
    return ema

#//*********************************************************************************************************************
#//*** All Purpose function for generating actions based on predicted data.
#//*** Action: action - Generates Buy/Hold/Sell signals (1/0/-1). Takes Actual Data, Prediction, Trade Threshold.
#//******************   Uses iterrows() to explicitly calculate each action individually. Very deliberate choice
#//******************   to avoid data leakage. Trade Threshold expressed as a percentage, is a minimum threshold
#//******************   to execute a trade. Example: 5% Threshold a predicted price must change by 5% of the 
#//******************   current price to execute. If the current price is $1, a trade will only execute if the
#//******************   predicted value is less than .95 or greater than 1.05. Higher thresholds indicate
#//******************   more conservative and less volatile strategies. One threshold limits are met, there
#//******************   is an explict decision tree of actions to take. 
#//*********************************************************************************************************************
#//*** Action: accuracy - Generates a simple accuracy percentage from actual and predicted values. Compares actual to 
#//******************   predicted. Counts rows where the values are identical.
#//*********************************************************************************************************************
#//*** Action: pl -     Generates predicted Profit/Loss based on modeled trading strategy. Walks through each buy/hold/sell
#//******************   action and simulates the profit/loss associated with the action. Each buy/sell/hold action is 
#//******************   explicitly handled. The resulting decision is based on the previousl buy/sell/hold action.
#//******************   Example: A stock can't be sold if it hasn't been bought. This leads to 9 possible outcomes 
#//******************   for each action based on the previous buy/sell/hold action. The variable position holds the
#//******************   current buy/sell/hold action as a trinary value 1/-1/0. Current_price is used to keep track
#//******************   of whether a stock is currently held, and at what price.
#//*********************************************************************************************************************
def calc_results(input_df,action,**kwargs):
    
    input_df = input_df.copy()
    
    threshold = 0
    actual_col = None
    predict_col = None
    action_col = None
    model_col = None
    get_list = False
    verbose = False
    
    for arg in kwargs:
        
        if arg == 'threshold':
            threshold = kwargs[arg]
        
        if arg == 'actual':
            actual_col = kwargs[arg]
        
        if arg == 'predict':
            predict_col = kwargs[arg]
    
        if arg == 'model':
            model_col = kwargs[arg]
    
        if arg == 'get_list':
            get_list = kwargs[arg]

        if arg == 'verbose':
            verbose = kwargs[arg]

    current_price = input_df[actual_col].iloc[0]
    
    if action=='action':
        
        #input_df['diff'] = input_df[actual_col] - input_df[predict_col]
        
        out = []
        #//*** Loop through each element
        for row in input_df.iterrows():
            
            #//*** Calculate the Row Difference as an absolute value
            row_diff = abs(current_price - row[1][predict_col] )
            
            row_thresh = current_price * threshold
            
            #//*** If the row_diff is less than the row_thresh. We are not predicting a huge price move
            #//*** Set position to 0, curent_price remains the same.
            if row_diff < row_thresh:
                #//*** Set position to hold
                out.append(0)
                continue
            else:
                #//*** Difference exceeds threshold Commit to buy sell action
                
                #//*** Actual less than Predicted. Perform Buy
                if row[1][actual_col] < row[1][predict_col]:
                       
                        #//*** Set Position to buy
                        out.append(1)
    
                        #//*** Set the Current Price for Thresholding
                        current_price = row[1][actual_col]
                        continue
                
                #//** Actual is greater than Predicted. Perform Sell
                else:
                        #//*** Set Position to Sell
                        out.append(-1)
    
                        #//*** Set the Current Price for Thresholding
                        current_price = row[1][actual_col]
                        continue
        
        #//*** Actions at Threshold Built Return it 
        return (out)

    #//**************************************
    #//**************************************
    #//**************************************
    #//**** END action=='action'
    #//**************************************
    #//**************************************
    #//**************************************
    
    if action == 'pl':
        
        #print(input_df[[actual_col,predict_col,model_col]])
        
        current_price = input_df.iloc[0][actual_col]
        pl = 0
        
        #pl -= current_price
        
        initial_price = current_price
        
        position = 1
        
        pl_list = []
        
        if verbose:
            print(f"Model Col: {model_col}")
            print(f"Actual Col: {actual_col}")
        
        
        
        for row in input_df.iterrows():

            if verbose:
                print(row[1][model_col],row[1][actual_col],current_price,pl,position)
            
            #//*** Sell Action
            if row[1][model_col] == -1:
                if verbose:
                    print("---Sell: ",position,current_price,pl)

                #//*** Perform action based on Position
                
                #//*** We have already sold
                #//*** Do Nothing and maintain Sell
                if position == -1:
                    if verbose:
                        print("------Already Sold")
                    pl_list.append(pl)
                    continue
                
                #//*** We Are holding From a Previous Position
                #//*** Check Current Price, If we have a current Price, then sell
                elif position == 0:
                    if verbose:
                        print("------Actualy Sell")
                    
                    
                    position = -1
                    
                    #//*** We have Stock, Sell it
                    if current_price > 0:
                    
                        pl += (row[1][actual_col] - initial_price)

                        current_price = 0
                

                #//*** We Previously Bought
                #//*** Change position and Sell
                elif position == 1:
                    
                    position = -1

                    #//*** Double Check current_Price to verify we can sell
                    if current_price > 0:
                        if verbose:
                            print("------Actualy Sell")
                        pl += (row[1][actual_col] - initial_price)

                        current_price = 0
                
            #//*** Hold Action
            #Basically Maintain the current Position
            elif row[1][model_col] == 0:
                if verbose:
                    print("---Hold")
                if position == -1:
                    position = 0
                    
                elif position == 0:
                    position = 0
                    
                elif position == 1:
                    position = 0
                    
                
            #//*** Buy Action
            elif row[1][model_col] == 1:
                if verbose:
                    print("---Buy")
                
                #//*** Previously Sold
                #//*** Let's Buy
                if position == -1:
                    
                    position = 1
                    
                    #//*** Double Check current_price
                    if current_price == 0:
                        
                        if verbose:
                            print("------Actually Buy -1")
                        
                        current_price = row[1][actual_col]
                        
                        pl -= (row[1][actual_col] - initial_price)
                
                #//*** Currently Holding. Let's Buy if we havent already
                elif position == 0:
                    position = 1
                    
                    #//*** Double Check current_price
                    if current_price == 0:

                        if verbose:
                            print("------Actually Buy 0")
                        
                        current_price = row[1][actual_col]
                        
                        pl -= (row[1][actual_col] - initial_price)
                
                #//*** We have already bought
                elif position == 1:
                    position = 1
                    
                    if verbose:
                        print("------Already Bought")
                        
                    pl_list.append(pl)

                    continue
            pl_list.append(pl)

        if get_list == True:
            return pl_list
        
        return round(pl,4)
            
#//*** Generate the simple accuracy of the Actual vs predicted values
    if action == 'accuracy':
        if verbose:
            print(f"Actual: {actual_col} Predict: {predict_col}")
        return (input_df[actual_col] == input_df[predict_col]).astype(int)
    
    if action == 'r2':
        if verbose:
            print(f"r2 Actual: {actual_col} Predict: {predict_col}")

        #//*** Return r2 score
        return round(r2_score(input_df[actual_col],input_df[predict_col]),4)
    
    if action == 'rmse':
        if verbose:
            print(f"rmse Actual: {actual_col} Predict: {predict_col}")

        #//*** Return Root Mean Squared Error
        return round(sqrt(mean_squared_error(input_df[actual_col],input_df[predict_col])),4)
    
    if action == 'mae':
        if verbose:
            print(f"rmse Actual: {actual_col} Predict: {predict_col}")

        #//*** Return Mean Absolute Error
        return round(mean_absolute_error(input_df[actual_col],input_df[predict_col]),4)
    
    
    #//**************************************
    #//**************************************
    #//**************************************
    #//**** END action=='Accuracy'
    #//**************************************
    #//**************************************
    #//**************************************
    
#//**************************************
#//**************************************
#//*** END Calc Results
#//**************************************
#//**************************************

def build_model_actions(loop_df,model_cols,thresholds):

    #//*** Build Ideal Trade Actions at a variety of Thresholds.
    #//*** These will represent Perfect trades and will be the control group.
    for thresh in thresholds:
        #//*** Generate action columns based on .01 and .05 Thresholds
        col_name = f'action_{int(thresh*100)}'

        loop_df[col_name] = calc_results(loop_df,"action",actual='actual',predict='predict',threshold=thresh)

    #//*** Build buy/sell/hold actions for each model
    for col in model_cols:
        
        #//*** Build Bey/Sell/Hold Actions at each Threshold (for each Model)
        #//*** Calc_results (Action Model) generates actions based on actual values (post-close market), compares preditions, generates
        #//*** Buy/Sell/Hold action based on threshold.
        #//*** This is per model/ per threshold. There can be many model predictions per run
        for thresh in thresholds:
            loop_df[f'{col}_action_{int(thresh*100)}'] = calc_results(loop_df,"action",actual='actual',predict=col,threshold=thresh)
    
    return loop_df
#build_stocks('rkt','daily',[1]).tail(60)
#calc_pl(loop_df,'actual','action_stock','linear_stock',threshold,get_list=False)
