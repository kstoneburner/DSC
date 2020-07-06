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

## Fit a linear model between confirmed and deaths
covid_base_lm <-  lm(totalcountdeaths ~ totalcountconfirmed, data=ca_covid_df)

## View the summary of your model using `summary()`
summary(covid_base_lm)
sqrt(.9753)

### Raw plot prediction of confirmed vs deaths
## Creating predictions using `predict()`
#covid_base_predict_df <- data.frame(totalcountdeaths = predict(covid_base_lm, newdata=ca_covid_df), totalcountconfirmed=ca_covid_df$totalcountconfirmed)

############################################################
### build statewide Numbers - daily_covid_df
############################################################

#### Crunch the data frame to daily sums
covid_dates <- unique(ca_covid_df$date)

### build statewide confirmed numbers
daily_total_confirmed <- sapply(covid_dates,function(x){
  ### Build data frame for each date
  this_df <- (ca_covid_df [which(ca_covid_df$date == x),])
  ### Sum confirmed for daily total
  return(sum(this_df$totalcountconfirmed) )
},simplify="array")

daily_total_deaths <- sapply(covid_dates,function(x){
  this_df <- (ca_covid_df [which(ca_covid_df$date == x),])
  ### Sum deaths for daily total
  return(sum(this_df$totalcountdeaths) )
},simplify="array")

#### Assign friendly date column name
date <- covid_dates

#### Build summarized totals by date
daily_covid_df <- data.frame(date,daily_total_confirmed,daily_total_deaths)

#############################################################
### Correlation
#############################################################
ggplot(data = daily_covid_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

cor(daily_covid_df$daily_total_confirmed,daily_covid_df$daily_total_deaths)


############################################################
### build confirmed offset columns from 1 to 21
############################################################
daily_covid_df
offset_daily_df <- build_offset_columns(daily_covid_df,"daily_total_confirmed",1:21)

### Correlate Daily Total row
### Looking for column with highest correlation value
### Looks like offset_9 
cor(offset_daily_df[2:length(colnames(offset_daily_df))])[2,]


############################################################
############################################################
############################################################
### Modeling:
### Build Linear Models here
############################################################
############################################################
############################################################

### Base Model comparing confirmed and deaths on the same day. There is a lag between the two
### Predicting: Deaths based on confirmed
state_CD_base_lm <-  lm(daily_total_deaths ~ daily_total_confirmed, data=offset_daily_df)


### Created Prediction data frame using the base model
### Build prediction based on Model
### State Confirmed/Deaths - state_CD_base_predict_df
state_CD_base_predict_df <- data.frame(
  daily_total_deaths = predict(state_CD_base_lm, 
                               newdata=offset_daily_df), 
  daily_total_confirmed=offset_daily_df$daily_total_confirmed)

### Analyze Base mode
## View the summary of your model using `summary()`
summary(state_CD_base_lm)
sqrt(.9467) ## R=.9729851

#### Get residuals from prediction
base_residual <- offset_daily_df$daily_total_deaths - state_CD_base_predict_df$daily_total_deaths
### Base Error
base_residual <- sum(base_residual^2)

### Build Model off of offset_9. This offset had the highest correlation value between confirmed and deaths.
state_CD_offset_9_lm <-  lm(daily_total_deaths ~ offset_9, data=offset_daily_df)

### Created Prediction data frame using offset_15
### Build prediction based on Model
state_CD_offset_9_predict_df <- data.frame(
  daily_total_deaths = predict(state_CD_offset_9_lm, 
                               newdata=offset_daily_df), 
  daily_total_confirmed=offset_daily_df$daily_total_confirmed)

### Analyze Offset_9
## View the summary of your model using `summary()`
summary(state_CD_offset_9_lm)
sqrt(.9619) ## R=0.980765

#### Get residuals from prediction - Subtract Death data from death prediction
offset_9_residual <- offset_daily_df$daily_total_deaths - state_CD_offset_9_predict_df$daily_total_deaths
### Base Error
offset_9_residual <- sum(offset_9_residual^2)

offset_9_residual


### Build Model off of offset_15. The given time from infection to death is 21 days. 5 days from infection to symptom.
### Assume quick testing, and 3 days turn around. Which is pretty optimistic but a good starting place
state_CD_offset_15_lm <-  lm(daily_total_deaths ~ offset_15, data=offset_daily_df)

### Created Prediction data frame using offset_15
### Build prediction based on Model
state_CD_offset_15_predict_df <- data.frame(
  daily_total_deaths = predict(state_CD_offset_15_lm, 
                               newdata=offset_daily_df), 
  daily_total_confirmed=offset_daily_df$daily_total_confirmed)


### Analyze Offset_15
## View the summary of your model using `summary()`
summary(state_CD_offset_15_lm)
sqrt(.9564) ## R=0.9779571

#### Get residuals from prediction - Subtract Death data from death prediction
offset_15_residual <- offset_daily_df$daily_total_deaths - state_CD_offset_15_predict_df$daily_total_deaths
### Base Error
offset_15_residual <- sum(offset_15_residual^2)

### TRUE! Less Error than base Model, but visually....not quite aligning
offset_15_residual < base_residual


############################################################
############################################################
############################################################
### plotting:
############################################################
############################################################
############################################################

######################################################################################
#### Verify work with Plot
######################################################################################
## Blue Base plot: Confirmed by deaths over time -
## Red Offset_9
## Black Offset_16
ggplot(data = offset_daily_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) +
  geom_point(color='blue') +
  geom_line(color='blue',data = state_CD_base_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  geom_line(color='red',data = state_CD_offset_9_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) 
  #geom_line(color='black',data = state_CD_offset_15_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) 


######################################################################################
#### Analysis: The model holds pretty well until 4500 deaths. Let's examine that.
#### The Death to confirmed ration shifts significant starting in June.
#### Let's model based on post June Data
######################################################################################

############################################################
############################################################
############################################################
### Modeling: Post June
############################################################
############################################################
############################################################

june_offset_df <- offset_daily_df[76:nrow(offset_daily_df),]

### Base Model comparing confirmed and deaths for Post June data
### Predicting: Deaths based on confirmed
june_CD_base_lm <-  lm(daily_total_deaths ~ daily_total_confirmed, data=june_offset_df)


############################################################################
### Created Prediction data frame using the base model
### Build prediction based on Model
### State Confirmed/Deaths - state_CD_base_predict_df
############################################################################
june_CD_base_predict_df <- data.frame( date=june_offset_df$date,
  daily_total_deaths = predict(june_CD_base_lm, 
                               newdata=june_offset_df), 
  daily_total_confirmed=june_offset_df$daily_total_confirmed)

### Analyze Base mode
## View the summary of your model using `summary()`
summary(june_CD_base_lm)
sqrt(.9623) ## R=.9809689

#### Get residuals from prediction
june_base_residual <- june_offset_df$daily_total_deaths - june_CD_base_predict_df$daily_total_deaths
### Base Error
june_base_residual <- sum(june_base_residual^2)

### Look at offset Correlations for post June
### Offset 13 Has the highest correlation for post June
cor(june_offset_df[2:length(colnames(june_offset_df))])[2,]

############################################################################
### Build Offset 9 Model and Data Set
### Base Model comparing confirmed and deaths for Post June data
### Predicting: Deaths based on confirmed
############################################################################
june_CD_offset_9_lm <-  lm(daily_total_deaths ~ offset_9, data=june_offset_df)

summary(june_CD_offset_9_lm)
sqrt(.9899) ## R=.9949372

june_CD_offset_9_predict_df <- data.frame( date=june_offset_df$date,
  daily_total_deaths = predict(june_CD_offset_9_lm, 
                               newdata=june_offset_df), 
  daily_total_confirmed=june_offset_df$daily_total_confirmed)

#### Get residuals from prediction
june_offset_9_residual <- june_offset_df$daily_total_deaths - june_CD_offset_9_predict_df$daily_total_deaths
### Base Error
june_offset_9_residual <- sum(june_offset_9_residual^2)

############################################################################
### Build Offset 13 Model and Data Set
### Base Model comparing confirmed and deaths for Post June data
### Predicting: Deaths based on confirmed
############################################################################
june_CD_offset_13_lm <-  lm(daily_total_deaths ~ offset_13, data=june_offset_df)

summary(june_CD_offset_13_lm)
sqrt(.9957) ## R=.9978477

june_CD_offset_13_predict_df <- data.frame(date=june_offset_df$date,
  daily_total_deaths = predict(june_CD_offset_13_lm, 
                               newdata=june_offset_df), 
  daily_total_confirmed=june_offset_df$daily_total_confirmed)

#### Get residuals from prediction
june_offset_13_residual <- june_offset_df$daily_total_deaths - june_CD_offset_13_predict_df$daily_total_deaths
### Base Error
june_offset_13_residual <- sum(june_offset_13_residual^2)

############################################################################
### Build Offset 14 Model to test our assumptions that there is more error
############################################################################
june_CD_offset_14_lm <-  lm(daily_total_deaths ~ offset_14, data=june_offset_df)

summary(june_CD_offset_14_lm)
sqrt(.9957) ## R=.9978477

june_CD_offset_14_predict_df <- data.frame(date=june_offset_df$date,
  daily_total_deaths = predict(june_CD_offset_14_lm, 
                               newdata=june_offset_df), 
  daily_total_confirmed=june_offset_df$daily_total_confirmed)

#### Get residuals from prediction
june_offset_14_residual <- june_offset_df$daily_total_deaths - june_CD_offset_14_predict_df$daily_total_deaths
### Base Error
june_offset_14_residual <- sum(june_offset_14_residual^2)


june_base_residual 
june_offset_9_residual
june_offset_13_residual
june_offset_14_residual

############################################################
############################################################
############################################################
### plotting: Post June
############################################################


######################################################################################
#### Verify work with Plot############################################################
############################################################
######################################################################################
## Blue Base plot: Confirmed by deaths over time -
## Red Offset_9
## Black Offset_16
ggplot(data = june_offset_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
#  geom_line(color='blue'  ,data = june_CD_base_predict_df,      aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  geom_line(color='red'   ,data = june_CD_offset_14_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) +
  xlab("Total Covid Deaths") + ylab("Total Confirmed Cases")


ggplot(data = offset_daily_df, aes(y = daily_total_confirmed, x = daily_total_deaths)) + geom_point(color='blue') +
  geom_line(color='red'   ,data = june_CD_offset_14_predict_df, aes(y=daily_total_confirmed, x=daily_total_deaths)) 

nrow(june_CD_offset_14_predict_df)

### Average Deaths per confirmed from 14 days prior
mean(june_CD_offset_14_predict_df$daily_total_deaths / june_CD_offset_14_predict_df$daily_total_confirmed)

sum(june_offset_df$daily_total_deaths)^2
june_offset_14_residual
## Number of observations
## method: str(heights_df)
n <- 33
## Number of regression parameters
p <- 2
## Corrected Degrees of Freedom for Model (p-1)
dfm <- p-1
## Degrees of Freedom for Error (n-p)
dfe <- n-p
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n-1

## Corrected Sum of Squares for Model
## Calculate Sum of the Squares for the prediction model. Greater the number, the greater the error.
ssm <- sum((mean(june_offset_df$daily_total_deaths) - june_CD_offset_14_predict_df$daily_total_deaths)^2)
ssm
## Mean of Squares for Error:   MSE = SSE / DFE
mse <- june_offset_14_residual / dfe
mse

