#install.packages("tidyverse")
#install.packages("ggplot2")
{
library(ggplot2)
library(tidyverse)


########################################################
### Process and clean the California COVID data set. ###
### Outboarded to a function to keep the code tidier ###
###################################################################################################
### Light Cleaning:
### - counties are converted to lower case
### - NA values are converted to 0. These are from low population counties early in the dataset ###
###################################################################################################
process_CA_covid_cases_data <- function(input_df){
  
  
  ca_confirmed_df <-input_df
  
  
  ### Convert Date to a Date object
  ca_confirmed_df$date <- as.Date(ca_confirmed_df$date,"%Y-%m-%d")
  
  
  ##########################################################################################
  ### Convert NA to 0
  ##########################################################################################
  ### Hospital Data Frame - ca_hospital_df
  ##########################################################################################
  for (colCount in 1:length(ca_confirmed_df ) ) {
    
    ### Skip County and Date Columns
    if (colCount == 1) { next}
    if (colCount == 6) { next}
    
    
    ### Looping through each column
    ### Unlist converts data_frame list to vector
    thisColumn <- unlist(ca_confirmed_df[colCount])
    
    ### Sapply returns a vector. The function returns 0 if NA, else returns existing value
    new_column <- sapply(thisColumn, function(x){
      if (is.na(x) ) {
        return(0)
      } else { return(x) }
    },simplify="array")
    
    
    ca_confirmed_df[colCount] <- new_column
    
    
    
  }#//END Each Column
  
  ##########################################################################################
  ### convert county to lower case
  ##########################################################################################
  ca_confirmed_df$county <- sapply(ca_confirmed_df$county, tolower,simplify="array")
  print(tail(ca_confirmed_df))
  return(data.frame( 
    date=ca_confirmed_df$date,
    county=ca_confirmed_df$county,
    daily_total_confirmed=ca_confirmed_df$totalcountconfirmed,
    new_confirmed=ca_confirmed_df$newcountconfirmed,
    daily_total_deaths=ca_confirmed_df$totalcountdeaths,
    new_deaths=ca_confirmed_df$newcountdeaths
  ) )
  
  
}#//END Process_CA_data

########################################################################
### Process and clean the California COVID Hospitalization data set. ###
### Outboarded to a function to keep the code tidier                 ###
###################################################################################################
### Light Cleaning:
### - date column converted to as.Date
### - counties are converted to lower case
### - NA values are converted to 0. These are from low population counties early in the dataset ###
### Dervied Values:
### - Combined suspected COVID and confirmed COVID Hospitalizations
### - Combined suspected COVID and confirmed COVID ICU
### - Built projected capacity fields for Hospitalization and ICU. This is available beds 
###   minus the people in beds. This is likely not a good metric, since bed capacities appear to be
###   over-reported and include beds that are not suitable for treating COVID patients.
###   Keeping the processing here, but stripping the columns from the dataset later.
###   That leaves a more obvious reminder that the data is there, just tucked aside
###################################################################################################
process_CA_hospital_data <- function(input_df){
  
  ca_hospital_df <- input_df
  
  ca_hospital_df$todays_date <- as.Date(ca_hospital_df$todays_date,"%Y-%m-%d")
  
  ### Get Date Column name
  dateCol <- colnames(ca_hospital_df[2])
  dateCol
  
  ### Get county Column name
  countyCol <- colnames(ca_hospital_df[1])
  countyCol
  
  hospitalCol <-colnames(ca_hospital_df)
  
  ##########################################################################################
  ### Convert NA to 0
  ##########################################################################################
  ### Hospital Data Frame - ca_hospital_df
  ##########################################################################################
  for (colCount in 1:length(ca_hospital_df ) ) {
    
    ### Skip County and Date Columns
    if (colCount < 3) { next}
    
    ### Looping through each column
    ### Unlist converts data_frame list to vector
    thisColumn <- unlist(ca_hospital_df[colCount])
    
    ### Sapply returns a vector. The function returns 0 if NA, else returns existing value
    new_column <- sapply(thisColumn, function(x){
      if (is.na(x) ) {
        return(0)
      } else { return(x) }
    },simplify="array")
    
    ca_hospital_df[colCount] <- new_column
    
    
    
  }#//END Each Column
  
  ##########################################################################################
  ### convert county to lower case
  ##########################################################################################
  ca_hospital_df$county <- sapply(ca_hospital_df$county, tolower,simplify="array")
  
  
  ##########################################################################################
  ### Build combined tables
  ##########################################################################################
  ### Hospital Data Frame - ca_hospital_df
  ##########################################################################################
  
  ### combine icu_confirmed with icu_suspected
  ### Get the daily confirmed totals
  ca_hospital_df <- sum_and_remove_DF_Columns(ca_hospital_df,"icu_suspected_covid_patients","icu_covid_confirmed_patients","icu_combined")
  #ca_hospital_df <- sum_and_remove_DF_Columns(ca_hospital_df,"previous_days_covid_confirmed_patients","previous_days_suspected_covid_patients","confirmed_combined")
  
  ### remove hospitalized confirmed and suspected cases since these are already summarized
  ca_hospital_df <- removeCols(ca_hospital_df,c("hospitalized_covid_confirmed_patients","hospitalized_suspected_covid_patients"))
  
  ### rename date column to date
  names <- colnames(ca_hospital_df)
  names[2] <- "date"
  colnames(ca_hospital_df) <- names
  head(ca_hospital_df)
  
  ####Calculations - leave these in and strip out later since we are building from these values
  #### Let's strip out capacity since it is generating negative values.
  #### I suspect the available bed value and icu available, are not good values to use, since they don't represent staffing
  #### and include beds that are incompatible for COVID patients including NICU and PICU specialized units.
  #### Notably, there are anecdotal news reports saying hospitals are at capacity, yet this is not found in the data
  #### We'll haveto go after impact differently
  icu_capacity <- ca_hospital_df$icu_available_beds - ca_hospital_df$icu_combined
  hospital_capacity <- ca_hospital_df$all_hospital_beds - ca_hospital_df$hospitalized_covid_patients 
  
  
  return(ca_hospital_df)
  
  
  
}#//*** END process_CA_hospital_data

###############################################################################
### Returns a data frame of offset columns
################################################################################################
### Each offset column is the target_col minus a number of days indicated in the range vector.
### The offset is used to model / correlate the current day's value with a value in the past
### This function allows any column to be offset, providing a lot of flexibility when 
### exmining th edata
################################################################################################
### target_col: is the column to build offsets from
### range vector: numeric vector indicating the range of days to offset
################################################################################################
build_offset_columns <- function(input_df,target_col,range_vector){
  
  #print("BEGIN: build_offset_columns")
  #print(input_df)
  #print(paste0("Target col: ",target_col))
  
  ### Unlist the Target column to get a vector. Otherwise we spin our wheels in a df
  process_col <- unlist(input_df[target_col])
  
  #### Build a series of columns that offset the values of the target_col by the range vector
  for (offset_count in 1:length(range_vector))
  {
    offset_value <- range_vector[offset_count]
    i <- 0
    offset_col <- sapply(process_col,function(x){
      i <<- i + 1
      ### Return nothing for first 21 days
      if (i <= offset_value) { return(0) }
      return(process_col[i-offset_value])
      
    },simplify="array")
    
    thisColName <- paste("offset_",offset_value,sep="")
    
    input_df <- cbind(input_df,offset_col)
    
    colnames(input_df)[length(colnames(input_df))] <- thisColName
    
    
  }### END each vector elements
  
  return(input_df)  
  
}### END build_minus_column

########################
### Original Models: ###
##################################################################################
### Useful for statewide data sets where county level numbers are unavailable. ###
### This is needed to model testing                                            ###
##################################################################################
build_rolling_cor_offset <- function(input_df,prediction_field,rolling_days){
  
  
  ### Find the best offset covariance over a period of rolling days
  output_vector <- c()  
  output_vector2 <- c()  
  mse_vector <- c()
  predicted_deaths <- c()  
  
  ### Loop through input data frame
  for (i in 1:nrow(input_df)){
    if (i <= rolling_days) {
      output_vector2 <- append(output_vector2,0) 
      mse_vector <- append(mse_vector,0)
      predicted_deaths <- append(predicted_deaths,0)
      next
    }
    
    
    temp_df <- input_df[(i - rolling_days):i,2:length(input_df)]
    
    least_residual <- -1
    least_offset <- ""
    most_cor <- -1
    most_cor_offset <- ""
    ### Build Residuals for each offset Column
    ### Loop through each offset column
    
    ### Build correlation vector from temp_df, removing the date column
    
    tempCor <- cor(removeCols(temp_df,c("date")))
    
    
    
    #print(tempCor)
    #tempCor <- removeCols(tempCor,c("daily_total_confirmed","daily_total_deaths"))
    
    ### Only process second Row, we only care are correlation with deaths
    tempCor <- tempCor[,2]
    
    naFound <- FALSE
    ### Check for NA in data
    for (q in 3:length(tempCor)){
      
      if (is.na(tempCor[q]) == TRUE) {
        naFound <- TRUE
        break
      }
      #print(paste0("Not enough Data: ",temp_df$date))
      
    }
    
    if (naFound == TRUE){
      #### Not enough data to generate a correlation
      #### Return 0 values
      output_vector2 <- append(output_vector2,0) 
      mse_vector <- append(mse_vector,0)
      predicted_deaths <- append(predicted_deaths,0)
      next
      
    }
    
    for (q in 3:length(tempCor)){
      
      
      ### Ignore values of 1, it's the same column
      if (tempCor[q] < 1) {
        
        ### Initialize most_cor first time through
        if (most_cor == -1 ){ 
          most_cor <- tempCor[q] 
          most_cor_offset <- colnames(temp_df)[q]
          next
        }
        
        ### Keep current value if it's the highest
        if (tempCor[q] > most_cor){
          most_cor <- tempCor[q] 
          most_cor_offset <- colnames(temp_df)[q]
        }
        
      }#//END Values Less than 1
      
    }#//END determine max correlation loop
    
    
    ## Build a linear model prediction based on suggested offset.
    ## calculate the error of the prediction
    #print(paste0("temp_lm <-  lm(",prediction_field," ~ ",most_cor_offset,", data=temp_df)"))
    #temp_lm <-  lm(daily_total_deaths ~ offset_14, data=temp_df)
    eval(parse(text=paste0("temp_lm <-  lm(",prediction_field," ~ ",most_cor_offset,", data=temp_df)")))
    #eval(parse(text=command))
    
    #print(summary(temp_lm))
    
    temp_predict_df <- data.frame( 
      daily_total_deaths = predict(temp_lm, newdata=temp_df), 
      daily_total_confirmed=temp_df[most_cor_offset])
    
    ### Calculate mean deaths for the period
    
    ### Get the last predicted death for model comparison
    last_predicted_death <- round(temp_predict_df$daily_total_deaths[nrow(temp_predict_df)],0)
    
    predicted_deaths <- append(predicted_deaths,last_predicted_death)
    #### Get residuals from prediction
    temp_residual <- temp_df$daily_total_deaths - temp_predict_df$daily_total_deaths
    
    ### Base Error
    temp_residual <- sum(temp_residual^2)
    
    
    sse <- temp_df$daily_total_deaths - temp_predict_df$daily_total_deaths
    sse <- sse^2
    sse <- sum(sse)
    sse
    
    
    ## Degrees of Freedom for Error (n-p)
    dfe <- rolling_days-2
    
    #print(sse/dfe)
    
    
    ## Mean of Squares for Error:   MSE = SSE / DFE
    mse <- sse / dfe
    
    #print(temp_residual)
    #print(actual_values)
    
    #print(temp_residual / dfe)
    #daily_total_deaths
    
    ### Generate Average deaths for the month
    output_vector2 <- append(output_vector2,most_cor_offset) 
    mse_vector <- append(mse_vector,mse)
    
    
  }### END Each data frame row
  
  
  
  min_mse <- min(mse_vector[(mse_vector > 0)])
  
  offset_error <- c()
  
  for (i in 1:length(mse_vector)) {
    if (mse_vector[i] == 0 ){
      offset_error <- append(offset_error,0)
      next
    }
    offset_error <- append(offset_error,min_mse/mse_vector[i])
    
  }
  
  offset_indexes <- vapply(output_vector2, function(x){
    if (x==0) {return(0)}
    return(as.numeric(gsub("offset_","",x)))
  },numeric(1) )  
  
  #predict_death=mean_predicted_deaths
  return(data.frame(date = input_df$date,mse=mse_vector,error=offset_error,offset=output_vector2,predicted_deaths=predicted_deaths,offset_index=offset_indexes))
  #eval(parse(text=command))
  
  
}### END build rolling offset
build_rolling_lm_offset <- function(input_df,prediction_field,rolling_days){
  print("PROCESSING: build_rolling_lm_offset")
  
  input_column_offset <- 3
  
  ### Find the best offset covariance over a period of rolling days
  output_vector <- c()  
  output_vector2 <- c()  
  mse_vector <- c()
  predicted_deaths <- c()  
  lm_coefficient <- c()
  lm_intercept <- c()
  
  ### Loop through input data frame
  for (i in 1:nrow(input_df)){
    
    ### Skip rows that are less than rolling days. Sorry it can't be helped
    if (i <= rolling_days) {
      output_vector2 <- append(output_vector2,0) 
      mse_vector <- append(mse_vector,0)
      predicted_deaths <- append(predicted_deaths,0)
      lm_coefficient <- append(lm_coefficient,0)
      lm_intercept <- append(lm_intercept,0)
      next
    }
    
    #print(paste0("Processing Row: ",i," of ",nrow(input_df)))
    
    #### Build a temprory data frame, using current row index - minus the rolling days
    temp_df <- input_df[(i - rolling_days):i,]
    
    #### Remove Date and County from temp_df
    temp_df <- removeCols(temp_df,c("date","county"))
    
    
    least_residual <- -1
    least_offset <- "offset_0"
    least_lm <- ""
    least_predict_df <- ""
    

    ### Build Residuals for each offset Column
    ### Loop through each offset column
    for (lmCount in input_column_offset:length(temp_df)){
      
      ### Build a linear model for each offset
      ### Choose the model with the lowest error


      ### Get Each offset column name for Linear model
      loopColName <- colnames(temp_df)[lmCount]

      #print((parse(text=paste0("temp_lm <-  lm(",prediction_field," ~ ",loopColName,", data=temp_df)"))))
      
      ### dynamically build Linear Model
      eval(parse(text=paste0("temp_lm <-  lm(",prediction_field," ~ ",loopColName,", data=temp_df)")))
      
      #print(temp_lm)
      
      temp_predict_df <- data.frame( 
        daily_total_deaths = predict(temp_lm, newdata=temp_df), 
        daily_total_confirmed=temp_df[loopColName])
      
      temp_residual <- temp_df$daily_total_deaths - temp_predict_df$daily_total_deaths
      
      ### Base Error
      temp_residual <- sum(temp_residual^2)
      
      ### Initialze residual and offset values
      if (least_residual == -1) {
        
        least_residual <- temp_residual
        least_offset <- loopColName
        least_lm <- temp_lm
        least_predict_df <- temp_predict_df
        
      }#//END Initialize Least Residuals
      
      ### Assign the least residual
      if (temp_residual < least_residual){
        
        least_residual <- temp_residual
        least_offset <- loopColName
        least_lm <- temp_lm
        least_predict_df <- temp_predict_df
        
        
        
      }#//END assign least Residual
      
      
      #[temp_df[lmCount]]
      
    }#//*** END each column Name

    
    ### Get the last predicted death for model comparison
    last_predicted_death <- round(least_predict_df$daily_total_deaths[nrow(least_predict_df)],0)
    
    predicted_deaths <- append(predicted_deaths,last_predicted_death)
    #### Get residuals from prediction
    
    
    sse <- temp_df$daily_total_deaths - least_predict_df$daily_total_deaths
    sse <- sse^2
    sse <- sum(sse)
    sse
    
    
    ## Degrees of Freedom for Error (n-p)
    dfe <- rolling_days-2
    
    #print(sse/dfe)
    
    
    ## Mean of Squares for Error:   MSE = SSE / DFE
    mse <- sse / dfe
    

    output_vector2 <- append(output_vector2,least_offset) 
    mse_vector <- append(mse_vector,mse)
    
    lm_intercept <- append(lm_intercept, least_lm$coefficients[1])
    lm_coefficient <- append(lm_coefficient, least_lm$coefficients[2])
    
    
    #mean_predicted_deaths <- append(mean_predicted_deaths, mean(temp_predict_df$daily_total_confirmed))
    
    
    
  }### END Each data frame row
  
  
  


  offset_indexes <- vapply(output_vector2, function(x){
    if (x==0) {return(0)}
    return(as.numeric(gsub("offset_","",x)))
  },numeric(1) )  
  
  #print(input_df)
  #print(length(input_df$date))
  #print(length(mse_vector))
  #print(length(offset_error))
  #print(length(output_vector2))
  #print(length(predicted_deaths))
  #print(length())
  #print(length())
  #print(length())
  #print(length())
  #print(length())
  #print(length())
  print("Done: Rolling OFfset")
  return(data.frame(date = input_df$date,mse=mse_vector,offset=output_vector2,predicted_deaths=predicted_deaths,lm_intercept=lm_intercept,lm_coefficient=lm_coefficient,actual_deaths=input_df$daily_total_deaths,offset_index=offset_indexes))
  #eval(parse(text=command))

  
  
}### END build rolling offset

#########################
### Utility Functions ###
#########################
### Remove Columns from a data frame
removeCols <- function(data_df,col_vector){
  ### col_vector is a vector of column names to remove
  data_df <- data_df[, ! names(data_df) %in% col_vector, drop = F]
  
  return(data_df)
}
##################################################################################
### Combines columns by adding them together and removing the original columns ###
### Used for combining columns when cleaning the source data                   ###
##################################################################################
sum_and_remove_DF_Columns <- function(data_df,col1,col2,sumColName){
  ### Adds the row values of column1 and column. The new values are stored in sumColName
  ### SumColName added to data_df, col1 and col2 are removed.
  ### Effectively two columns are summed and replaced with a column of the summed value
  ### This is mostly used for combining suspected and confirmed cases
  
  i <- 0
  
  temp_col <- sapply(data_df[col1], function(x) {
    ### Increment the outer counter
    i <<- i + 1
    
    return(data_df[col1][i] + data_df[col2][i])
    
    
  },simplify = "array")
  #print(temp_col)
  #length(temp_col)
  ### remove old columns
  remove_columns = c(col1,col2)
  data_df <- data_df[, ! names(data_df) %in% remove_columns, drop = F]
  
  data_df[sumColName] <- temp_col
  
  return(data_df)
  
  
}


###################################################################################
### Build Aggregate Statewide numbers 
### This combines county wide numbers per date into an aggregate value by day.
### Needed to get actual statewide confirmed, death and hospitalization values
###################################################################################

build_statewide_confirmed_numbers <- function(input_df){
  #### Sum the numbers across the state to build a big picture estimate
  
  ### Build unique dates
  date <- unique(input_df$date)
  
  ### build statewide confirmed numbers
  daily_total_confirmed <- sapply(date,function(x){
    ### Build data frame for each date
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum confirmed for daily total
    return(sum(this_df$daily_total_confirmed) )
  },simplify="array")
  
  daily_total_deaths <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$daily_total_deaths) )
  },simplify="array")
  
  new_deaths <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$new_deaths) )
  },simplify="array")
  
  new_confimed <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$new_confirmed) )
  },simplify="array")
  
   
  
  return(data.frame(date,daily_total_confirmed,new_confimed,daily_total_deaths,new_deaths))
  
}#// END build statewide numbers
build_statewide_hospital_numbers <- function(input_df){
  #### Sum the numbers across the state to build a big picture estimate
  
  ### Build unique dates
  date <- unique(input_df$date)
  
  
  
  ### build statewide confirmed numbers
  hospitalized_covid_patients <- sapply(date,function(x){
    ### Build data frame for each date
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum confirmed for daily total
    return(sum(this_df$hospitalized_covid_patients) )
  },simplify="array")
  
  all_hospital_beds <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$all_hospital_beds) )
  },simplify="array")
  
  icu_available_beds <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$icu_available_beds) )
  },simplify="array")
  
  icu_combined <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$icu_combined) )
  },simplify="array")
  
  hospital_capacity <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$hospital_capacity) )
  },simplify="array")
  
  icu_capacity <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$icu_capacity) )
  },simplify="array")
  
  ### Stitch in actual deaths - 12 days
  return(data.frame(date=date,
                    daily_total_deaths = daily_covid_df$daily_total_deaths[12:nrow(daily_covid_df)],
                    hospitalized_covid_patients=hospitalized_covid_patients,
                    all_hospital_beds=all_hospital_beds,
                    icu_available_beds=icu_available_beds,
                    icu_combined=icu_combined,
                    hospital_capacity=hospital_capacity,
                    icu_capacity=icu_capacity
  ))
  
}#// END build statewide numbers

############################
### Population Functions ###
###########################################
### Get the county population per 100k. ###
###############################################################################################
### Useful for get counties with large population disparities on a similar per capita scale ###
###############################################################################################

county_pop_100k <- function(input_county){
  ### get the county population divided by 100,000 thousand.
  
  return(ca_population_df$pop_100k[which(ca_population_df$county==input_county)] )
  
}#//*** END county_pop_100k

#### Statewide Preview Model
correlation_model_statewide_by_summed_county <- function(input_df,input_test_field, input_predict_field){
  
  ### Build a statewide model of an attribute by modeling each County and summing the results.
  ### This is a relatively quick model, good for preliminary investigation. 
  ### The Best model is a 15 day model using linear models. Correlation fails below 30. But it is fast.
  ### 
  
  county_names <- sort(unique(input_df$county))
  
  #### Loop through each county Name and Build an offset
  for (countyCounter in 1:length(county_names)) {
    ### init small counties, here so we dont accidentally overlook with incremental step throughs
    if (countyCounter == 1){
      too_small_to_calc_counties <- c()    
    }
    ### Get County Name for Loop
    loop_county_name <- county_names[countyCounter]
    print(paste0("BEGIN:",loop_county_name))
    ### get data frame with just the County data
    loop_county_df <- input_df[which(input_df$county==loop_county_name),]
    #print(tail(loop_county_df))
    
    ### Build offset columns for confirmed cases
    loop_county_offset_df <- build_offset_columns(loop_county_df,input_test_field,2:30)
    #print(tail(loop_county_offset_df))
    
    ### Build predictions for County: deaths ~ confirmed
    loop_county_cor_df <- build_rolling_cor_offset(loop_county_offset_df,input_predict_field,30)
    #print(tail(loop_county_cor_df))
    
    
    ### IF the sum(mse) is less than 2, Ignore those counties and append to the too small to calc list
    if (sum(loop_county_cor_df$mse) < 2) {
      too_small_to_calc_counties <- append(too_small_to_calc_counties,loop_county_name)
      next
    }
    
    #print(tail(loop_county_cor_df))
    print(paste0("Sum MSE: ",sum(loop_county_cor_df$mse)))
    
    ####################################
    #### Build summed data frame
    ####################################
    #### First time through initialize the data frame
    if (countyCounter == 1) {
      output_df <- data.frame(
        date=loop_county_cor_df$date,
        confirm_mse=loop_county_cor_df$mse,
        confirm_deaths=loop_county_cor_df$predicted_deaths
      )
      next
    }#//*** END initialize data frame
    
    ### Add in County data to cor_model_statewide_by_county_30_df
    print(loop_county_name)
    
    ### Sum the county data and update the statewide output_df
    for (updateCounter in 1:nrow(loop_county_cor_df)){
      
      loop_master_row <- output_df[updateCounter,]
      loop_county_cor_row <- loop_county_cor_df[updateCounter,]
      
      #print(sum(loop_county_cor_row$mse))
      #print(sum(loop_county_cor_row$predicted_deaths))
      #### Sum Confirmed MSE
      loop_master_row$confirm_mse <- sum(loop_master_row$confirm_mse + loop_county_cor_row$mse)
      #### Sum Confirmed predicted deaths
      loop_master_row$confirm_deaths <- sum(loop_master_row$confirm_deaths + loop_county_cor_row$predicted_deaths)
      output_df[updateCounter,] <- loop_master_row
      #print(loop_master_row)
    }#//*** END Update State Model
    
    #print(tail(output_df))
    
  }###END each county same
  
  return(output_df)
  
  
}#// END Build a state wide model by summed County using 30 correlation Model
####################################################
#### Expensive County Modeling
#### Models each County and writes to a file
####################################################
build_county_models_to_file <- function(input_df,folder_name,input_test_field, input_predict_field){
  
  
  ### Builds a model for each county and exports each county to a file
  
  ###############################################
  #### Create Folders if they don't exist
  ###############################################
  ### Models Folder
  dir.create(file.path(workingDir, "models"), showWarnings = FALSE)
  
  ### Create Specific Sub Folder
  dir.create(file.path(paste0(workingDir,"\\models"), folder_name), showWarnings = FALSE)
  
  folder_path <- paste0(workingDir,"\\models\\",folder_name)
  
  ### Initialize filename vector. This will help up retrieve the folder names later
  filename_v <- c()
  
  ### A few counties are too small to model, they need to be skipped
  ### This list tracks modeled counties
  county_filenames <- c()
  
  ############################################
  ### Loop through input_df by county name
  ############################################
  
  county_names <- sort(unique(input_df$county))
  
  
  for (countyCounter in 1:length(county_names)) {
    ### init small counties, here so we dont accidentally overlook with incremental step throughs
    if (countyCounter == 1){
      too_small_to_calc_counties <- c()    
    }
    ### Get County Name for Loop
    loop_county_name <- county_names[countyCounter]
    print(paste0("[",countyCounter,"/",length(county_names),"] Processing:",loop_county_name))
    ### get data frame with just the County data
    loop_county_df <- input_df[which(input_df$county==loop_county_name),]
    #print(loop_county_df)
    
    ### Build the dependent variable
    eval(parse(text=paste0("dependent_variable <- input_df[which(input_df$county==loop_county_name),]$",input_test_field)))
    
    
    ### Build offset columns for confirmed cases
    loop_county_confirmed_df <- build_offset_columns(loop_county_df,input_test_field,2:30)
    #print(tail(loop_county_confirmed_df))
    ### Build predictions for County: deaths ~ confirmed
    loop_county_death_by_confirmed_df <- build_rolling_lm_offset(loop_county_confirmed_df,input_predict_field,15)
    
    
    ### IF the sum(mse) is less than 2, Ignore those counties and append to the too small to calc list
    if (sum(loop_county_death_by_confirmed_df$mse) < 2) {
      too_small_to_calc_counties <- append(too_small_to_calc_counties,loop_county_name)
      next
    }
    
    #print(tail(loop_county_death_by_confirmed_df))
    print(paste0("Sum MSE: ",sum(loop_county_death_by_confirmed_df$mse)))
    
    ####################################
    #### Build summed data frame
    ####################################
    #### First time through initialize the data frame
    ### lm_coefficient & offset_index need to be weighted by percentage of county population
    
    ### Get County Population
    #loop_pop_weight <- ca_population_df[which(ca_population_df$county==loop_county_name),]$population
    
    
    ### There are at least two invalid counties - Out of County and Unassigned. Set Weight to 0
    #if ( length(loop_pop_weight)  == 0)  {loop_pop_weight=0}
    
    
    ### Weight is a percentage of total population
    #loop_pop_weight <- loop_pop_weight / ca_pop
    
    
    #### These inlcude calculations for weighted counties
    #### We should not be weighted. Will do that at the state levels
    #output_df <- data.frame(
    #  date =loop_county_death_by_confirmed_df$date,
    #  predict_mse=loop_county_death_by_confirmed_df$mse,
    #  predict_deaths=loop_county_death_by_confirmed_df$predicted_deaths,
    #  predict_intercept =loop_county_death_by_confirmed_df$lm_intercept * loop_pop_weight,
    #  predict_coefficient = (loop_county_death_by_confirmed_df$lm_coefficient * loop_pop_weight ), 
    #  predict_offset = (loop_county_death_by_confirmed_df$offset_index * loop_pop_weight)
    #)
    
    output_df <- data.frame(
      date =loop_county_death_by_confirmed_df$date,
      dependent=dependent_variable,
      predict_mse=loop_county_death_by_confirmed_df$mse,
      prediction=loop_county_death_by_confirmed_df$predicted_deaths,
      predict_intercept =loop_county_death_by_confirmed_df$lm_intercept,
      predict_coefficient = loop_county_death_by_confirmed_df$lm_coefficient, 
      predict_offset = loop_county_death_by_confirmed_df$offset_index
    )
    
    
    ### Write the data frame to disk
    
    ### Build Filename with full path
    write_filename <- paste0(folder_path,"\\",loop_county_name,".dat")
    print("full File Name: ")
    print(write_filename)
    saveRDS(output_df, write_filename)
    
    ### Append filename to the filelist for later summation
    filename_v <- append(filename_v,write_filename)
    
    ### Only Counties that have good data are tracked
    county_filenames <- append(county_filenames,loop_county_name)
    
    
  }#//*** END Each County
  
  #colnames(index_df) <- c("county","filenames")
  index_filename <- paste0(folder_path,"\\1_index.dat")
  #print("Index Filename")
  #print(index_filename)
  
  ### Build an index data frame containing all the files for easier access
  index_df <- data.frame(
    county = county_filenames,
    filenames = filename_v
  )
  
  #colnames(index_df) <- c("county","filenames")
  
  saveRDS(index_df, index_filename)
  
}#//*** END build_county_models_to_file
#build_county_models_to_file(ca_covid_df,"confirm_~_deaths","daily_total_confirmed","daily_total_deaths")

##############################################################
#### Build statewide models from expensive county models ####
#####################################################################################
#### Reads county models from a file and returns a data frame of aggregated info ####
#####################################################################################

#confirm_predict_death_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))

print("DONE: Build Functions")
} #//***END Code Chunk Build Functions!

##########################################
##########################################
##########################################
### END Functions ########################
##########################################
##########################################
##########################################

###################################################################################
### Assign the working Directory. I work on 3x PCs, hence three directory choices
###################################################################################
#workingDir <- "C:\\DSC\\covid"
workingDir <- "C:\\Users\\newcomb\\DSCProjects\\DSC\\covid"
#workingDir <- "L:\\stonk\\projects\\DSC\\DSC\\covid"

setwd(workingDir)

#########################################
### Import and process original data ###
##################################################################################
### Data is provided directly the from state of California Open Data Portal   ###
##################################################################################
### https://data.ca.gov/group/covid-19
##################################################################################
### File downloading managed with a separate python script: getSources.py
### Files are downloaded using: getFiles.bat
##################################################################################

{ #*//BEGIN - Code Chunk #1 - Initialization

  print("PROCESSING: Code Chunk #1")  
  
  ########################################################
  ### Build Covid Confirmed and Deaths                 ###
  ### Source Data is by county and date.               ###
  ########################################################
  ca_covid_df <- process_CA_covid_cases_data(read.csv("CA_covid_Cases.csv"))
  
  ##############################
  ### Build Hospital Dataset ###
  ##############################
  ### Source Data is by county and date.
  ca_hospital_df <- process_CA_hospital_data(read.csv("CA_covid_Hospitalization.csv"))
  
  #############################
  ### Build Testing Dataset ###
  ###########################################
  ### import Testing info directly.       ###
  ### Cleaning: Convert date to as.Date() ###
  ### Data is at state level              ###
  ###########################################
  ca_testing_df <- read.csv("CA_testing.csv")
  ca_testing_df$date <- as.Date(ca_testing_df$date,"%Y-%m-%d")
  
  ### California Demographics - May use later
  #ca_demo_df <- read.csv("Final_CA_Race_Demographic.csv")
  
  ####################################################################
  #### Build Population Risk factors
  #### Mostly this is for the population data
  #### Might as well keep it and clean it
  ####################################################################
  ca_risk_factors_df <- read.csv("final_CA_county_population.csv")
  ca_risk_factors_df <- removeCols(ca_risk_factors_df,c('X'))
  
  
  #### Build County Population numbers
  ca_population_df <- data.frame(county = ca_risk_factors_df$county,
                                 population = ca_risk_factors_df$population,
                                 pop_100k = round(ca_risk_factors_df$population/100000,2)
                                 )
  
  ########################################################
  ### Statewide population
  ########################################################
  ca_pop <- sum(ca_population_df$population)
  
  ### Statewide population, per 100,000
  ca_pop_100k <- round(ca_pop / 100000,2)
  
  
  
  ############################################################
  ### build statewide Numbers - daily_covid_df
  ############################################################
  daily_covid_df <- build_statewide_confirmed_numbers(ca_covid_df)
  
  
  ####################################################
  ### Process ca_covid_df again
  ### Rename columns and remove new count numbers
  ### Should be handled in initial processing, 
  ### But that creates a significant refactor
  ### Will bolt on and move on
  ####################################################
  #ca_covid_df <- removeCols(ca_covid_df,c("newcountconfirmed","newcountdeaths"))
  #colnames(ca_covid_df) <- c("county","daily_total_confirmed","daily_total_deaths","date")
  
  ############################################
  #### Build statewide Hospital numbers
  ############################################
  ### Hospital has least least rows start there
  daily_hospital_df <- build_statewide_hospital_numbers(ca_hospital_df)
  daily_hospital_df
  ### Remove bed count for simiplication. May use this later
  ca_hospital_df <- removeCols(ca_hospital_df,c("all_hospital_beds","icu_available_beds"))
  daily_hospital_df <- removeCols(daily_hospital_df,c("all_hospital_beds","icu_available_beds","hospital_capacity","icu_capacity"))
  daily_hospital_df
  
  ### Add Deaths to ca_hospital_df
  ### Combine ca_covid and ca_hospital
  ca_combined_df <- merge(ca_covid_df,ca_hospital_df)
  ca_combined_df
  ### Add Statewide deaths to testing for offset building
  ca_testing_df <- data.frame(date=ca_testing_df$date,daily_total_deaths=daily_covid_df$daily_total_deaths,tested=ca_testing_df$tested)
  
  tail(ca_combined_df)
  #colnames(ca_covid_df)
  #colnames(ca_combined_df) <- c()
  ############################################################
  ### build State confirmed offset columns - 
  ### These are the columns to build days back offsets.
  ############################################################
  ############################################################
  ### Build the offsets data frame. 
  ############################################################
  
  
  
  offset_daily_df <- build_offset_columns(daily_covid_df,"daily_total_confirmed",2:30)
  
  offset_testing_df <- build_offset_columns(ca_testing_df,"tested",2:30)
  
  #offset_hospitalization <-build_offset_columns(daily_hospital_df,"daily_total_confirmed",2:30)
  
  #offset_daily_df
  print("END: Code Chunk #1")  
}#*//END - Code Chunk #1 - Initialization

############################################################################################################
############################################################################################################
############################################################################################################
#### BEGIN PREVIEW Modeling
############################################################################################################
############################################################################################################
############################################################################################################

############################################################################################################
### Rolling offset calculates the offset for each day looking back over a number of days.
### The current value is 15, but generates warnings. Should use 30 days for better maths, but the longer
### interval is less accurate
############################################################################################################


##### Build prediction model from correlation, but for each county. Sum the county deaths
#offset_df <- build_rolling_cor_offset(offset_daily_df,"daily_total_deaths",30)

### Testing to deaths model is very noisy. Olny have State
#offset_testing_lm15_df <- build_rolling_lm_offset(offset_testing_df,"daily_total_deaths",15)
#sum(offset_testing_lm15_df$mse)

#sum(offset_testing_lm15_df$mse)
#cor_model_confirmed_statewide <- correlation_model_statewide_by_summed_county(ca_covid_df,"daily_total_confirmed","daily_total_deaths")
#cor_model_confirmed_to_hospital_statewide <- correlation_model_statewide_by_summed_county(ca_combined_df,"daily_total_confirmed","hospitalized_covid_patients")
#cor_model_confirmed_to_hospital_statewide$confirm_deaths
#daily_hospital_df$hospitalized_covid_patients 
#sum(cor_model_confirmed_to_hospital_statewide$confirm_mse)

#ca_hospital_df

#sum(cor_model_statewide$confirm_mse)

#cor_model_hospital_statewide <- correlation_model_statewide_by_summed_county(ca_combined_df,"hospitalized_covid_patients","daily_total_deaths")

#sum(cor_model_hospital_statewide$confirm_mse)

#cor_model_hospital_icu_statewide <- correlation_model_statewide_by_summed_county(ca_combined_df,"icu_combined","daily_total_deaths")

#sum(cor_model_hospital_icu_statewide$confirm_mse)

#cor_model_hospital_icu_statewide

### Alternate statewide models - cor is probably best for investigation
### These are medium level models in terms of complexity
#offset_lm_7_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",7)
#offset_lm_15_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",15)
#offset_lm_30_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",30)

############################################################################################################
#### END PREVIEW Modeling
############################################################################################################


############################################################################################################
### Need to do something about uncounted counties,
### Save this for later
############################################################################################################

#for (x in 1:length(too_small_to_calc_counties)){
#  if (x==1){
    #### initialize population counter
#    too_small_population_count <- 0
#  }
#  loop_county <- too_small_to_calc_counties[x]
#  value <- ca_population_df$population[which(ca_population_df$county==loop_county)]
#  too_small_population_count <- sum(too_small_population_count + ca_population_df$population[which(ca_population_df$county==loop_county)])
#}
#print(paste0(round(too_small_population_count / ca_pop,6)*100,"% Population Not Counted: ",too_small_population_count," out of ", ca_pop))



###################################################################################################
#### Build Expensive Models to the county level.                                                ###
#### Write data to folders                                                                      ###
#### So only to do this once per data set                                                       ###
#### If I was really cool, i'd build an update function so I don't have to remodel old data     ###
#### But i'm not that cool on this timeline                                                     ###
###################################################################################################

  #build_county_models_to_file(ca_combined_df,"confirm_~_deaths","daily_total_confirmed","daily_total_deaths")
  #build_county_models_to_file(ca_combined_df,"confirm_~_hospital","daily_total_confirmed","hospitalized_covid_patients")
  #build_county_models_to_file(ca_combined_df,"confirm_~_icu","daily_total_confirmed","icu_combined")
  #build_county_models_to_file(ca_combined_df,"confirm_~_newdeaths","daily_total_confirmed","new_deaths")
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_newdeaths","new_confirmed","new_deaths")
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_hospital","new_confirmed","hospitalized_covid_patients")
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_icu","new_confirmed","icu_combined")
  #build_county_models_to_file(ca_combined_df,"hospital_~_newdeaths","hospitalized_covid_patients","new_deaths")
  #build_county_models_to_file(ca_combined_df,"icu_~_newdeaths","icu_combined","new_deaths")
  #build_county_models_to_file(ca_combined_df,"hospital_~_icu","hospitalized_covid_patients","icu_combined")
  #build_county_models_to_file(ca_combined_df,"hospital_~_deaths","hospitalized_covid_patients","daily_total_deaths")
  #build_county_models_to_file(ca_combined_df,"icu_~_deaths","icu_combined","daily_total_deaths")
ca_combined_df


build_statewide_model_from_counties <- function(input_folder){
  
  #######################################
  ### Get the Index File
  ### Because we make it easy!
  #######################################
  file_index <- readRDS(paste0(input_folder,"\\1_index.dat"))
  
  
  colnames(file_index) <- c("county","filenames")
  
  total_pop_weight <- 0
  
  ############################################################
  #### Build filenames from the county names in file_index
  #### Turns out the folder paths only on the machine that 
  #### did the modeling....Ooops.
  ############################################################
  filenames <- paste0(input_folder,"\\",file_index$county,".dat")
  
  loop_coef <- c()
  
  for (county_filename_counter in 1:length(filenames)){
    
    county_filename <- filenames[ county_filename_counter]
    county_name <- file_index$county[ county_filename_counter]
    
    loop_county_df <- readRDS(county_filename)  

    #######################################################
    ### We shouldnt have NAs in our models but we do.
    ### These should be zeros in the model generation
    ### But that is a huge pain to fix.
    #######################################################
    ### Bolt on and move on 
    #######################################################
    loop_county_df[is.na(loop_county_df)] = 0
    
    print("------------------------")
    print(county_name)
    print("------------------------")
    print(tail(loop_county_df))
    
  
    
    if(county_filename_counter == 1){
      ### Initialize output variables
      
      output_dates <- loop_county_df$date
      
      #### Build a vector of 0 with length of the input_df
      #### We start with 0 and sum each field
      dataset_length <- nrow(loop_county_df)
      
      for (x in 1:length(dataset_length)){
        if (x == 1) { zero_vector <- c() }
        zero_vector <- append(zero_vector,0)
      }
      
      output_mse <- zero_vector
      output_dependent <- zero_vector
      output_deaths  <- zero_vector
      output_intercept  <- zero_vector
      output_coefficient  <- zero_vector
      output_offset <- zero_vector
    }#//*** END initialize output variables
    
    #############################################################################
    ### Build output values
    ### Each value is a vector based on days. Add the vector to the output totals
    ### to get the Statewide numbers
    #############################################################################
    
    ### Start with unweighted Values
    output_mse <- output_mse + loop_county_df$predict_mse
    output_deaths <- output_deaths + loop_county_df$prediction
    output_dependent <- output_dependent + loop_county_df$dependent
    
    
    ########################################################################################################
    #### Build Weights based on population percentage
    ########################################################################################################
    
    ### Get County Population
    loop_pop_weight <- ca_population_df[which(ca_population_df$county==county_name),]$population
    
    
    ### There are at least two invalid counties - Out of County and Unassigned. Set Weight to 0
    if ( length(loop_pop_weight)  == 0)  {loop_pop_weight=0}
    
    
    
    ### Weight is a percentage of total population
    loop_pop_weight <- loop_pop_weight / ca_pop
    #print("Pop weight")
    #print(loop_pop_weight)
    
    ########################################################################################################
    #### Build Weighted values - these values are multiplied by their percentage of the population
    ########################################################################################################
    
    
    #############################################################################
    ### Replace NA with 0. The Models should not be generating NA
    ### But it's likely from low population counties. Let's go with it ATM.
    #############################################################################
    #loop_county_df$predict_offset[is.na(loop_county_df$predict_offset)] <- 0
    #loop_county_df$predict_intercept[is.na(loop_county_df$predict_intercept)] <- 0
    #loop_county_df$predict_coefficient[is.na(loop_county_df$predict_coefficient)] <- 0
    
    
    output_intercept <- (output_intercept + (loop_county_df$predict_intercept * loop_pop_weight) )
    
    
    
    output_offset <-    (output_offset + (loop_county_df$predict_offset * loop_pop_weight) )
    
    
    output_coefficient <- (output_coefficient + (loop_county_df$predict_coefficient * loop_pop_weight) )
    
    
    
    thisCoef <- (loop_county_df$predict_coefficient * loop_pop_weight)
    loop_coef <- append(loop_coef,thisCoef[length(thisCoef)])
    #last_coef <- append(last_coef,loop_county_df$predict_coefficient[length(loop_county_df$predict_coefficient)])
  }#//*** END Each county filename
  
  ### Truncate the offset - might be useful to keep later
  ### output_offset <- round(output_offset,0)
  
  
  ### Insetad of pop weight...
  ### Let's try a remodel to get the coefficients
  
  target_offset <- round(output_offset,0)
  remainder_offset <- (output_offset - target_offset)
  
  #eval(parse(text=paste0("temp_lm <-  lm(",output_dependent," ~ ",paste0(target_offset),", data=",loop_county_df,")")))
  #print(temp_lm)
  #print(str(temp_lm))
  #print(temp_lm$coefficients)
  
    
  return(data.frame(
    prediction          = output_deaths,
    dependent           = output_dependent,
    predict_offset      = output_offset,
    predict_mse         = output_mse,
    predict_intercept   = output_intercept,
    predict_coefficient = output_coefficient
    
  ))
  
  
  
}#//END build_statewide_model_from_counties

confirm_predict_death_model_df<- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))
confirm_predict_death_model_df

ca_combined_df
daily
{ #//BEGIN Code Chunk #2: Build State Models and Death_frame
  print("Processing: Code Chunk#2")
  ##############################
  ### Build Statewide Models ###
  #############################################################################
  ### Aggregates expensive county models into statewide California numbers. ###
  #############################################################################
  
  ### Confirmed cases predicting outcomes
  confirm_predict_death_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))
  confirm_predict_hospital_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_hospital"))
  confirm_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_icu"))
  
  #### Hospitalization predict outcomes
  hospital_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_icu"))
  hospital_predict_deaths_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_deaths"))
  
  #### ICU predict death
  icu_predict_deaths_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\icu_~_deaths"))
  death_model_last_30
  ### Correlate offset with MSE. I wonder what else correlates with MSE
  cor(confirm_predict_death_model_df$predict_offset,confirm_predict_death_model_df$predict_mse)  
  
  ### Confirm Predicting New Deaths is a shit model. Error only increases
  #confirm_predict_newdeaths_model_df   <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_newdeaths"))
  
  newconfirm_predict_hospital_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_hospital"))
  newconfirm_predict_newsdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_newdeaths"))
  newconfirm_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_icu"))
  hospital_predict_newdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_newdeaths"))
  icu_predict_newdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\icu_~_newdeaths"))
  
  
  ### Testing to deaths model is very noisy. Can only build from aggregate state numbers have State
  ### Build testing Model from aggreagte state numbers
  testing_predict_deaths_df <- build_rolling_lm_offset(offset_testing_df,"daily_total_deaths",15)
  
  #########################################################
  ### Trim up testing to same Data length as other models
  #########################################################
  ### Yes, it's ugly but it runs with one command.
  ### Basically, it's start at the row difference to the nrows in data frame
  ###############################################################################
  
  testing_predict_deaths_df <- testing_predict_deaths_df[
    (nrow(testing_predict_deaths_df) - nrow(confirm_predict_death_model_df) + 1):
      nrow(testing_predict_deaths_df),]
  
  ######################################################################
  ######################################################################
  ######################################################################
  ### END Modeling #####################################################
  ######################################################################
  ######################################################################
  ######################################################################


  ##############################################################
  ### Build the death model.
  ### Death model combines actual data points with the models
  ####################################################################

  ####################################################################
  ### Death Model: Initialize with Testing and Confirmed/Deaths
  ####################################################################
  death_model_df <- merge(removeCols(ca_testing_df,"daily_total_deaths"),daily_covid_df)
  
  ###############################################
  ### Death Model: Add Actual Hospital Values
  ###############################################
  death_model_df <- merge(death_model_df,daily_hospital_df)
  
  #######################################
  ### Death Model: Add Testing ~ Deaths
  #######################################
  death_model_df$testing_death_mse         <- testing_predict_deaths_df$mse
  death_model_df$testing_death_predict     <- testing_predict_deaths_df$predicted_deaths
  death_model_df$testing_death_offset      <- testing_predict_deaths_df$offset_index
  death_model_df$testing_death_intercept   <- testing_predict_deaths_df$lm_intercept
  death_model_df$testing_death_coefficient <- testing_predict_deaths_df$lm_coefficient
  
  
  
  #######################################
  ### Death Model: Add Confirmed ~ Deaths
  #######################################
  death_model_df$confirm_death_mse         <- confirm_predict_death_model_df$predict_mse
  death_model_df$confirm_death_predict     <- confirm_predict_death_model_df$prediction
  death_model_df$confirm_death_offset      <- confirm_predict_death_model_df$predict_offset
  death_model_df$confirm_death_intercept   <- confirm_predict_death_model_df$predict_intercept
  death_model_df$confirm_death_coefficient <- confirm_predict_death_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add Confirm ~ Hospital
  #######################################
  death_model_df$confirm_hospital_mse         <- confirm_predict_hospital_model_df$predict_mse
  death_model_df$confirm_hospital_predict     <- confirm_predict_hospital_model_df$prediction
  death_model_df$confirm_hospital_offset      <- confirm_predict_hospital_model_df$predict_offset
  death_model_df$confirm_hospital_intercept   <- confirm_predict_hospital_model_df$predict_intercept
  death_model_df$confirm_hospital_coefficient <- confirm_predict_hospital_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add confirm ~ icu 
  #######################################
  death_model_df$confirm_icu_mse         <- confirm_predict_icu_model_df$predict_mse
  death_model_df$confirm_icu_predict     <- confirm_predict_icu_model_df$prediction
  death_model_df$confirm_icu_offset      <- confirm_predict_icu_model_df$predict_offset
  death_model_df$confirm_icu_intercept   <- confirm_predict_icu_model_df$predict_intercept
  death_model_df$confirm_icu_coefficient <- confirm_predict_icu_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add hospital ~ icu
  #######################################
  death_model_df$hospital_icu_mse         <- hospital_predict_icu_model_df$predict_mse
  death_model_df$hospital_icu_predict     <- hospital_predict_icu_model_df$prediction
  death_model_df$hospital_icu_offset      <- hospital_predict_icu_model_df$predict_offset
  death_model_df$hospital_icu_intercept   <- hospital_predict_icu_model_df$predict_intercept
  death_model_df$hospital_icu_coefficient <- hospital_predict_icu_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add hospital ~ death
  #######################################
  death_model_df$hospital_death_mse         <- hospital_predict_deaths_df$predict_mse
  death_model_df$hospital_death_predict     <- hospital_predict_deaths_df$prediction
  death_model_df$hospital_death_offset      <- hospital_predict_deaths_df$predict_offset
  death_model_df$hospital_death_intercept   <- hospital_predict_deaths_df$predict_intercept
  death_model_df$hospital_death_coefficient <- hospital_predict_deaths_df$predict_coefficient
  
  #######################################
  ### Death Model: Add icu ~ death
  #######################################
  death_model_df$icu_death_mse         <- icu_predict_deaths_df$predict_mse
  death_model_df$icu_death_prediction  <- icu_predict_deaths_df$prediction
  death_model_df$icu_death_offset      <- icu_predict_deaths_df$predict_offset
  death_model_df$icu_death_intercept   <- icu_predict_deaths_df$predict_intercept
  death_model_df$icu_death_coefficient <- icu_predict_deaths_df$predict_coefficient

  print("DONE: Code Chunk#2")
}#//END Code Chunk #2: Build State Models and Death_frame

  
  
####################################################################################
####################################################################################
####################################################################################
### BEGIN Death Model analysis #####################################################
####################################################################################
####################################################################################
####################################################################################


data.frame(actual_hospital=death_model_df$hospitalized_covid_patients, predict_hospital=newconfirm_predict_hospital_model_df$prediction)

### New Confirmed Cases Predicting Hospitalization has 21% error
1 / sum( ( (death_model_df$hospitalized_covid_patients - newconfirm_predict_hospital_model_df$prediction)^2 /  (death_model_df$hospitalized_covid_patients^2)) [-1:-23])

newconfirm_predict_icu_model_df

data.frame( new_confirmed=death_model_df$new_confimed, actual_icu=death_model_df$icu_combined,newconfirm_predict_icu=newconfirm_predict_icu_model_df$prediction,newconfirm_predict_icu_model_df$predict_offset,newconfirm_predict_icu_model_df$predict_coefficient )


1 / sum( ( (death_model_df$icu_combined - newconfirm_predict_icu_model_df$prediction)^2 /  (death_model_df$icu_combined^2)) [-1:-23])

tail( 
  data.frame(confirm=death_model_df$daily_total_confirmed, 
           coef=death_model_df$confirm_death_coefficient, 
           deaths=death_model_df$daily_total_deaths,
           predict=death_model_df$confirm_death_predict,
           tested=death_model_df$tested,
           coef_c=death_model_df$testing_death_coefficient,
           inter_c=death_model_df$testing_death_intercept,
           predict_c=death_model_df$testing_death_predict,
           offset_c=death_model_df$testing_death_offset
           )
)
sum(newconfirm_predict_hospital_model_df$predict_mse)

sum(icu_predict_newdeaths_model_df$predict_mse)

sum(confirm_predict_newdeaths_model_df$predict_mse)

confirm_predict_newdeaths_model_df
confirm_predict_death_model_df


tail(death_model_df)

str(death_model_df)

cor(death_model_df[-1])

### Testing correlation
sort(cor(death_model_df[-1])[,2], decreasing=TRUE)
### Confirmed Correlation
sort(cor(death_model_df[-1])[,3], decreasing=TRUE)
### Confirmed Death Offset Correlation
sort(cor(death_model_df[-1])[,13], decreasing=TRUE)
sum(death_model_df$testing_mse)
sum(death_model_df$confirm_mse)
sum(death_model_df$hospital_mse)
sum(death_model_df$icu_mse)

get_county_models <- function(county_name, input_folder_name) {
       filename <- paste0(workingDir,input_folder_name,"\\",county_name,".dat")
       return(readRDS(filename) )
}#//*** END county model

los_angeles_temp_model_df <- get_county_models("los angeles", "\\models\\confirm_~_deaths")
los_angeles_temp_model_df
#,"\\models\\confirm_~_hospital", "\\models\\confirm_~_icu", "\\models\\hospital_~_icu","\\models\\hospital_~_deaths", "\\models\\icu_~_deaths") )

ca_covid_df[which(ca_covid_df$county=="los angeles"),]

####################################################################################
####################################################################################
####################################################################################
### END Death Model analysis   #####################################################
####################################################################################
####################################################################################
####################################################################################



#### Plotting


### Data Prep

death_model_last_30_df <- death_model_df[ (nrow(death_model_df)-30) : nrow(death_model_df),]



ggplot(data = death_model_last_30_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_line(color='black'  ,data = death_model_last_30_df,      aes(y=daily_total_confirmed, x=testing_death_predict),size=1) +
  geom_line(color='red'  ,data = death_model_last_30_df,      aes(y=daily_total_confirmed, x=confirm_death_predict),size=1) +
  geom_line(color='orange'  ,data = death_model_last_30_df,      aes(y=daily_total_confirmed, x=hospital_death_predict),size=1) +
  geom_line(color='steelblue'  ,data = death_model_last_30_df,      aes(y=daily_total_confirmed, x=icu_death_prediction),size=1) +
  
  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California (last 30 days)",subtitle="Red: Confirmed predicts deaths\nPurple: Testing predicts deaths\nBlack: Confirmed Statewide, summed counties")  


ggplot() +
  geom_line(color='blue'       ,data = death_model_df, aes(y = new_deaths,   x = date))+
  geom_line(color='red'        ,data = death_model_df, aes(y = icu_combined, x = date),size=1) +
  geom_line(color='steelblue'  ,data = death_model_df, aes(y = hospitalized_covid_patients, x=date),size=1) +
  geom_line(color='black'  ,data = death_model_df, aes(y = daily_total_deaths, x=date),size=1) +
  labs( x="Case Count", y="Cases", title="Actual Cases in California",subtitle="Grey: Hospitalization\nRed: ICU\nBlue: new deaths\nBlack Total Deaths")  +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) 
  
ggplot(data = death_model_df, aes(y = daily_total_deaths, x = date)) + geom_point(color='blue') +
  geom_point(color='red'  ,      data = death_model_df,  aes(y=icu_combined, x=date),size=1) +
  geom_point(color='steelblue'  ,data = death_model_df,  aes(y=hospitalized_covid_patients, x=date),size=1) +
#labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California (last 30 days)",subtitle="Red: Confirmed predicts deaths\nPurple: Testing predicts deaths\nBlack: Confirmed Statewide, summed counties")  
scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) 

death_model_df$date <- as.Date(death_model_df$date,"%Y-%m-%d")


class(death_model_df$date)
############################################################################
#### Model Error rates as a function of California testing effectiveness
###########################################################################
ggplot() + 
  geom_line(data = death_model_df, aes(y = testing_death_mse, x = date), color='darkred') +
  geom_line(data = death_model_df, aes(y = confirm_death_mse, x = date), color='red') +
  geom_line(data = death_model_df, aes(y = hospital_death_mse, x = date), color='blue') +
  geom_line(data = death_model_df, aes(y = icu_death_mse, x = date), color='blue') +
  labs( x="Date", y="Model Error (MSE)", title="Statewide Model/Testing error rates", subtitle="Lower is Better")  


ggplot(data = death_model_df, aes(y = confirm_death_mse, x = date)) + geom_line(color='blue') +
  labs( x="Date", y="Model Error (MSE)", title="Statewide Model - Rolling 7 day Correlation/Testing error rates", subtitle="Lower is Better")  

ggplot(data = death_model_df, aes(y = hospital_death_predict, x = date)) + geom_line(color='blue') +
  labs( x="Date", y="Model Error (MSE)", title="Error: Hospitalization Predict Deaths ", subtitle="Lower is Better")  

ggplot(data = death_model_df, aes(y = icu_death_mse, x = date)) + geom_line(color='blue') +
  labs( x="Date", y="Model Error (MSE)", title="Error: Hospitalization Predict Deaths ", subtitle="Lower is Better")  


#### Predicted Deaths by Confirmed cases
death_model_last_row <- death_model_df[nrow(death_model_df),]
death_model_last_row

error_rate <- abs( (death_model_last_row$daily_total_deaths - death_model_last_row$confirm_predict) / death_model_last_row$daily_total_deaths ) / 2
error_rate

death_statement_confirmed_1 <- paste0("Based on today's California confirmed case count of: ",death_model_last_row$daily_total_confirmed )
death_statement_confirmed_2 <- paste0(" California is facing: ",
( round(
  (death_model_last_row$daily_total_confirmed * death_model_last_row$confirm_coefficient) + death_model_last_row$confirm_intercept
)) ," total deaths in ",
round(death_model_last_row$confirmed_offset,2)," days +/- < 1%" )

print(death_statement_confirmed_1)
print(death_statement_confirmed_2)

##############################################
### Plot Death Model over entire Data set
##############################################
ggplot(data = death_model_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue', size=1.5) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_line(color='red'   ,data = death_model_df, aes(y=daily_total_confirmed, x=confirm_predict), size=.75) +
  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California",subtitle="Red: Confirmed Cases predicting deaths")  


### 30 day death model based on daily covid with last offset from the model
rowCount <- nrow(daily_covid_df)
startIndex <- rowCount - 30

last_confirmed_offset_index <- death_model_df$confirmed_offset[rowCount]


### get offset column
offset_name <- paste0("offset_",as.character(last_confirmed_offset_index))
offset_name

#### Get the index value of the offset
offset_index <- match(offset_name,colnames(offset_daily_df))

### Get last 30 days from daily_covid_df
last_30_confirmed <- daily_covid_df[startIndex:rowCount,]

### Assign last 30 days of offset values from last entry in death_model
last_30_confirmed$offset_confirmed <- offset_daily_df[,offset_index][startIndex:rowCount]
last_30_confirmed$confirm_predict <- death_model_df$confirm_predict[startIndex:rowCount]

last_30_confirmed

#### Correlated Model. Will keep this for reference testing.
#### This is our preview Model.
#cor_model_statewide
#last_30_cor_statewide <- cor_model_statewide[startIndex:rowCount,]
#last_30_cor_statewide$daily_total_confirmed <- last_30_confirmed$daily_total_confirmed
#last_30_cor_statewide

ggplot(data = last_30_confirmed, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue', size=2) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_line(color='red'   ,data = last_30_confirmed, aes(y=daily_total_confirmed, x=confirm_predict), size=.75) +
  #geom_line(color='green'   ,data = last_30_cor_statewide, aes(y=daily_total_confirmed, x=confirm_deaths), size=.75) +
  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California (last 30 days)",subtitle=paste0("Red: Confirmed Cases predicting deaths\nCorrelated with cases ",last_confirmed_offset_index," day prior"))




### Build Linear model get the coefficients (hopefully)
last_30_confirmed_lm <-  lm(daily_total_deaths ~ offset_confirmed, data=last_30_confirmed)


### Get the offset length of the dataset
startIndex<- nrow(last_30_confirmed) - last_confirmed_offset_index
endIndex <- nrow(last_30_confirmed)

confirmed_futurecast_df <- data.frame(
    date=as.Date(last_30_confirmed$date) + last_confirmed_offset_index,
    future_deaths=last_30_confirmed_lm$coefficients[1] + (last_30_confirmed$daily_total_confirmed * last_30_confirmed_lm$coefficients[2])
)[startIndex:endIndex,]

confirmed_futurecast_df


last_confirmed_offset_index

c(1:last_confirmed_offset_index)

confirmed_futurecast_df$days_ahead <- c(1:(last_confirmed_offset_index + 1))
confirmed_futurecast_df

ggplot(data = confirmed_futurecast_df, aes(y = future_deaths, x = days_ahead)) + geom_point(color='blue') +
  #scale_x_continuous(data = confirmed_futurecast_df, labels = days_ahead) +
  #geom_line(color='red'   ,data = last_30_confirmed, aes(y=daily_total_confirmed, x=confirm_predict)) +
  labs( 
    y="California Predicted Covid Deaths", 
    x="Days Ahead", 
    title=paste0("Modeling deaths Future Deaths in California (next ",last_confirmed_offset_index," days)"),
    subtitle=paste0(confirmed_futurecast_df$date[1], ":  ", round(confirmed_futurecast_df$future_deaths[1],0)," to\n",confirmed_futurecast_df$date[last_confirmed_offset_index+1],": ",round(confirmed_futurecast_df$future_deaths[last_confirmed_offset_index+1],0))  
    ) 

ggplot(data = death_model_df, aes(y = confirm_mse, x = date)) + geom_line(color='blue') +
  #scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) 
  #geom_line(color='red'   ,data = death_model_df, aes(y=daily_total_confirmed, x=confirm_predict)) +
  labs( x="Date", y="Model Error", title="Measuring Testing effectiveness by modeling error",subtitle="Lower the error, the more effective testing")  



############################################################
### Build model for last 30 days
############################################################
### Get the offset for the last date
### Rolling 30 day Model
############################################################
last_offset <- offset_df$offset[nrow(offset_df)]
tested_last_offset <-offset_lm_15_df$offset[nrow(offset_lm_15_df)]


#### Determine the last 30 days index
rowCount <- nrow(offset_daily_df)
startIndex <- rowCount - 30

### get last 30 days of of offset_daily_ statewide
temp_df <- offset_daily_df[startIndex:rowCount,]
tested_temp_df <- offset_testing_df[startIndex:rowCount,]

last_month_df <- data.frame( date = temp_df$date,  
                             daily_total_confirmed = temp_df$daily_total_confirmed,
                             daily_total_deaths = temp_df$daily_total_deaths,
                             tested = tested_temp_df$tested,
                             "tested_offset" = temp_df[tested_last_offset],
                             "offset" = temp_df[last_offset])

colnames(last_month_df) <- c("date","daily_total_confirmed","daily_total_deaths","tested","tested_offset","offset")


confirmed_last_month_lm <-  lm(daily_total_deaths ~ offset, data=last_month_df)

tested_last_month_lm <-  lm(daily_total_deaths ~ tested_offset, data=last_month_df)

last_month_predict_df <- data.frame( 
                                      date=last_month_df$date,
                                     actual_deaths=last_month_df$daily_total_deaths,
                                     daily_total_deaths = predict(confirmed_last_month_lm, newdata=last_month_df), 
                                     tested_predict_deaths = predict(tested_last_month_lm, newdata=last_month_df), 
                                     daily_total_confirmed=last_month_df$daily_total_confirmed,
                                     cor_model_confirm_deaths=cor_model_statewide_by_county_30_df$confirm_deaths[startIndex:rowCount],
                                     lm_model_confirm_deaths=lm_model_statewide_by_county_15_df$confirm_deaths[startIndex:rowCount],
                                     offset=last_month_df$offset
                                    )


ggplot(data = last_month_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  #  geom_line(color='blue'  ,data = june_CD_base_predict_df,      aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  #geom_line(color='black'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  #geom_line(color='purple'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=tested_predict_deaths)) +
  #geom_line(color='purple'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=cor_model_confirm_deaths)) +
  geom_line(color='red'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=lm_model_confirm_deaths)) +
    labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California (last 30 days)",subtitle="Red: Confirmed predicts deaths\nPurple: Testing predicts deaths\nBlack: Confirmed Statewide, summed counties")  

last_month_predict_df$tested_predict_deaths
############################################################
### Rolling 7 day Model
############################################################
last_offset <- offset_lm_5_df$offset[nrow(offset_lm_7_df)]

#### Determine the last 30 days index
rowCount <- nrow(offset_daily_df)
startIndex <- rowCount - 30

### get last 30 days of of offset_daily_ statewide
temp_df <- offset_daily_df[startIndex:rowCount,]

last_month_df <- data.frame( date = temp_df$date,  
                             daily_total_confirmed = temp_df$daily_total_confirmed,
                             daily_total_deaths = temp_df$daily_total_deaths,
                             "offset" = temp_df[last_offset])

colnames(last_month_df) <- c("date","daily_total_confirmed","daily_total_deaths","offset")


last_month_lm <-  lm(daily_total_deaths ~ offset, data=last_month_df)



last_month_predict_df <- data.frame( 
  date=last_month_df$date,
  actual_deaths=last_month_df$daily_total_deaths,
  daily_total_deaths = predict(last_month_lm, newdata=last_month_df), 
  daily_total_confirmed=last_month_df$daily_total_confirmed,
  offset=last_month_df$offset
)

ggplot(data = last_month_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  #  geom_line(color='blue'  ,data = june_CD_base_predict_df,      aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  geom_line(color='red'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Statewide (last 30 days)",subtitle=paste0("Rolling 7 day model - Correlation Confirmed: ",last_offset," days") ) 

############################################################
### Rolling 15 day Model
############################################################
last_offset <- offset_lm_15_df$offset[nrow(offset_lm_15_df)]
last_offset

offset_lm_15_df


#### Determine the last 30 days index
rowCount <- nrow(offset_daily_df)
startIndex <- rowCount - 30

### get last 30 days of of offset_daily_ statewide
temp_df <- offset_daily_df[startIndex:rowCount,]

last_month_df <- data.frame( date = temp_df$date,  
                             daily_total_confirmed = temp_df$daily_total_confirmed,
                             daily_total_deaths = temp_df$daily_total_deaths,
                             "offset" = temp_df[last_offset])

colnames(last_month_df) <- c("date","daily_total_confirmed","daily_total_deaths","offset")


last_month_lm <-  lm(daily_total_deaths ~ offset, data=last_month_df)



last_month_predict_df <- data.frame( 
  date=last_month_df$date,
  actual_deaths=last_month_df$daily_total_deaths,
  daily_total_deaths = predict(last_month_lm, newdata=last_month_df), 
  daily_total_confirmed=last_month_df$daily_total_confirmed,
  offset=last_month_df$offset
)

ggplot(data = last_month_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  #  geom_line(color='blue'  ,data = june_CD_base_predict_df,      aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  geom_line(color='red'   ,data = last_month_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Statewide (last 30 days)",subtitle=paste0("Rolling 15 day model - Correlation Confirmed: ",last_offset," days") ) 

intercept <- last_month_lm$coefficients[1]
coefficients <- last_month_lm$coefficients[2]
intercept
coefficients

last_month_predict_df

#let's look at errors
last_month_residuals <- (sum(last_month_predict_df$actual_deaths)^2) - (sum(last_month_predict_df$daily_total_deaths^2))

error_rate <- 1- last_month_residuals / sum(last_month_predict_df$actual_deaths)^2
error_rate

last_row <- offset_daily_df[nrow(offset_daily_df),]


### Project ahead by offset

### Validate offset model

validate_offset_df <- offset_df

offset_daily_df <- cbind(validate_offset_df, daily_covid_df$daily_total_deaths)
offset_daily_df


last_row
last_offset


#########################################
### Get last offset worth of records
### For Future predictions
######################################

### Take offset value an conver to int
last_offset_index <- as.numeric(gsub("offset_","",last_offset))


startIndex <- nrow(daily_covid_df) - last_offset_index

futurecast_df <- daily_covid_df[startIndex:nrow(daily_covid_df),]

futurecast_df

last_month_predict_df

summary(last_month_lm)[4]

str(last_month_lm)
last_month_lm$offset

offset_df

#intercept <- last_month_lm$coefficients[1]
#coefficients <- last_month_lm$coefficients[2]
#intercept
#coefficients

#last_month_lm$coefficients

#last_offset_index


predict_col = (last_month_predict_df$daily_total_confirmed *coefficients) + intercept

predict_low = predict_col - (predict_col * (error_rate / 2))
predict_high = predict_col + (predict_col * (error_rate / 2))

data.frame(date=last_month_predict_df$date,
           death=last_month_predict_df$actual_deaths, 
           confirmed=last_month_predict_df$daily_total_confirmed,
           offset=last_month_predict_df$offset,
           future_date=as.Date(last_month_predict_df$date) + last_offset_index,
           predict_low=predict_low,
           predict= predict_col,
           predict_high=predict_high)


print(paste0("Confirmed Correlates"))





sum(lm_model_statewide_by_county_15_df$confirm_mse)
sum(cor_model_statewide_by_county_30_df$confirm_mse)


offset_lm_30_df
sum(offset_lm_30_df$mse)
sum(offset_df$mse)

max(offset_df$offset_index)
  
scale_value_7 <- max(offset_lm_7_df$offset_index)/max(offset_lm_7_df$mse)
scale_value_15 <- max(offset_lm_15_df$offset_index)/max(offset_lm_15_df$mse)
scale_value_30 <- max(offset_lm_30_df$offset_index)/max(offset_lm_30_df$mse)

ggplot(data = offset_lm_7_df, aes(y = offset_index, x = date)) + geom_line(color='blue') +
  geom_line(color='blue', aes(y= mse*scale_value_7, x=date)) +
  geom_line(color='red', data=offset_lm_15_df, aes(y = offset_index, x = date)) +
  geom_line(color='red', data=offset_lm_15_df, aes(y= mse*scale_value_15, x=date)) +
  geom_line(color='green', data=offset_lm_30_df, aes(y = offset_index, x = date)) +
  geom_line(color='green', data=offset_lm_30_df, aes(y= mse*scale_value_30, x=date)) +
  labs( x="Date", y="Days prior", title="Correlating confirmed cases with deaths", subtitle="Deaths correlated confirmed days prior")  
  

geom_line(color='red', aes(data=offset_lm_15_df, y= mse*scale_value_15, x=date)) +
  geom_line(color='red', aes(y= mse*scale_value_15, x=date)) +
  geom_line(color='purple', aes(y= mse*scale_value_30, x=date)) +

cor(offset_lm_7_df$offset_index,offset_lm_7_df$mse)  

length(offset_lm_7_df$offset_index)
length(offset_lm_7_df$mse)

cor(offset_lm_7_df$offset_index,offset_lm_7_df$mse)
cor(offset_lm_15_df$offset_index,offset_lm_15_df$mse)
cor(offset_lm_30_df$offset_index,offset_lm_30_df$mse)


ca_total_population / 100000

daily_covid_df$daily_total_deaths / (ca_total_population / 100000)
kern_population <- ca_population_df$population[which(ca_population_df$county=="kern")]

############################################################
### County Level Work
############################################################
kern_hospital_df <- ca_hospital_df[which(ca_hospital_df$county=="kern"),]
kern_confirmed_df <- ca_covid_df[which(ca_covid_df$county=="kern"),]
kern_confirmed_df$totalcountdeaths / county_pop_100k("kern")

#Min Beds
min(kern_hospital_df$all_hospital_beds[which(kern_hospital_df$all_hospital_beds > 0)] / county_pop_100k("kern"))

#Max Beds
max(kern_hospital_df$all_hospital_beds[which(kern_hospital_df$all_hospital_beds > 0)] / county_pop_100k("kern"))


kern_hospital_df






############################################################
### build Alameda confirmed offset columns - 
############################################################
#alameda_df <- buildCounties_df(ca_covid_df,c("alameda"))
#alameda_offset_daily_df <- build_offset_columns(alameda_df,"daily_total_confirmed",8:30)

#alameda_offset_daily_df

#alameda_last_30_df <- build_last_30_df(alameda_offset_daily_df)

#alameda_predict_df <- build_model_last_30days(alameda_last_30_df)
#alameda_predict_df
#df_for_plot <- alameda_last_30_df
#predict_df_for_plot <- alameda_predict_df

#ggplot(data = df_for_plot, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
#  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
#  geom_line(color='red'   ,data = predict_df_for_plot, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
#  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Alameda (last 30 days)")  


### Split counties into separate groups counties > 2% and less than
#counties_by_size_index <- order(ca_population_df$population,decreasing = TRUE)
#counties_biggest_index <- counties_by_size_index[1:12] 
#counties_smallest_index <-counties_by_size_index[13:length(counties_by_size_index)] 

### Get Names of Biggest counties by population
#counties_biggest_names <- sapply(counties_biggest_index, function(x){
#  return(ca_population_df$county[x])
#},simplify = "array")
#counties_biggest_names

### Get Names of Smallest counties by population
#counties_smallest_names <- sapply(counties_smallest_index, function(x){
#  return(ca_population_df$county[x])
#},simplify = "array")
#counties_smallest_names

##########################################
### These functions May be obsolete
##########################################

### Build Counties likely replaced with expensive models
buildCounties_df <- function(input_df,input_names){
  #### Build a data frame of counties listed in input_names. Multiple counties will be summed
  date <- unique(input_df$date)
  
  daily_total_confirmed <- sapply(date,function(x){
    ### Build data frame for each date
    this_df <- (input_df [which(input_df$date == x),])
    
    temp_array <- sapply(input_names, function(x){
      
      return(this_df[which(this_df$county ==x), ]$totalcountconfirmed)
    },simplify="array")
    
    ### Sum confirmed for daily total
    return(sum(temp_array))
  },simplify="array")
  
  daily_total_deaths <- sapply(date,function(x){
    ### Build data frame for each date
    this_df <- (input_df [which(input_df$date == x),])
    
    temp_array <- sapply(input_names, function(x){
      
      return(this_df[which(this_df$county ==x), ]$totalcountdeaths)
    },simplify="array")
    
    ### Sum confirmed for daily total
    return(sum(temp_array))
  },simplify="array")
  
  
  return(data.frame(date,daily_total_confirmed,daily_total_deaths))
  
}### END buildCounties
build_last_30_df <- function(input_df){
  ### Return the last 30 day of a DF
  #### Determine the last 30 days index
  rowCount <- nrow(input_df)
  startIndex <- rowCount - 30
  
  ### get last 30 days of of offset_daily_ statewide
  return(input_df[startIndex:rowCount,])
  
  
}#///END build_last_30_df
build_model_last_30days <- function(input_df) {
  ############################################################
  ### Build model for last 30 days
  ############################################################
  
  #### Determine the last 30 days index
  rowCount <- nrow(input_df)
  startIndex <- rowCount - 30
  
  ### get last 30 days of of offset_daily_ statewide
  temp_df <- input_df[startIndex:rowCount,]
  
  last_month_df <- data.frame( date = temp_df$date,  
                               daily_total_confirmed = temp_df$daily_total_confirmed,
                               daily_total_deaths = temp_df$daily_total_deaths,
                               "offset" = temp_df[last_offset])
  
  colnames(last_month_df) <- c("date","daily_total_confirmed","daily_total_deaths","offset")
  
  
  last_month_lm <-  lm(daily_total_deaths ~ offset, data=last_month_df)
  
  
  last_month_predict_df <- data.frame( 
    date=last_month_df$date,
    actual_deaths=last_month_df$daily_total_deaths,
    daily_total_deaths = predict(last_month_lm, newdata=last_month_df), 
    daily_total_confirmed=last_month_df$daily_total_confirmed,
    offset=last_month_df$offset
  )
  
  
  return(last_month_predict_df)
  
}#//END build_model_last_30days

### Plotting combined graphs with tidyverse
#https://www.datanovia.com/en/blog/how-to-create-a-ggplot-with-multiple-lines/
#plot_df <- death_model_df %>%
#  select(date, daily_total_confirmed, daily_total_deaths, 
#         confirm_death_predict, 
#        testing_death_predict,
#         hospital_death_predict,
#         icu_death_prediction
#         ) %>%
#  gather(key = "variable", value = "value", c(
#    confirm_death_predict, 
#    testing_death_predict,
#    hospital_death_predict,
#    icu_death_prediction,
#    -date, -daily_total_deaths, -daily_total_confirmed,
#  ) )

#plot_df_last_30 <- death_model_last_30 %>%
#  select(date, daily_total_confirmed, daily_total_deaths, 
#         confirm_death_predict, 
#         testing_death_predict,
#         hospital_death_predict,
#         icu_death_prediction
#  ) %>%
#  gather(key = "variable", value = "value", c(
#    confirm_death_predict, 
#    testing_death_predict,
#    hospital_death_predict,
#    icu_death_prediction,
#    -date, -daily_total_deaths, -daily_total_confirmed,
#  ) )

#ggplot(data = plot_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue', size=1) +
#  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
#  geom_line(data = plot_df, aes(color = variable, linetype = variable),size=.75) + 
#  scale_color_manual(values = c("darkred", "steelblue","purple","darkgreen")) +
#  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California ",subtitle=paste0("Red: Confirmed Cases predicting deaths"))

#ggplot(data = plot_df_last_30, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue', size=1) +
#  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
#  geom_line(data = plot_df_last_30, aes(color = variable, linetype = variable),size=.75) + 
#  scale_color_manual(values = c("darkred", "steelblue","purple","darkgreen")) +
#  labs( x="Total Covid Deaths", y="Total Confirmed Cases", title="Modeling deaths in California ",subtitle=paste0("Red: Confirmed Cases predicting deaths"))

