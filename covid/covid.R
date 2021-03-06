### Look at calculating accurate infection dates
### Add Phased reopening data and correlate subsequent infections hospitalizations and deaths. Correlate

library(ggplot2)
library(pastecs)

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

removeCols <- function(data_df,col_vector){
  ### col_vector is a vector of column names to remove
  data_df <- data_df[, ! names(data_df) %in% col_vector, drop = F]
  
  return(data_df)
}



## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\dsc520")

#covidRootPath <- "c:\\Users\\newcomb\\DSCProjects\\DSC\\covid\\"
covidRootPath <- "L:\\stonk\\projects\\DSC\\DSC\\covid\\"


hopkinsPath <- "C:\\Users\\newcomb\\DSCProjects\\COVID-19\\csse_covid_19_data\\csse_covid_19_time_series\\"
hopkins_us_confirmed_path <- paste(hopkinsPath,"time_series_covid19_confirmed_US.csv",sep="")
  
hopkins_us_confirmed <- read.csv(hopkins_us_confirmed_path)
head(hopkins_us_confirmed)





##########################################################################################
### Build combined tables
##########################################################################################



###########################################################################################
###########################################################################################
##### Hopkins data
###########################################################################################
###########################################################################################

### Get a list of the states
hopkins_states <- unique(hopkins_us_confirmed$Province_State)
hopkins_states

hopkins_confirmed_condensed <- data.frame()

### Sum county values into state Values
### Loop through states
for (stateCount in 1:length(hopkins_states)){
  thisStateName <- hopkins_states[stateCount]
  print(thisStateName)
  ### Looping through each column
  ### Unlist converts data_frame list to vector
  #thisColumn <- unlist(hopkins_us_confirmed[stateCount])
  
  print(hopkins_us_confirmed[ which( hopkins_us_confirmed$Province_State==thisStateName, ) ])
  
  

 
  
  ### Sapply returns a vector. The function returns 0 if NA, else returns existing value
  #new_column <- sapply(thisColumn, function(x){
  #  if (is.na(x) ) {
  #    return(0)
  #  } else { return(x) }
  #},simplify="array")
  
  #hopkins_us_confirmed[stateCount] <- new_column
  
  
}###///


###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################
### LEgacy Code for reference because we did good work 
###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################
###########################################################################################


fresno_df <- ca_hospital_df [ which( ca_hospital_df[countyCol] == "Fresno"), ]
head(fresno_df)

### Basic plotting of two inputs
ggplot(data=fresno_df, aes(x=todays_date, group=1)) +
  geom_line(aes(y=icu_available_beds , color = "icu_available_beds"  ) )

ggplot(data=fresno_df, aes(x=todays_date, group=1)) +
  geom_line(aes(y=icu_combined , color = "icu_combined "  ) ) + 
  geom_line(aes(y=icu_available_beds , color = "icu_available_beds"  ) )


###########################################################################################
#Generate a vector of colors
#n = number of colors in vector
library(RColorBrewer)
n <- 60
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
#pie(rep(1,n), col=sample(col_vector, n))
#col_vector
###########################################################################################




### Build a list of Unique Dates
date <- unique(ca_covid_df$Most.Recent.Date)

county <- unique(ca_covid_df$County.Name)

county_total_confirmed_df <- data.frame(date)


length(date)
length(county)
### Build County Confirmed 
for (x in 1:length(county)){
  temp_count <- ca_covid_df [ which( ca_covid_df$County.Name == county[x]), ]
  temp_count <- temp_count$Total.Count.Confirmed
  #temp_count.replace      <- function(x) { replace(x, is.na(x), 0) }
  print(county[x])
  print(length(temp_count))
  # Replace NA with 0, the hard way
  for (q in 1:length(temp_count)){
    if (is.na(temp_count[q])){
      temp_count[q] = 0
    }
  }
  # Prepend 0's to any vector missing rows
  while (length(temp_count) < 82){
    temp_count <- append(temp_count,0,0)
  }
  print(length(temp_count))
  print(temp_count)
  name <- gsub(" ","_",county[x])
  county_total_confirmed_df[name] <- temp_count
}
head(county_total_confirmed_df)

### Build a separate county vector of County Names with spaces replaced by _
county_ <- c()
for (x in 1:length(county)){
  temp_val <- gsub(" ","_",county[x])
  print(temp_val)
  county_ <- append(county_,temp_val)

}

### Build county_daily_confirmed_df
### New confirmed Cases per day, total cases of the day, minus the previous day

county_daily_confirmed_df <- data.frame(date)

for (n in 1:length(county_)){
  i <- 0
  temp_df <- sapply(county_total_confirmed_df[county_[n]], function(x){
    temp_col <- c(0)
    for (i in 2:length(x)){
      
      temp_col <- append(temp_col,x[i] - x[i-1])
      
    }
    return(temp_col)
  },simplify="array")
  county_daily_confirmed_df[county_[n]] <- temp_df
}

county_daily_confirmed_df$Los_Angeles



### get all values on a specific day
#oneDay <- ca_covid_df [ which( ca_covid_df$Most.Recent.Date == datefactor[1]), ]$Total.Count.Confirmed



### Build Statewide Confirmed
### uses sapply to build vectors using datefactor as the index,
total_confirmed <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Total.Count.Confirmed,na.rm = TRUE), simplify = "array")
total_deaths <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Total.Count.Deaths,na.rm = TRUE), simplify = "array")
total_positive_patients <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_suspected_patients <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Suspected.COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_positive_icu <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$ICU.COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_suspected_icu <- sapply(date, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$ICU.COVID.19.Suspected.Patients,na.rm = TRUE), simplify = "array")



## Combine Active and suspected ICU
total_active_patients = total_suspected_patients + total_positive_patients

## Combine active and suspected ICU
total_active_icu = total_positive_icu + total_suspected_icu

### Get the daily confirmed totals
### Outer counter, used for index
i <- 0
daily_confirmed <- sapply(total_confirmed, function(x) {
    ### Increment the outer counter
    i <<- i+1

    ### Daddy's First If Statement in R!    
    if (i == 1 ){
      return(0)
    } 
    else {
      return(total_confirmed[i] - total_confirmed[i-1])
    }
  },simplify = "array")

### Get the daily death totals
### Outer counter, used for index
i <- 0
daily_deaths <- sapply(total_deaths, function(x) {
  ### Increment the outer counter
  i <<- i+1
  
  ### Daddy's First If Statement in R!    
  if (i == 1 ){
    return(0)
  } 
  else {
    return(total_deaths[i] - total_deaths[i-1])
  }
},simplify = "array")

daily_deaths

state_df <- data.frame(date,total_confirmed,total_deaths,total_active_patients,total_active_icu,daily_confirmed)
state_df
numeric_df <- data.frame(total_confirmed,daily_confirmed,total_deaths,daily_deaths,total_active_patients,total_active_icu)

pairs(numeric_df)

cov(total_confirmed,total_deaths)
i <- 0
cov_time_confirmDeaths <- sapply(date, function(x){
  
  i <<- i+1
  if (i==1) { return(0) } 
  else {
    return(cov(state_df$total_confirmed[1:i], state_df$total_deaths[1:i]))  
  }
  
  
}, simplify = "array")

i <- 0
cor_time_confirmDeaths <- sapply(date, function(x){
  
  i <<- i+1
  if (i==1) { return(0) } 
  else {
    return(cor(state_df$total_confirmed[1:i], state_df$total_deaths[1:i]))  
  }
  
  
}, simplify = "array")

cor_time_confirmDeaths

cov_frame <- data.frame(date, cov_time_confirmDeaths, cor_time_confirmDeaths)
cov_frame

sum(county_df[,-1])

pairs(cov_frame)
ggplot(data=county_total_confirmed_df, aes(x=date, group=1)) +
    geom_line(aes(y=Los_Angeles, color = "Los_Angeles" ) ) +
    geom_line(aes(y=San_Francisco, color = "San_Francisco" ) ) +
    geom_line(aes(y=Alameda, color = "Alameda" ) ) 

column_names <- names(county_total_confirmed_df)[2:(ncol(county_total_confirmed_df))]

command <- "ggplot(data=county_total_confirmed_df, aes(x=date)) +"
#command <- paste(command,"geom_line(aes(y=Los_Angeles, color = 'Los_Angeles' ) )")
#eval(parse(text=command))
count <- 0
for (i in column_names){
  count <<- count + 1
    command <- paste(command,"geom_line(aes(y=",i,", colour=\"",i,"\") )") 
    if ( count < length(column_names) ) {
      command <- paste(command," + ")
    }
 
}
command <- paste(command,"+ scale_colour_manual('',labels=column_names,breaks=column_names,values=col_vector) + theme_dark()  + theme( panel.background = element_rect(fill = 'black'), legend.position='top' )")
#command <- paste(command,"+ scale_colour_manual('',labels=column_names,breaks=column_names,values=col_vector) + theme_dark()  + theme( panel.background = element_rect(fill = 'black') )")
#+ theme(legend.position="top")
command <- gsub(" ","",command)
print(command)
eval(parse(text=command))

column_names <- names(county_daily_confirmed_df)[3:(ncol(county_daily_confirmed_df))]

command <- "ggplot(data=county_daily_confirmed_df, aes(x=date)) +"
count <- 0
for (i in column_names){
  count <<- count + 1
  command <- paste(command,"geom_line(aes(y=",i,", colour=\"",i,"\") )") 
  if ( count < length(column_names) ) {
    command <- paste(command," + ")
  }
  
}
command <- paste(command,"+ scale_colour_manual('',labels=column_names,breaks=column_names,values=col_vector) + theme_dark()  + theme( panel.background = element_rect(fill = 'black'), legend.position='top' )")
#command <- paste(command,"+ scale_colour_manual('',labels=column_names,breaks=column_names,values=col_vector) + theme_dark()  + theme( panel.background = element_rect(fill = 'black') )")
#+ theme(legend.position="top")
command <- gsub(" ","",command)
print(command)
eval(parse(text=command))

