#install.packages("tidyverse")
#install.packages("ggplot2")
# Load
library(ggplot2)


{ #//Code Chunk 1: Load Functions
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
build_county_models_to_file <- function(input_df,folder_name,input_test_field, input_predict_field,rolling_days){
  
  
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
    loop_county_death_by_confirmed_df <- build_rolling_lm_offset(loop_county_confirmed_df,input_predict_field,rolling_days)
    
    
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
    
    #print("------------------------")
    #print(county_name)
    #print("------------------------")
    #print(tail(loop_county_df))
    
    
    
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
      total_offset <- zero_vector
      total_coefficient <- zero_vector
      total_intercept <- zero_vector
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
    
    total_offset <- total_offset + loop_county_df$predict_offset 
    total_intercept <- total_intercept + loop_county_df$predict_intercept
    total_coefficient <- total_coefficient + loop_county_df$predict_coefficient
    
    ########################################################################################################
    #### Build Weights based on population percentage
    ########################################################################################################
    
    ### Get County Population
    #loop_pop_weight <- ca_population_df[which(ca_population_df$county==county_name),]$population
    
    
    ### There are at least two invalid counties - Out of County and Unassigned. Set Weight to 0
    #if ( length(loop_pop_weight)  == 0)  {loop_pop_weight=0}
    
    
    
    ### Weight is a percentage of total population
    #loop_pop_weight <- loop_pop_weight / ca_pop
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
    
    
    #output_intercept <- (output_intercept + (loop_county_df$predict_intercept * loop_pop_weight) )
    
    
    #loop_county_df$predict_offset <- as.double(loop_county_df$predict_offset)
    #output_offset <-    (output_offset + (loop_county_df$predict_offset * loop_pop_weight) )
    
    #loop_county_df$predict_coefficient <- as.double(loop_county_df$predict_coefficient)
    
    #output_coefficient <- (output_coefficient + (loop_county_df$predict_coefficient * loop_pop_weight) )
    
    
    
  }#//*** END Each county filename
  total_weight <- 0
  total_predict <- zero_vector
  ### Build weighted values
  ### Need to go back through again
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
    
    #print("------------------------")
    #print(county_name)
    #print("------------------------")
    #print(tail(loop_county_df))
    
    #print(county_name)
    
    
    ########################################################################################################
    #### Build Weights based on percentage of total deathss
    ########################################################################################################
    
    ### Get County Population
    #loop_pop_weight <- ca_population_df[which(ca_population_df$county==county_name),]$population
    
    
    ### There are at least two invalid counties - Out of County and Unassigned. Set Weight to 0
    #if ( length(loop_pop_weight)  == 0)  {loop_pop_weight=0}
    
    
    
    ### Weight is a percentage of total population
    #loop_pop_weight <- loop_pop_weight / ca_pop
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
    #loop_county_df$predict_coefficient[i/2s.na(loop_county_df$predict_coefficient)] <- 0
    
    loop_death_weight <- loop_county_df$prediction/output_deaths
    
    loop_death_weight[is.na(loop_death_weight)] = 0
    #print(sum(loop_death_weight))
    
    loop_offset_weight <- loop_county_df$predict_offset/total_offset
    loop_offset_weight[is.na(loop_offset_weight)] = 0
    
    
    #print(loop_county_df)
    
    loop_intercept_weight <- loop_county_df$predict_intercept/total_intercept
    loop_intercept_weight[is.na(loop_intercept_weight)] = 0
    
    loop_coefficient_weight <- loop_county_df$predict_coefficient/total_coefficient
    loop_coefficient_weight[is.na(loop_coefficient_weight)] = 0
    
    
    output_offset <-    (output_offset + (loop_county_df$predict_offset * loop_death_weight) )
    #norm_offset <-      (total_offset - min(total_offset)) / ( max(total_offset) - min(total_offset) )
    #norm_offset <-       norm_offset * loop_death_weight
    #output_offset <- (   output_offset +  (loop_county_df$predict_offset * norm_offset) )
    
    
    output_intercept <- (output_intercept + (loop_county_df$predict_intercept * loop_death_weight) )
    #norm_intercept <- (total_intercept - min(total_intercept)) / ( max(total_intercept) - min(total_intercept) )
    #norm_intercept <- norm_intercept * loop_death_weight
    #output_intercept <- (output_intercept +  (loop_county_df$predict_intercept * norm_intercept) )
    
    output_coefficient <- (output_coefficient +  (loop_county_df$predict_coefficient * loop_death_weight) )
    
    #norm_coefficient <- (total_coefficient - min(total_coefficient)) / ( max(total_coefficient) - min(total_coefficient) )
    #norm_coefficient <- norm_coefficient * loop_death_weight
    #output_coefficient <- (output_coefficient +  (loop_county_df$predict_coefficient * norm_coefficient) )
    
    #print(loop_county_df$predict_coefficient)
    #print(loop_county_df$predict_coefficient * loop_death_weight)
    
    
    
    
    #print(tail(
    #  data.frame(
    #    total=output_deaths,
    #    county=loop_county_df$prediction,
    #    percent=loop_county_df$prediction/output_deaths,
    #    coef=loop_county_df$predict_coefficient,
    #    percent_coef=loop_county_df$predict_coefficient*(loop_county_df$prediction/output_deaths)
    #    )))
    
  }#//*** END Each county filename
  
  
  
  
  
  
  
  
  
  return(data.frame(
    prediction          = output_deaths,
    dependent           = output_dependent,
    predict_offset      = output_offset,
    predict_mse         = output_mse,
    predict_intercept   = output_intercept,
    predict_coefficient = output_coefficient
    
  ))
  
  
  
}#//END build_statewide_model_from_counties
rescale_mse <- function(mse,offset){
  
  ### Scales the MSE to the offset values
  max_offset <- max(offset)
  min_mse <- min(mse[which(mse > 0)])
  scaled_mse <-  (mse - min_mse )  / ( max(mse) - min_mse) *max_offset
  scaled_mse <- vapply(scaled_mse,function(x){
    if (x < 0){return(0)}
    return(x)
  },numeric(1))  
  
  return(scaled_mse)
}

#confirm_predict_death_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))

print("DONE: Build Functions")
} #//Code Chunk 1: Load Functions

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
#workingDir <- "C:\\Users\\newcomb\\DSCProjects\\DSC\\covid"
#workingDir <- "C:\\Users\\stonk013\\Documents\\GitHub\\DSC\\covid"
#workingDir <- "L:\\stonk\\projects\\DSC\\DSC\\covid"
#setwd(workingDir)

workingDir <- dirname(rstudioapi::getActiveDocumentContext()$path)
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

{ #*//BEGIN - Code Chunk #2 - Initialization

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
  
  ### Remove bed count for simiplication. May use this later
  ca_hospital_df <- removeCols(ca_hospital_df,c("all_hospital_beds","icu_available_beds"))
  daily_hospital_df <- removeCols(daily_hospital_df,c("all_hospital_beds","icu_available_beds","hospital_capacity","icu_capacity"))
  
  
  ### Add Deaths to ca_hospital_df
  ### Combine ca_covid and ca_hospital
  ca_combined_df <- merge(ca_covid_df,ca_hospital_df)
  ca_combined_df
  ### Add Statewide deaths to testing for offset building
  ca_testing_df <- data.frame(date=ca_testing_df$date,daily_total_deaths=daily_covid_df$daily_total_deaths,tested=ca_testing_df$tested)
  
  ### Combine Statewide totalsL Confirm Death and hospitalization numbers
  daily_combined_df <- merge(daily_covid_df,daily_hospital_df)
  
  #colnames(ca_covid_df)
  #colnames(ca_combined_df) <- c()
  ############################################################
  ### build State confirmed offset columns - 
  ### These are the columns to build days back offsets.
  ############################################################
  ############################################################
  ### Build the offsets data frame. 
  ############################################################
  
  
  offset_daily_df <- build_offset_columns(daily_combined_df,"daily_total_confirmed",2:30)
  
  offset_testing_df <- build_offset_columns(ca_testing_df,"tested",2:30)
  
  #offset_hospitalization <-build_offset_columns(daily_hospital_df,"daily_total_confirmed",2:30)
  
  #offset_daily_df
  print("END: Code Chunk #2")  
}#*//END - Code Chunk #2 - Initialization

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



##########################################################################################################
#### Build Expensive Models to the county level.                                                       ###
#### Write data to folders                                                                             ###
#### So only to do this once per data set                                                              ###
#### If I was really cool, i'd build an update function so I don't have to remodel old data            ###
#### But i'm not that cool on this timeline                                                            ###
#### Function Input Variables:                                                                         ###
#### Data Frame: The Data frame containing all the values to model                                     ###
#### String: folder name to contain the models                                                         ###
#### String: Dependent Variable Column Name                                                            ###
#### String: Independent Variable Name                                                                 ###
#### Integer: Number of prior days to model the dependent variables affect on the independent variable ###
##########################################################################################################
  
  #build_county_models_to_file(ca_combined_df,"confirm_~_deaths","daily_total_confirmed","daily_total_deaths",15)
  #build_county_models_to_file(ca_combined_df,"confirm_~_hospital","daily_total_confirmed","hospitalized_covid_patients",15)
  #build_county_models_to_file(ca_combined_df,"confirm_~_icu","daily_total_confirmed","icu_combined",15)
  #build_county_models_to_file(ca_combined_df,"confirm_~_newdeaths","daily_total_confirmed","new_deaths",15)
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_newdeaths","new_confirmed","new_deaths",15)
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_hospital","new_confirmed","hospitalized_covid_patients",15)
  #build_county_models_to_file(ca_combined_df,"newconfirm_~_icu","new_confirmed","icu_combined",15)
  #build_county_models_to_file(ca_combined_df,"hospital_~_newdeaths","hospitalized_covid_patients","new_deaths",15)
  #build_county_models_to_file(ca_combined_df,"icu_~_newdeaths","icu_combined","new_deaths",15)
  #build_county_models_to_file(ca_combined_df,"hospital_~_icu","hospitalized_covid_patients","icu_combined",15)
  #build_county_models_to_file(ca_combined_df,"hospital_~_deaths","hospitalized_covid_patients","daily_total_deaths",15)
  #build_county_models_to_file(ca_combined_df,"icu_~_deaths","icu_combined","daily_total_deaths",15)


#confirm_predict_death_model_df<- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))
#confirm_predict_death_model_df
#tail(offset_lm_15_df)

{ #//BEGIN Code Chunk #3: Build State Models and Death_frame
  print("Processing: Code Chunk#3")
  ##############################
  ### Build Statewide Models ###
  #############################################################################
  ### Aggregates expensive county models into statewide California numbers. ###
  #############################################################################
  ## Twice the error with 30 days
  #confirm_predict_death_30_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths_30"))
  
  ### Confirmed cases predicting outcomes
  confirm_predict_death_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_deaths"))
  confirm_predict_newdeath_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_newdeaths"))
    
  confirm_predict_hospital_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_hospital"))
  confirm_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_icu"))
  
  #### Hospitalization predict outcomes
  hospital_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_icu"))
  hospital_predict_deaths_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_deaths"))
  
  #### ICU predict death
  icu_predict_deaths_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\icu_~_deaths"))

    ### Correlate offset with MSE. I wonder what else correlates with MSE
  cor(confirm_predict_death_model_df$predict_offset,confirm_predict_death_model_df$predict_mse)  
  
  ### Confirm Predicting New Deaths is a shit model. Error only increases
  #confirm_predict_newdeaths_model_df   <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\confirm_~_newdeaths"))
  
  newconfirm_predict_newsdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_newdeaths"))
  newconfirm_predict_hospital_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_hospital"))
  newconfirm_predict_icu_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\newconfirm_~_icu"))
  
  hospital_predict_newdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\hospital_~_newdeaths"))
  icu_predict_newdeaths_model_df <- build_statewide_model_from_counties(paste0(workingDir,"\\models\\icu_~_newdeaths"))
  
  
  ### Testing to deaths model is very noisy. Can only build from aggregate state numbers have State
  ### Build testing Model from aggreagte state numbers
  testing_predict_deaths_df <- build_rolling_lm_offset(offset_testing_df,"daily_total_deaths",15)

  
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
  death_model_df <- merge(removeCols(ca_testing_df,"daily_total_deaths"),daily_combined_df)
  
  
  #######################################
  ### Death Model: Add Testing ~ Deaths
  #######################################
  ### Move Testing into spearate data frame to merge with death model. Testing has a different number of row.
  ### merge() will correct this magically. The Date column is important, it is a reference column to knit the frames together
  temp_testing_model <- data.frame(
    date=ca_testing_df$date,
    testing_death_mse=testing_predict_deaths_df$mse,
    testing_death_predict=testing_predict_deaths_df$predicted_deaths,
    testing_death_offset=testing_predict_deaths_df$offset_index
  )
  
  
  death_model_df <- merge(death_model_df, temp_testing_model)

  
  #######################################
  ### Death Model: Add Confirmed ~ Deaths
  #######################################
  death_model_df$confirm_death_mse         <- confirm_predict_death_model_df$predict_mse
  death_model_df$confirm_death_mse_rescale <- rescale_mse(confirm_predict_death_model_df$predict_mse,confirm_predict_death_model_df$predict_offset)
  death_model_df$confirm_death_predict     <- confirm_predict_death_model_df$prediction
  death_model_df$confirm_death_offset      <- confirm_predict_death_model_df$predict_offset
  
#  death_model_df$confirm_death_intercept   <- confirm_predict_death_model_df$predict_intercept
#  death_model_df$confirm_death_coefficient <- confirm_predict_death_model_df$predict_coefficient
  death_model_df$confirm_newdeath_mse      <- confirm_predict_newdeath_model_df$predict_mse
  death_model_df$confirm_newdeath_predict  <- confirm_predict_newdeath_model_df$prediction
  death_model_df$confirm_newdeath_offset   <- confirm_predict_newdeath_model_df$predict_offset
  
  
  #######################################
  ### Death Model: Add Confirm ~ Hospital
  #######################################
  death_model_df$confirm_hospital_mse         <- confirm_predict_hospital_model_df$predict_mse
  death_model_df$confirm_hospital_predict     <- confirm_predict_hospital_model_df$prediction
  death_model_df$confirm_hospital_offset      <- confirm_predict_hospital_model_df$predict_offset
#  death_model_df$confirm_hospital_intercept   <- confirm_predict_hospital_model_df$predict_intercept
#  death_model_df$confirm_hospital_coefficient <- confirm_predict_hospital_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add confirm ~ icu 
  #######################################
  death_model_df$confirm_icu_mse         <- confirm_predict_icu_model_df$predict_mse
  death_model_df$confirm_icu_predict     <- confirm_predict_icu_model_df$prediction
  death_model_df$confirm_icu_offset      <- confirm_predict_icu_model_df$predict_offset
#  death_model_df$confirm_icu_intercept   <- confirm_predict_icu_model_df$predict_intercept
#  death_model_df$confirm_icu_coefficient <- confirm_predict_icu_model_df$predict_coefficient
  
  death_model_df$newconfirm_newdeath_mse        <- newconfirm_predict_newsdeaths_model_df$predict_mse
  death_model_df$newconfirm_newdeath_prediction <- newconfirm_predict_newsdeaths_model_df$prediction
  death_model_df$newconfirm_newdeath_offset     <- newconfirm_predict_newsdeaths_model_df$predict_offset
  
  death_model_df$newconfirm_hospital_mse        <- newconfirm_predict_hospital_model_df$predict_mse
  death_model_df$newconfirm_hospital_prediction <- newconfirm_predict_hospital_model_df $prediction
  death_model_df$newconfirm_hospital_offset     <- newconfirm_predict_hospital_model_df$predict_offset
  
  death_model_df$newconfirm_icu_mse        <- newconfirm_predict_icu_model_df$predict_mse
  death_model_df$newconfirm_icu_prediction <- newconfirm_predict_icu_model_df$prediction
  death_model_df$newconfirm_icu_offset     <- newconfirm_predict_icu_model_df$predict_offset
  
  
  #######################################
  ### Death Model: Add hospital ~ icu
  #######################################
  death_model_df$hospital_icu_mse         <- hospital_predict_icu_model_df$predict_mse
  death_model_df$hospital_icu_predict     <- hospital_predict_icu_model_df$prediction
  death_model_df$hospital_icu_offset      <- hospital_predict_icu_model_df$predict_offset
#  death_model_df$hospital_icu_intercept   <- hospital_predict_icu_model_df$predict_intercept
#  death_model_df$hospital_icu_coefficient <- hospital_predict_icu_model_df$predict_coefficient
  
  #######################################
  ### Death Model: Add hospital ~ death
  #######################################
  death_model_df$hospital_death_mse         <- hospital_predict_deaths_df$predict_mse
  death_model_df$hospital_death_predict     <- hospital_predict_deaths_df$prediction
  death_model_df$hospital_death_offset      <- hospital_predict_deaths_df$predict_offset
#  death_model_df$hospital_death_intercept   <- hospital_predict_deaths_df$predict_intercept
#  death_model_df$hospital_death_coefficient <- hospital_predict_deaths_df$predict_coefficient
  
  death_model_df$hospital_newdeath_mse        <- hospital_predict_newdeaths_model_df$predict_mse
  death_model_df$hospital_newdeath_prediction <- hospital_predict_newdeaths_model_df$prediction
  death_model_df$hospital_newdeath_offset     <- hospital_predict_newdeaths_model_df$predict_offset
  
  #######################################
  ### Death Model: Add icu ~ death
  #######################################
  death_model_df$icu_death_mse         <- icu_predict_deaths_df$predict_mse
  death_model_df$icu_death_prediction  <- icu_predict_deaths_df$prediction
  death_model_df$icu_death_offset      <- icu_predict_deaths_df$predict_offset
#  death_model_df$icu_death_intercept   <- icu_predict_deaths_df$predict_intercept
#  death_model_df$icu_death_coefficient <- icu_predict_deaths_df$predict_coefficient

  death_model_df$icu_newdeaths_mse        <- icu_predict_newdeaths_model_df$predict_mse
  death_model_df$icu_newdeaths_prediction <- icu_predict_newdeaths_model_df$prediction
  death_model_df$icu_newdeaths_offset     <- icu_predict_newdeaths_model_df$predict_offset
  
  

  #### Build a separate Death Model Comprising the last 30 days
  death_model_last_30_df <- death_model_df[ (nrow(death_model_df)-30) : nrow(death_model_df),]
  
  #### Build Post May Death Model
  death_model_post_may_df <- death_model_df[ 36 : nrow(death_model_df),]

  #### Write Data Frames to File.
  #### The Project is to cumbersome to include in an RMD
  saveRDS(death_model_df, "model_death_model_df.dat")
  saveRDS(death_model_last_30_df, "model_death_model_last_30_df")
  saveRDS(death_model_post_may_df, "model_death_model_post_may_df")
  
  
  print("DONE: Code Chunk#2")
}#//END Code Chunk #3: Build State Models and Death_frame


####################################################################################
####################################################################################
####################################################################################
### BEGIN Death Model analysis #####################################################
####################################################################################
####################################################################################
####################################################################################


{
#### Predicted Deaths by Confirmed cases
#death_model_last_row <- death_model_df[nrow(death_model_df),]
#death_model_last_row
#str(death_model_last_row)

#error_rate <- abs( (death_model_last_row$daily_total_deaths - death_model_last_row$confirm_predict) / death_model_last_row$daily_total_deaths ) / 2
#error_rate

#death_statement_confirmed_1 <- paste0("Based on today's California confirmed case count of: ",death_model_last_row$daily_total_confirmed )
#death_statement_confirmed_2 <- paste0(" California is facing: ",
#                                      ( round(
#                                        (death_model_last_row$daily_total_confirmed * death_model_last_row$confirm_death_coefficient) + death_model_last_row$confirm_death_intercept
#                                      )) ," total deaths in ",
#                                      round(death_model_last_row$confirm_death_offset,2)," days +/- < 1%" )
#print(death_statement_confirmed_1)
#print(death_statement_confirmed_2)
### Build state level models to see if less granularity helps
offset_daily_df

#offset_lm_15_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",15)
confirm_predict_death_model_lm_df  <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",15)

confirm_predict_hospital_model_lm_df <- build_rolling_lm_offset(offset_daily_df,"hospitalized_covid_patients",15)

data.frame(
  
  actual=daily_combined_df$hospitalized_covid_patients,
  predict=confirm_predict_hospital_model_lm_df$predicted_deaths
)

1- sum(confirm_predict_hospital_model_lm_df$predicted_deaths) / sum(daily_combined_df$hospitalized_covid_patients)


data.frame(
  actual_hospital=death_model_df$hospitalized_covid_patients, 
  predict_hospital=newconfirm_predict_hospital_model_df$prediction)

### New Confirmed Cases Predicting Hospitalization has 21% error
1 / sum( ( (death_model_df$hospitalized_covid_patients - newconfirm_predict_hospital_model_df$prediction)^2 /  (death_model_df$hospitalized_covid_patients^2)) [-1:-23])

newconfirm_predict_icu_model_df

data.frame( new_confirmed=death_model_df$new_confimed, actual_icu=death_model_df$icu_combined,newconfirm_predict_icu=newconfirm_predict_icu_model_df$prediction,newconfirm_predict_icu_model_df$predict_offset,newconfirm_predict_icu_model_df$predict_coefficient )


1 / sum( ( (death_model_df$icu_combined - newconfirm_predict_icu_model_df$prediction)^2 /  (death_model_df$icu_combined^2)) [-1:-23])

tail( 
  data.frame(confirm=death_model_df$daily_total_confirmed, 
           deaths=death_model_df$daily_total_deaths,
           p_death=death_model_df$confirm_death_predict,
           o_death=death_model_df$confirm_death_offset,
           tested=death_model_df$tested,
           o_tested=death_model_df$testing_death_offset
           )
)
sum(newconfirm_predict_hospital_model_df$predict_mse)

sum(icu_predict_newdeaths_model_df$predict_mse)

sum(confirm_predict_newdeaths_model_df$predict_mse)

sum(death_model_df$icu_death_mse)
sum(death_model_df$icu_newdeaths_mse)

data.frame(
  tot_deaths=death_model_df$daily_total_deaths,
  #new_deaths=death_model_df$new_deaths,
  testing=death_model_df$testing_death_predict,
  confirm=death_model_df$confirm_death_predict,
  hospital=death_model_df$hospital_death_predict,
  icu=death_model_df$icu_death_prediction
)

data.frame(
  #tot_deaths=death_model_df$daily_total_deaths,
  #new_deaths=death_model_df$new_confimed,
  testing=death_model_df$testing_death_mse,
  confirm=death_model_df$confirm_death_mse,
  hospital=death_model_df$hospital_death_mse,
  icu=death_model_df$icu_death_mse
)

#### The best predictor of death is the total number of confirmed
#### testing has 3x more error, and is still fairly applicable
#### Obviously, confirmed is a better predictor of death, since a greater portion
#### of the confirmed will die compared to testing
#### We should spend some time looking at the differences between confirmed and testing
#### Since we are likely to throw away hospital and icu results at least as death indicators
#### Testing is also at a different granularity level, it is statewide
#### So we should avoid testing for scale, or maybe for positivity comparisons.

sum(death_model_df$testing_death_mse)
sum(death_model_df$confirm_death_mse)
sum(death_model_df$icu_death_mse)
sum(death_model_df$hospital_death_mse)

#### New Deaths
#### New deaths are difficult to predict, likely due to variation and scale
#### Maybe my offsets are too small. But there is clearly no direct correlation
#### using the current methods. Maybe take a look at the 30-60 day correlation model 
#### for better results, I doubt that less granularity would be more helpful
#### Besides, we can derive daily predictions from total predictions
#### This is likely a dead end.

sum(death_model_df$confirm_newdeath_mse)
sum(death_model_df$newconfirm_newdeath_mse)
sum(death_model_df$confirm_death_mse)

sum(death_model_df$newconfirm_hospital_mse)
sum(death_model_df$newconfirm_icu_mse )
sum(death_model_df$newconfirm_newdeath_mse)

sum(death_model_df$confirm_hospital_mse)
sum(death_model_df$confirm_icu_mse)
sum(death_model_df$confirm_death_mse)

sum(death_model_df$hospital_icu_mse )
sum(death_model_df$hospital_death_mse )
sum(death_model_df$hospital_newdeath_mse )

sum(death_model_df$icu_death_mse)
sum(death_model_df$icu_newdeaths_mse )





#### put ICU to bed
### ICU count does not correlate well with deaths or new deaths
### It is very difficult to predict who will die from ICU numbers
### The MSE's are way off
### MSE is lower in predicting total deaths, but it only increases with time
data.frame(
  new_deaths=death_model_df$new_deaths,
  icu_new=death_model_df$icu_newdeaths_prediction,
  icu_new_mse=death_model_df$icu_newdeaths_mse,
  tot_deaths=death_model_df$daily_total_deaths,
  icu=death_model_df$icu_death_prediction,
  icu_tot_mse=death_model_df$icu_death_mse
)


daily_covid_df
death_model_df
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


offset_lm_15_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",15)

offset_lm_15_df$mse
tail(offset_lm_15_df)

los_angeles_temp_model_df <- get_county_models("los angeles", "\\models\\confirm_~_deaths")
los_angeles_temp_model_df
#,"\\models\\confirm_~_hospital", "\\models\\confirm_~_icu", "\\models\\hospital_~_icu","\\models\\hospital_~_deaths", "\\models\\icu_~_deaths") )

ca_covid_df[which(ca_covid_df$county=="los angeles"),]
}
####################################################################################
####################################################################################
####################################################################################
### END Death Model analysis   #####################################################
####################################################################################
####################################################################################
####################################################################################


#######################################################
#######################################################
#######################################################
#### Initial Plotting #################################
#######################################################
#######################################################
#######################################################

############################################################################
#### Model Error rates as a function of California testing effectiveness
###########################################################################
#Color Pallette
#6A3534,#43536A,#366A46,#966233
#E17876,#6C7A9D,#2D6A4D,#59411A
## backgorund= lavenderblush, aliceblue

### Model Error Rate Comparison
ggplot() + theme_light() + theme(panel.background = element_rect(fill = "lavenderblush")) +
  geom_line(data = death_model_df, size=1.5 ,aes(y = confirm_death_mse, x = date, color="Confirmed Predict Death") ) +
  geom_line(data = death_model_df, size=1,   aes(y = testing_death_mse, x = date, color="Testing Predict Death" )) +
  geom_line(data = death_model_df, size=.5, aes(y = hospital_death_mse, x = date, color="Hospital Predict Death" ),  ) +
  geom_line(data = death_model_df, size=.5, aes(y = icu_death_mse,      x = date, color="ICU Predict Death" ) ) +
  scale_color_manual(values = c(
  "Confirmed Predict Death" = "darkred",
  "Testing Predict Death" = "#E17876",
  "Hospital Predict Death" = "#2D6A4D",
  "ICU Predict Death" = "#59411A"
  ),name="models") +
  labs( x="Date", 
        y="Relative Model Error (MSE)", 
        name="Models:", 
        title="Relative Model Error Rates", 
        subtitle="Combined County Models (Lower is Better)"  )  

########################################
### MSE
### Confirmed Predicting Deaths 
########################################
ggplot() + theme_light() + 
  theme(
    panel.background = element_rect(fill = "lavenderblush"),
    legend.position = c(.79,.94), 
    legend.direction = "vertical") +
  geom_line(data = death_model_df ,aes(y = confirm_death_mse, x = date, color="Confirmed Cases Predicting Death") ) +
  scale_color_manual(values = c(
    "Confirmed Cases Predicting Death" = "darkred"
  ),name="Model") +
  labs( x="Date", y="Model Error (MSE)", name="", 
        title="Relative California COVID Testing effectiveness", subtitle="Model error as a proxy for effectiveness\n(Lower is Better)"  )  





############################################################
### Last 30 Days
### Confirmed Predicting Deaths vs actual Confirmed/Deaths
############################################################
ggplot() + theme_light() + 
  theme( 
    panel.background = element_rect(fill = "lavenderblush"), 
    legend.position = c(.3,.95), 
    legend.direction = "horizontal") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_line(data = death_model_last_30_df , size=1, aes(y = daily_total_confirmed, x = confirm_death_predict, color="Death Prediction Based on Confirmed Cases") ) +
  geom_point(data = death_model_last_30_df, size=1.5,aes(y = daily_total_confirmed, x = daily_total_deaths),color='blue') +
  scale_color_manual(values = c(
    "Death Prediction Based on Confirmed Cases" = "darkred"
  ),name="") +
  labs( title="California Confirmed Cases vs Deaths", 
        subtitle="With Regression Prediction (Last 30 Days)",
        y="Total California Confirmed Cases",
        x="Total California Covid Deaths" 
  )  



ggplot() + theme_light() + 
  theme( 
    panel.background = element_rect(fill = "lavenderblush"), 
    legend.position = c(.27,.89), 
    legend.direction = "vertical") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_point(data = death_model_last_30_df, size=1.5,aes(y = daily_total_confirmed,   x = daily_total_deaths),color='blue') +
  
  geom_line(data = death_model_last_30_df, size=.5, aes(y = daily_total_confirmed,    x = hospital_death_predict, color="Hospital Predict Death" ),  ) +
  geom_line(data = death_model_last_30_df, size=.5, aes(y = daily_total_confirmed,    x = icu_death_prediction, color="ICU Predict Death" ) ) +
  geom_line(data = death_model_last_30_df , size=1, aes(y = daily_total_confirmed,  x = confirm_death_predict, color="Death Prediction Based on Confirmed Cases") ) +
  geom_line(data = death_model_last_30_df, size=1,   aes(y = daily_total_confirmed,   x = testing_death_predict, color="Testing Predict Death" )) +
  scale_color_manual(values = c(
    "Death Prediction Based on Confirmed Cases" = "darkred",
    "Testing Predict Death" = "#E17876",
    "Hospital Predict Death" = "#2D6A4D",
    "ICU Predict Death" = "#59411A"
  ),name=NULL) +
  labs( title="California Confirmed Cases vs Deaths", 
        subtitle="Varous Regression Models (Last 30 Days)",
        y="Total California Confirmed Cases",
        x="Total California Covid Deaths" 
  )  


mean(death_model_post_may_df$confirm_death_offset)
mean(death_model_post_may_df$confirm_hospital_offset)

ggplot() + theme_light() + 
  theme( 
    panel.background = element_rect(fill = "lavenderblush"),
    legend.position = c(.8,.29), 
    legend.direction = "vertical") +
  geom_line(data = death_model_post_may_df, size=.5,aes(y = confirm_death_offset,   x = date,color='Days: Confirmed to Death')) +
  geom_line(data = death_model_post_may_df, size=.5,aes(y = confirm_hospital_offset,   x = date,color='Days: Confirmed to Hospitalization')) +
  scale_color_manual(values = c(
    "Days: Confirmed to Death" = "darkred",
    "Days: Confirmed to Hospitalization" = "#2D6A4D"
  ),name=NULL) +
  labs( title="Correlated Days between Confirmed Cases and Death/Hospitalization", 
        subtitle=NULL,
        y="Correlated Days with outcome",
        x=NULL 
  ) 




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









##########################################################################################################
### These are for paper only. These results can be tossed if/when we can properly
### resassemble the offsets and coeefficients from the county model
##########################################################################################################
#  confirm_predict_deaths_df <- build_rolling_lm_offset(offset_daily_df,"daily_total_deaths",15)
#  confirm_predict_hospital_df <- build_rolling_lm_offset(offset_daily_df,"hospitalized_covid_patients",15)
#  confirm_predict_icu_df <- build_rolling_lm_offset(offset_daily_df,"icu_combined",15)

#  death_model_state_aggregate_df <- data.frame(
#    date=confirm_predict_deaths_df$date,
#    daily_total_confirmed = offset_daily_df$daily_total_confirmed,
#    actual_deaths = offset_daily_df$daily_total_deaths,
#    confirm_death_predict=confirm_predict_deaths_df$predicted_deaths,
#    confirm_death_mse=confirm_predict_deaths_df$mse,
#    confirm_death_mse_rescale = rescale_mse(confirm_predict_deaths_df$mse,confirm_predict_deaths_df$offset_index),
#    confirm_death_offset=confirm_predict_deaths_df$offset_index,
#    confirm_hospital_predict=confirm_predict_hospital_df$predicted_deaths,
#    confirm_hospital_mse = confirm_predict_hospital_df$mse,
#    confirm_hospital_offset = confirm_predict_hospital_df$offset_index,
#    confirm_icu_predict = confirm_predict_icu_df$predicted_deaths,
#    confirm_icu_mse = confirm_predict_icu_df$mse,
#    confirm_icu_offset = confirm_predict_icu_df$offset_index
#  )
