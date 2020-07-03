## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\DSC\\covid")

#covidRootPath <- "c:\\Users\\newcomb\\DSCProjects\\DSC\\covid\\"
covidRootPath <- "L:\\stonk\\projects\\DSC\\DSC\\covid\\"

caRacePath <- "CA_Demographic.csv"


caRacePath_filePath <- paste(covidRootPath,caRacePath,sep="")
caRacePath_filePath

race_df <- read.csv(caRacePath_filePath)
head(race_df)

##########################################################################################
### Convert NA to 0
##########################################################################################
### Hospital Data Frame - ca_hospital_df
##########################################################################################
for (colCount in 1:length(race_df ) ) {
  
  ### Skip County and Date Columns
  if (colCount < 3) { next}
  
  ### Looping through each column
  ### Unlist converts data_frame list to vector
  thisColumn <- unlist(race_df[colCount])
  
  ### Sapply returns a vector. The function returns 0 if NA, else returns existing value
  new_column <- sapply(thisColumn, function(x){
    if (is.na(x) ) {
      return(0)
    } else { return(x) }
  },simplify="array")
  
  race_df[colCount] <- new_column
  
  
  
}#//END Each Column

##########################################################################################
### convert county to lower case
##########################################################################################
race_df$POPULATION_NAME <- sapply(race_df$POPULATION_NAME, tolower,simplify="array")

##########################################################################################
### convert county to lower case
##########################################################################################

### Keep only Most Recent 2019 values
race_df <- race_df[ which(race_df$FISCAL_YEAR == 2019), ]

### Remove fields with Unknown in the DEMO_GRP
bad_dex <- grep("Unknown",race_df$DEMO_GRP)

race_df <- race_df[-bad_dex,]

### Remove extraneous fields
race_df <- data.frame(race_df$POPULATION_NAME,race_df$DEMO_GRP,race_df$TOTAL_CT,race_df$SMHS1_CT,race_df$SMHS5_CT)
colnames(race_df) <- c("county","Demographic","Total_CT","SMHS1_CT","SMHS5_CT") 
head(race_df)
write.csv(race_df,"Final_CA_Race_Demographic.csv")
