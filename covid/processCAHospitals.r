##########################################################################################################################
##########################################################################################################################
### Source: California COVID-19 page
###         https://data.ca.gov/group/covid-19
###         Data Dictionary Located on this page
###
### Data Page: https://data.ca.gov/dataset/covid-19-hospital-data
##########################################################################################################################
##########################################################################################################################
### Look at calculating accurate infection dates
### Add Phased reopening data and correlate subsequent infections hospitalizations and deaths. Correlate


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
setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

covidRootPath <- "c:\\Users\\newcomb\\DSCProjects\\DSC\\covid\\"
#covidRootPath <- "L:\\stonk\\projects\\DSC\\DSC\\covid\\"

caCovidHospitalizationPath <- "CA_covid_Hospitalization.csv"
#cdcDeathsPath <- "cdcMortality.csv"

ca_covid_hospitalization_filePath <- paste(covidRootPath,caCovidHospitalizationPath,sep="")
ca_covid_hospitalization_filePath

ca_hospital_df <- read.csv(ca_covid_hospitalization_filePath)
head(ca_hospital_df)

### Convert Date to a Date object
#ca_hospital_df$todays_date <- as.Date(ca_hospital_df$todays_date,"%y/%d/%m")
ca_hospital_df$todays_date <- as.Date(ca_hospital_df$todays_date,"%Y-%m-%d")
head(ca_hospital_df)

### Get Date Column name
dateCol <- colnames(ca_hospital_df[2])
dateCol

### Get county Column name
countyCol <- colnames(ca_hospital_df[1])
countyCol

hospitalCol <-colnames(ca_hospital_df)
head(ca_hospital_df)
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


head(ca_hospital_df)
tail(ca_hospital_df)
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

#Calculations
icu_capacity <- ca_hospital_df$icu_available_beds - ca_hospital_df$icu_combined

hospital_capactity <- ca_hospital_df$all_hospital_beds - ca_hospital_df$hospitalized_covid_patients 

ca_hospital_df <- cbind(ca_hospital_df,hospital_capactity)
ca_hospital_df <- cbind(ca_hospital_df,icu_capacity)

tail(ca_hospital_df)

ca_hospital_df = as.matrix(ca_hospital_df)



write.csv(ca_hospital_df,"final_CA_Hospital.csv")

