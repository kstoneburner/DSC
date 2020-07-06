# Assignment: 6.1 - Housing Data
# Name: Stoneburner, Kurt
# Date: 2020-07-06
removeColsFromDF <- function(input_df, removeCols){
  ###########################################################################
  ### Remove Columns from a a data frame the Hard Way!
  ### I don't like the clever answers from the Internet that I don't quite
  ### Understand.
  ###########################################################################
  ### Purpose: Return a data frame without the columns listed in removeCols
  ###########################################################################
  ### Variables #############################################################
  ###########################################################################
  ### input_df: Data Frame that needs columns removed
  ### removeCols: Vector of columns names as strings to be removed:
  ###             Example: c("date","Location","col1","col2")
  ###########################################################################
  
  
  ### Build a new vector of names by excluding values in removeCols
  newColNames <- lapply(colnames(input_df), function(x){
    
    
    if ( (x %in% removeCols) == FALSE) {return(x)}
    
  })
  
  ### Initialize output data frame with the first column from input. 
  ### This allows us to cbind in the loop. The first column will be
  ### removed later
  output_df = data.frame(input_df[1])
  
  ### Build output data frame by adding in columns from newColNames
  ### For each new column name
  for (i in 1:length(newColNames)){
    
    ########################################################################################
    ### Build column name
    ########################################################################################
    ### Not exactly sure why I need to unlist.
    ### probably should use a different function from lapply. Maybe capply? But this works
    ########################################################################################
    thisColName <- unlist(newColNames[i])
    
    output_df <- cbind(output_df,input_df[thisColName])
    
  }### END Each New Column Name
  
  return(output_df)
  
}### END RemoveColsFromDF
## Set the working directory to the root of your DSC 520 directory

setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC520\\wk06")
#setwd("L:\\stonk\\projects\\DSC\\520")

## Load the housing data
raw_housing_df <- read.csv("week-7-housing.csv")






housing_df <- removeColsFromDF(raw_housing_df,c("lon","lat","addr_full","ctyname","postalctyn","prop_type"))
head(housing_df)

unique(raw_housing_df$sitetype)
unique(raw_housing_df$current_zoning)
unique(raw_housing_df$year_renovated)
unique(raw_housing_df$sale_reason)
unique(raw_housing_df$building_grade)
unique(raw_housing_df$present_use)
unique(raw_housing_df$sale_warning)
unique(raw_housing_df$sale_instrument)
unique(raw_housing_df$present_use)
hist(raw_housing_df$present_use)
unique(raw_housing_df$present_use)

present_use_count <- vapply(unique(raw_housing_df$present_use), function(x){
  thisUseVector <- raw_housing_df [ which(raw_housing_df$present_use == x),]
  
  return(nrow(thisUseVector))},numeric(1))
present_use_count

11931 / nrow(raw_housing_df)


length(unique(raw_housing_df$current_zoning))
current_zoning_count <- vapply(unique(raw_housing_df$current_zoning), function(x){
  thisUseVector <- raw_housing_df [ which(raw_housing_df$current_zoning == x),]
  
  return(nrow(thisUseVector))},numeric(1))

current_zoning_count

## Convert current_zoning into a numeric value.
## Build a number vector based on the unique values in current_zoning
zoning_zones <- unique(raw_housing_df$current_zoning)

### Return the index Value from zoning_zones

coded_zoning <- vapply(raw_housing_df$current_zoning, function(x){
  thisIndex <- match(x,zoning_zones)
  return(thisIndex)},numeric(1))

coded_zoning

hist(coded_zoning)
hist(raw_housing_df$present_use)

cor(coded_zoning,raw_housing_df$present_use)
