library(ggplot2)

build_offset_columns <- function(input_df,target_col,range_vector){
  
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
build_rolling_offset <- function(input_df,rolling_days){
  
  
  ### Find the best offset covariance over a period of rolling days
  output_vector <- c()  
  output_vector2 <- c()  
  mse_vector <- c()
  
  ### Loop through input data frame
  for (i in 1:nrow(input_df)){
    if (i <= rolling_days) {
      output_vector2 <- append(output_vector2,0) 
      mse_vector <- append(mse_vector,0)
      next
    }
    #output_vector <- append(output_vector,1) 
    ### Get a subset of the input_df i - rolling_days
    #print(input_df[(i- rolling_days):i,])
    #offset_daily_df[76:nrow(offset_daily_df),]
    #print(temp_df)
    #print(cor(input_df[2:length(input_df)]) )
    #covResponse <- cov(input_df[2:length(input_df)])[2,] 
    #corResposnse <- cor(input_df[2:length(input_df) ],method=c("pearson"))[2,]
    #print(covResponse)
    #print(corResposnse)
    
    temp_df <- input_df[(i - rolling_days):i,2:length(input_df)]
    
    least_residual <- -1
    least_offset <- ""
    most_cor <- -1
    most_cor_offset <- ""
    ### Build Residuals for each offset Column
    ### Loop through each offset column
    
    tempCor <- (cor(temp_df)[2,])
    #print(max(tempCor[3:length(tempCor)]))
    for (q in 3:length(tempCor)){
      #print(tempCor[q])
      if (most_cor == -1 ){ 
        most_cor <- tempCor[q] 
        most_cor_offset <- colnames(temp_df)[q]
        next
      }
      if (tempCor[q] > most_cor){
        most_cor <- tempCor[q] 
        most_cor_offset <- colnames(temp_df)[q]
      }
      
    }
    #print("Most_cor")
    #print(most_cor)
    #print("Most_cor_offset")
    #print(most_cor_offset)
    #print(temp_df[most_cor_offset])
    
    ## Build a linear model prediction based on suggested offset.
    ## calculate the error of the prediction
    
    temp_lm <-  lm(daily_total_deaths ~ offset_14, data=temp_df)
    
    #print(summary(temp_lm))
    
    temp_predict_df <- data.frame( 
      daily_total_deaths = predict(temp_lm, newdata=temp_df), 
      daily_total_confirmed=temp_df[most_cor_offset])
    
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
  
  return(data.frame(date = input_df$date,mse=mse_vector,error=offset_error,offset=output_vector2))
  #eval(parse(text=command))
  
  
}### END build rolling offset
build_statewide_numbers <- function(input_df){
  #### Sum the numbers across the state to build a big picture estimate
  
  ### Build unique dates
  date <- unique(input_df$date)
  
  ### build statewide confirmed numbers
  daily_total_confirmed <- sapply(date,function(x){
    ### Build data frame for each date
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum confirmed for daily total
    return(sum(this_df$totalcountconfirmed) )
  },simplify="array")
  
  daily_total_deaths <- sapply(date,function(x){
    this_df <- (input_df [which(input_df$date == x),])
    ### Sum deaths for daily total
    return(sum(this_df$totalcountdeaths) )
  },simplify="array")
  
  return(data.frame(date,daily_total_confirmed,daily_total_deaths))
  
}#// END build statewide numbers

buildCounties_df <- function(input_df,input_names){
  #### Build a data frame of counties listed in input_names. Multiple counties will be summed
  date <- unique(ca_covid_df$date)
  
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


## Set the working directory to the root of your DSC 520 directory
setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

### Read CSV 

#ca_hospital_df <- read.csv("final_CA_Hospital.csv")
ca_covid_df <- read.csv("final_CA_Confirmed.csv")
#ca_population_df <- read.csv("final_CA_county_population.csv")
#ca_demo_df <- read.csv("Final_CA_Race_Demographic.csv")

### strip first column which duplicates row Index.It's a write.CSV thing
#ca_hospital_df   <- ca_hospital_df[,2:length(ca_hospital_df)]
ca_covid_df      <- ca_covid_df[,2:length(ca_covid_df)]
#ca_population_df <- ca_population_df[,2:length(ca_population_df)]
#ca_demo_df       <- ca_hospital_df[,2:length(ca_demo_df)]

#tail(ca_hospital_df)
#tail(ca_covid_df)
#tail(ca_population_df)
#tail(ca_demo_df)

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


############################################################
### build statewide Numbers - daily_covid_df
############################################################


daily_covid_df <- build_statewide_numbers(ca_covid_df)
alameda_df <- buildCounties_df(ca_covid_df,c("alameda"))


############################################################
### build State confirmed offset columns - 
############################################################
offset_daily_df <- build_offset_columns(daily_covid_df,"daily_total_confirmed",8:30)

############################################################
### build Alameda confirmed offset columns - 
############################################################
alameda_offset_daily_df <- build_offset_columns(alameda_df,"daily_total_confirmed",8:30)

alameda_offset_daily_df

offset_daily_df

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

alameda_last_30_df <- build_last_30_df(alameda_offset_daily_df)

alameda_predict_df <- build_model_last_30days(alameda_last_30_df)
alameda_predict_df
df_for_plot <- alameda_last_30_df
predict_df_for_plot <- alameda_predict_df

ggplot(data = df_for_plot, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  geom_line(color='red'   ,data = predict_df_for_plot, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  xlab("Total Covid Deaths") + ylab("Total Confirmed Cases")



############################################################
### Build the offsets data frame. 
############################################################
offset_df <- build_rolling_offset(offset_daily_df,30)
#min_mse <- min(offset_df[offset_df$mse > 0,]$mse)
#offset_df$mse <- round(offset_df$mse,0)
#offset_df$error <- round(offset_df$error,0)
#offset_df$offset <- gsub("offset_","",offset_df$offset)
#write.csv(offset_df,"C:\\Users\\newcomb\\DSCProjects\\DSC\\covid\\error_offset.csv")

#error_offset <- vapply(offset_df$mse,function(x){
#  if (x == 0) {return(x)}
#  return(mse/x)
#},numeric(1))

############################################################
### Build model for last 30 days
############################################################
### Get the offset for the last date
############################################################
last_offset <- offset_df$offset[nrow(offset_df)]

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


summary(last_month_lm)


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
  xlab("Total Covid Deaths") + ylab("Total Confirmed Cases")


last_row <- offset_daily_df[nrow(offset_daily_df),]

last_month_predict_df


           