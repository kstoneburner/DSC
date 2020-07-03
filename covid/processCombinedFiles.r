
## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

### Read CSV 

ca_hospital_df <- read.csv("final_CA_Hospital.csv")
ca_covid_df <- read.csv("final_CA_Confirmed.csv")

dates <- unique(ca_hospital_df$date)
dates

county <- unique(ca_hospital_df$county)

### Combine Hospital and covid data..ugh..PITA!
### Hospital starts later, so we'll toss out the early COVID data :/
### Loop Through the date

for (date_counter in 1:length(dates)){
  
  hospital_date_df <- ca_hospital_df[which(ca_hospital_df$date == dates[date_counter]),]
  covid_date_df <- ca_covid_df[which(ca_covid_df$date == dates[date_counter]),]
  
  covid_county <- unique(covid_date_df$county)
  
  hospital_county <- unique(hospital_date_df$county)
  
  length(hospital_county)
  length(covid_county)
  
  for (i in 1:length(covid_county) ){
    ### Handle Hospital data if county reported    
    if (is.na( match(covid_county[i],hospital_county) ) == FALSE ){
      
      
        
    }
    else {
      ### Build an empty value to append to make dataframe EQUAL
    }
  }
  
  break
  
}###//*** Process Each Date

hospital_county
