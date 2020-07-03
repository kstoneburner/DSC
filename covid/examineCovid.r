
## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

### Read CSV 

ca_hospital_df <- read.csv("final_CA_Hospital.csv")
ca_covid_df <- read.csv("final_CA_Confirmed.csv")
ca_population_df <- read.csv("final_CA_county_population.csv")
ca_demo_df <- read.csv("Final_CA_Race_Demographic.csv")

### strip first column which duplicates row Index.It's a write.CSV thing
ca_hospital_df   <- ca_hospital_df[,2:length(ca_hospital_df)]
ca_covid_df      <- ca_covid_df[,2:length(ca_covid_df)]
ca_population_df <- ca_population_df[,2:length(ca_population_df)]
ca_demo_df       <- ca_hospital_df[,2:length(ca_demo_df)]

tail(ca_hospital_df)
tail(ca_covid_df)
tail(ca_population_df)
tail(ca_demo_df)

### Split counties into separate groups counties > 2% and less than
counties_by_size_index <- order(ca_population_df$population,decreasing = TRUE)
counties_biggest_index <- counties_by_size_index[1:12] 
counties_smallest_index <-counties_by_size_index[13:length(counties_by_size_index)] 

### Get Names of Biggest counties by population
counties_biggest_names <- sapply(counties_biggest_index, function(x){
  return(ca_population_df$county[x])
},simplify = "array")
counties_biggest_names

### Get Names of Smallest counties by population
counties_smallest_names <- sapply(counties_smallest_index, function(x){
  return(ca_population_df$county[x])
},simplify = "array")
counties_smallest_names


ca_hospital_df$icu_combined < ca_hospital_df$icu_available_beds

la_df <- ca_hospital_df[which(ca_hospital_df$county == "los angeles"),]

unique(ca_hospital_df$date)
unique(ca_covid_df$date)

ca_hospital_df[100,]
ca_covid_df[100,]

ca_hospital_df[1000,]
ca_covid_df[1000,]

tail(ca_hospital_df)
tail(ca_covid_df)

ca_covid_df[which(ca_covid_df$date == "2020-03-29"),]
ca_hospital_df[which(ca_hospital_df$date == "2020-03-29"),]
ca_covid_df[2411,]

dex <- 800
dexDiff <- 2411 - 33

ca_hospital_df[dex,]
ca_covid_df[dex + dexDiff,]

