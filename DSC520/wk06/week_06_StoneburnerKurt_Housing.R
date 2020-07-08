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

#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC520\\wk06")
setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")


## Load the housing data
raw_housing_df <- read.csv("week-7-housing.csv")

## Remove the double date first column from CSV
#raw_housing_df <- raw_housing_df[2:length(colnames(raw_housing_df))]

head(raw_housing_df)
housing_df <- removeColsFromDF(raw_housing_df,c("lon",
                                                "lat",
                                                "addr_full",
                                                "ctyname",
                                                "postalctyn",
                                                "prop_type",
                                                "year_renovated",
                                                "current_zoning",
                                                "bath_full_count",
                                                "bath_half_count",
                                                "bath_3qtr_count",
                                                "present_use"))[,-1]

housing_df <- removeColsFromDF(raw_housing_df,c("lon",
                                                "lat",
                                                "addr_full",
                                                "ctyname",
                                                "postalctyn",
                                                "prop_type",
                                                "year_renovated",
                                                "current_zoning",
                                                "bath_full_count",
                                                "bath_half_count",
                                                "bath_3qtr_count",
                                                "sitetype",
                                                "sale_warning",
                                                "present_use",
                                                "sale_reason",
                                                "sale_instrument",
                                                "Sale.Date"))[,-1]

#### Combine the bathrooms
bath_total <- raw_housing_df$bath_full_count + (raw_housing_df$bath_half_count *.5) + (raw_housing_df$bath_3qtr_count *.75)

housing_df <- cbind(housing_df,bath_total)
tail(housing_df)

cor(housing_df)[1,]

### Calculate the age of the house (Sale Date - sale_year)
cor(housing_df)[1,]


### b.
### base_lm: Predicts Sale Price based on lot lot size
salePrice_base_lm <-  lm(Sale.Price ~ sq_ft_lot, data=housing_df)
summary(salePrice_base_lm)
salePrice_naieve_lm <-  lm(Sale.Price ~ zip5 + bedrooms + bath_total + square_feet_total_living, data=housing_df)
summary(salePrice_naieve_lm)
salePrice_complex_4_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bath_total, data=housing_df)
summary(salePrice_complex_4_lm)
salePrice_complex_6_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bedrooms + bath_total + year_built, data=housing_df)
summary(salePrice_complex_6_lm)

hist(housing_df$year_built)
hist(housing_df$house_age)
cor(housing_df$year_built,housing_df$house_age)

## c. Execute a summary() function on two variables defined in the previous step to compare the model results. What are the R2 and Adjusted R2 statistics? Explain what these results tell you about the overall model. Did the inclusion of the additional predictors help explain any large variations found in Sale Price?
summary(salePrice_base_lm)
cor(housing_df[2:length(housing_df)])
summary(salePrice_complex_lm)
head(housing_df)

cor(num_housing_df)[1,]
head(num_housing_df)

unique(bath_total)

hist(bath_total)
plot(bath_total,housing_df$Sale.Price)
plot(raw_housing_df$bath_full_count,housing_df$Sale.Price)

summary(raw_housing_df$bath_full_count)
summary(bath_total)

iqr_dumper_df <- housing_df[which(housing_df$bath_total <= 5),]
iqr_dumper_df <- iqr_dumper_df[which(iqr_dumper_df$bath_total > 1),]
nrow(iqr_dumper_df)
cor(iqr_dumper_df)[1,]
plot(iqr_dumper_df$bath_total,iqr_dumper_df$Sale.Price)
housing_df$Sale.Date <-  as.Date(housing_df$Sale.Date,  tryFormats = c("%m/%d/%Y") )
sale_year
housing_df <- cbind(housing_df,sale_year)
housing_df <- cbind(housing_df,year_built)



housing_df$year_built

housing_df[ which(housing_df$sale_year < housing_df$year_built),]

raw_housing_df[136,]

housing_df$Sale.Date

head(housing_df)
str(housing_df)
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

cor(cbind(housing_df,coded_zoning))[1,]
tail(housing_df)
hist(coded_zoning)
hist(raw_housing_df$present_use)

cor(coded_zoning,raw_housing_df$present_use)

year_built <- as.numeric(raw_housing_df$year_built)
year_built
raw_housing_df$Sale.Date
sale_year <- format(as.Date(raw_housing_df$Sale.Date, format="%m/%d/%Y"),"%Y")
sale_year
sale_year <- as.numeric(sale_year)
sale_year
house_age <- (sale_year - year_built)

house_age

house_age <- vapply(house_age, function(x){
  if (x < 0 ) { return(0)}
  return(x)
},numeric(1))

cor(housing_df)[1,]
housing_df <- cbind(housing_df,house_age)
