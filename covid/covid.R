### Look at calculating accurate infection dates
### Add Phased reopening data and correlate subsequent infections hospitalizations and deaths. Correlate

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


ca_covid_df$Total.Count.Deaths

la_df <- ca_covid_df [ which( ca_covid_df$County.Name == "Los Angeles"), ]

sf_df <- ca_covid_df [ which( ca_covid_df$County.Name == "San Francisco"), ]
sf_df
alameda_df <- ca_covid_df [ which( ca_covid_df$County.Name == "Alameda"), ]
alameda_df

temp_count <- ca_covid_df [ which( ca_covid_df$County.Name == "Alameda"), ]
temp_count <- temp_count$Total.Count.Confirmed
temp_count

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

