library(ggplot2)
library(pastecs)

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
#setwd("L:\\stonk\\projects\\DSC\\dsc520")

covidRootPath <- "L:\\stonk\\projects\\DSC\\DSC\\covid\\"

caCovidPath <- "ca_covid_cases.csv"
cdcDeathsPath <- "cdcMortality.csv"

ca_covid_filePath <- paste(covidRootPath,caCovidPath,sep="")
ca_covid_filePath

ca_covid_df <- read.csv(ca_covid_filePath)
### Convert Date to a Date object
ca_covid_df$Most.Recent.Date <- as.Date(ca_covid_df$Most.Recent.Date,"%m/%d/%y")

head(ca_covid_df)


ca_covid_df$Total.Count.Deaths

la_df <- ca_covid_df [ which( ca_covid_df$County.Name == "Los Angeles"), ]

sf_df <- ca_covid_df [ which( ca_covid_df$County.Name == "San Francisco"), ]
sf_df
alameda_df <- ca_covid_df [ which( ca_covid_df$County.Name == "Alameda"), ]
alameda_df

### Build a list of Unique Dates
date <- unique(ca_covid_df$Most.Recent.Date)

### get all values on a specific day
#oneDay <- ca_covid_df [ which( ca_covid_df$Most.Recent.Date == datefactor[1]), ]$Total.Count.Confirmed



### Build Statewide Confirmed
### uses sapply to build vectors using datefactor as the index,
total_confirmed <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Total.Count.Confirmed,na.rm = TRUE), simplify = "array")
total_deaths <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Total.Count.Deaths,na.rm = TRUE), simplify = "array")
total_positive_patients <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_suspected_patients <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$Suspected.COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_positive_icu <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$ICU.COVID.19.Positive.Patients,na.rm = TRUE), simplify = "array")
total_suspected_icu <- sapply(datefactor, function(x) sum(ca_covid_df [ which( ca_covid_df$Most.Recent.Date == x), ]$ICU.COVID.19.Suspected.Patients,na.rm = TRUE), simplify = "array")

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

numeric_df <- data.frame(total_confirmed,daily_confirmed,total_deaths,daily_deaths,total_active_patients,total_active_icu)

pairs(numeric_df)

cor(total_confirmed,total_deaths)
