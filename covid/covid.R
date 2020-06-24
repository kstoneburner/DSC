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

temp_count <- ca_covid_df [ which( ca_covid_df$County.Name == "Alameda"), ]
temp_count <- temp_count$Total.Count.Confirmed
temp_count

### Build a list of Unique Dates
date <- unique(ca_covid_df$Most.Recent.Date)

county <- unique(ca_covid_df$County.Name)

county_df <- data.frame(date)
county_df

length(date)
length(county)

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
  county_df[name] <- temp_count
}


head(county_df)

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
ggplot(data=county_df, aes(x=date, group=1)) +
    geom_line(aes(y=Los_Angeles, color = "Los_Angeles" ) ) +
    geom_line(aes(y=San_Francisco, color = "San_Francisco" ) ) +
    geom_line(aes(y=Alameda, color = "Alameda" ) ) 

column_names <- names(county_df)[2:(ncol(county_df))]




command <- "ggplot(data=county_df, aes(x=date)) +"
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
command <- paste(command,"+ scale_colour_manual('',labels=column_names,breaks=column_names,values=col_vector) + theme_dark()  + theme( panel.background = element_rect(fill = 'black') )")
 
  
print(command)
eval(parse(text=command))

library(RColorBrewer)
n <- 60
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
pie(rep(1,n), col=sample(col_vector, n))
col_vector
?scale_color_distiller
