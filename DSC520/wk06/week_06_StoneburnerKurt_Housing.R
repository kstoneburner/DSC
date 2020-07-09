# Assignment: 6.1 - Housing Data
# Name: Stoneburner, Kurt
# Date: 2020-07-06

## Set the working directory to the root of your DSC 520 directory

#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC520\\wk06")
setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")


library(QuantPsyc)
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


##########################################################################################################
#### Build house_age. This is the age of the house at Sale. 
##########################################################################################################
#### Get Year build and coerce into a number
year_built <- as.numeric(raw_housing_df$year_built)

#### Coerce the Date into a Date value and return just the year
sale_year <- format(as.Date(raw_housing_df$Sale.Date, format="%m/%d/%Y"),"%Y")

#### Convert Date (year) into Date (number)
sale_year <- as.numeric(sale_year)

#### The difference between the sale_year and year_built. Is the dwellings age.
house_age <- (sale_year - year_built)

################################################################################################################################
#### There are negative number in house_age. Some sale_dates are listing as sold before the date of building. 
#### I'm going to assume this is a data entry issue. Although there could be an issue where houses were actually sold before
#### they were built. A sampling of the sale dates all reference 2006, with multi-year differences in some cases.
#### I'm treating this as a data entry issue and converting all negative house_age values to 0. 
################################################################################################################################
house_age <- vapply(house_age, function(x){
  if (x < 0 ) { return(0)}
  return(x)
},numeric(1))

housing_df <- cbind(housing_df,house_age)
summary(housing_df)

### b.
### base_lm: Predicts Sale Price based on lot lot size
salePrice_base_lm <-  lm(Sale.Price ~ sq_ft_lot, data=housing_df)
summary(salePrice_base_lm)
salePrice_naieve_lm <-  lm(Sale.Price ~ zip5 + bedrooms + bath_total + square_feet_total_living, data=housing_df)
summary(salePrice_naieve_lm)
salePrice_house_age_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bedrooms + bath_total + house_age, data=housing_df)
summary(salePrice_house_age_lm)
salePrice_year_built_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bedrooms + bath_total + year_built, data=housing_df)
summary(salePrice_year_built_lm)
lm.beta(salePrice_house_age_lm)
lm.beta(salePrice_year_built_lm)

cor(housing_df$year_built,housing_df$house_age)

std_deviation_df <- data.frame ( 
  variable = 
    c("Sale Price", 
      "sqft Living", 
      "Building Grade",
      "bedrooms",
      "bathrooms",
      "house age"),
  std_dev = 
    c( sd(raw_housing_df$Sale.Price),
       sd(housing_df$square_feet_total_living),
       sd(housing_df$building_grade),
       sd(housing_df$bedrooms),
       sd(housing_df$bath_total),
       sd(housing_df$house_age)
)) 
std_deviation_df

############################################
#### Confidence Intervals the Hard way
############################################
##### Start by Calculating Z Scores the hard way
##### zScores <- (dataset - mean(dataset)) / sd(dataset)

# Calculate Standard Error in R 
# using the SD function / SQRT of vector length
## Standard error: Standard Deviation / sqrt(sample size)
##    sd(values) / sqrt(length(values))
##
## lower boundary: mean() minus mini
##      mean(values) - ( min(values) * Standard Error )
##      mean(values) - ( 1.96 * Standard Error )
##
## upper boundary: 
##      mean(values) + ( max(values) * Standard Error )
##      mean(values) + ( 1.96 * Standard Error )

value <- salePrice_house_age_lm$model$Sale.Price

zScores <- (value - mean(value)) / sd(value)
zScores

min(zScores)

### Calculate standard_error for value
standard_error <- sd(value) / sqrt(length(value))

standard_error #3565.217
mean(value) - min(value) * standard_error
t.test(value)
##lower Bound
mean(value) - (1.96*standard_error)
##upper Bound
mean(value) + (1.96 * standard_error)

## c. Execute a summary() function on two variables defined in the previous step to compare the model results. What are the R2 and Adjusted R2 statistics? Explain what these results tell you about the overall model. Did the inclusion of the additional predictors help explain any large variations found in Sale Price?
summary(salePrice_base_lm)
cor(housing_df[2:length(housing_df)])
summary(salePrice_complex_lm)
head(housing_df)

summary(housing_df$Sale.Price)
sd(housing_df$Sale.Price)


cor(num_housing_df)[1,]
head(num_housing_df)

unique(bath_total)

hist(bath_total)
plot(bath_total,housing_df$Sale.Price)
plot(raw_housing_df$bath_full_count,housing_df$Sale.Price)

summary(raw_housing_df$bath_full_count)
summary(bath_total)


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
unique(raw_housing_df$present_use)


present_use_count <- vapply(unique(raw_housing_df$present_use), function(x){
  thisUseVector <- raw_housing_df [ which(raw_housing_df$present_use == x),]
  
  return(nrow(thisUseVector))},numeric(1))




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

