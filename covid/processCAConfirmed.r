##########################################################################################################################
##########################################################################################################################
### Source: California COVID-19 page
###         https://data.ca.gov/group/covid-19
###         Data Dictionary Located on this page
###
### Data Page: https://data.ca.gov/dataset/covid-19-hospital-data
##########################################################################################################################
##########################################################################################################################
### Process the current California Confirmed COVID numbers and export to final_CA_Confirmed.csv
##########################################################################################################################
##########################################################################################################################
### Look at calculating accurate infection dates
### Add Phased reopening data and correlate subsequent infections hospitalizations and deaths. Correlate

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

#covidRootPath <- "c:\\Users\\newcomb\\DSCProjects\\DSC\\covid\\"
covidRootPath <- "L:\\stonk\\projects\\DSC\\DSC\\covid\\"
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





caCovidConfirmedPath <- "CA_covid_Cases.csv"

caCovidConfirmedPath_filePath <- paste(covidRootPath,caCovidConfirmedPath,sep="")
caCovidConfirmedPath_filePath

ca_confirmed_df <- read.csv(caCovidConfirmedPath_filePath)
head(ca_confirmed_df)
tail(ca_confirmed_df)

### Convert Date to a Date object
#ca_hospital_df$todays_date <- as.Date(ca_hospital_df$todays_date,"%y/%d/%m")
ca_confirmed_df$date <- as.Date(ca_confirmed_df$date,"%Y-%m-%d")
tail(ca_confirmed_df)

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


head(ca_confirmed_df)
tail(ca_confirmed_df)

#ca_confirmed_df = as.matrix(ca_confirmed_df)

class(ca_confirmed_df$county)
class(ca_confirmed_df$date)

write.csv(ca_confirmed_df,"final_CA_Confirmed.csv")

