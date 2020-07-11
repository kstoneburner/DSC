# Assignment: 6.1 - Housing Data
# Name: Stoneburner, Kurt
# Date: 2020-07-06

## Set the working directory to the root of your DSC 520 directory

setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\DSC520\\wk06")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")


library(QuantPsyc)
library(readxl)
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
    
    ### Replace blank spaces with periods
    #thisColName <- gsub(" ",".",thisColName) 
    
    #?gsub
    
    
    output_df <- cbind(output_df, input_df[thisColName])
    
  }### END Each New Column Name

  return(output_df)
  
}### END RemoveColsFromDF

computeCI <- function(input_data){
  ##############################################
  #### Compute Confidence Intervals 
  ##############################################
  #### The best way to learn it is to do it!
  #### Calculation confirmed with t.test()
  ##############################################
  # Calculate Standard Error in R 
  # Standard Deviation divided by the sqrt of the sample size
  # using the sd (input_data) / sqrt(length(input_data))
  ### Determine standard error
  
  se <- sd(input_data) / sqrt(length(input_data))
  thisMean <- mean(input_data)
  ##############################################################################
  ### The boundaries are a function of the standard error and 95% of zScores lie
  ### between -1.96 and 1.96
  ##############################################################################
  lowerBoundary <- thisMean - (1.96 * se)
  upperBoundary <- thisMean + (1.96 * se)
  
  return (data.frame(
    
    lowerBoundary = lowerBoundary,
    mean = thisMean,
    upperBoundary = upperBoundary,
    lowerValue = (thisMean - lowerBoundary),
    upperValue = (thisMean + upperBoundary)
    
  ))
}


## Load the housing data
#raw_housing_df <- read.csv("week-7-housing.csv")
raw_housing_df <- read_excel("week-6-housing.xlsx")


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

#####################################################
### Convert spaces to periods in column names
#####################################################
thisNames <- colnames(housing_df)
colnames(housing_df) <- gsub(" ",".",thisNames)

thisNames <- colnames(raw_housing_df)
colnames(raw_housing_df) <- gsub(" ",".",thisNames)
head(raw_housing_df)

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
salePrice_living_lm <- lm(Sale.Price ~ square_feet_total_living, data=housing_df)
summary(salePrice_living_lm)
salePrice_naieve_lm <-  lm(Sale.Price ~ zip5 + bedrooms + bath_total + square_feet_total_living, data=housing_df)
summary(salePrice_naieve_lm)
salePrice_house_age_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bedrooms + bath_total + house_age, data=housing_df)
summary(salePrice_house_age_lm)
salePrice_year_built_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade + bedrooms + bath_total + year_built, data=housing_df)



summary(salePrice_year_built_lm)
lm.beta(salePrice_house_age_lm)
lm.beta(salePrice_year_built_lm)
summary(salePrice_base_lm)
summary(salePrice_naieve_lm)


t.test(housing_df$Sale.Price)
t.test(housing_df$building_grade)
t.test(housing_df$square_feet_total_living)
t.test(housing_df$bedrooms)
t.test(housing_df$bath_total)
t.test(housing_df$house_age)
t.test(housing_df$year_built)

t.test(salePrice_base_lm$model)
t.test(salePrice_naieve_lm$model)
t.test(salePrice_house_age_lm$model)
t.test(salePrice_house_age_lm$model$Sale.Price)
salePrice_house_age_lm$model

mean(salePrice_house_age_lm$model$Sale.Price)
max(salePrice_house_age_lm$model$Sale.Price)
min(salePrice_house_age_lm$model$Sale.Price)

############################################
#### Confidence Intervals the Hard way
############################################
# Calculate Standard Error in R 
# using the SD function / SQRT of vector length
### Determine standard error
se <-  sd(salePrice_house_age_lm$model$Sale.Price) / sqrt(length(salePrice_house_age_lm$model$Sale.Price))
mean(salePrice_house_age_lm$model$Sale.Price) - (1.96 * se)
mean(salePrice_house_age_lm$model$Sale.Price) + (1.96 * se)
t.test(salePrice_house_age_lm$model$Sale.Price)


#We'll need these Later - for outliers
price_CI <- computeCI(salePrice_house_age_lm$model$Sale.Price)
sqft_CI <- computeCI(salePrice_house_age_lm$model$square_feet_total_living)
grade_CI <- computeCI(salePrice_house_age_lm$model$building_grade)
bath_CI <- computeCI(salePrice_house_age_lm$model$bath_total)
bedroom_CI <- computeCI(salePrice_house_age_lm$model$bedrooms)
age_CI <- computeCI(salePrice_house_age_lm$model$house_age)

t.test(salePrice_house_age_lm$model)

salePrice_house_age_lm$model

salePrice_house_age_lm$model$house_age



anova(salePrice_base_lm,salePrice_naieve_lm)
#anova(salePrice_base_lm,square_feet_total_living)
anova(salePrice_base_lm,salePrice_house_age_lm)
anova(salePrice_base_lm,salePrice_year_built_lm)
anova(salePrice_base_lm,salePrice_house_age_lm,salePrice_year_built_lm)
anova(salePrice_base_lm,salePrice_year_built_lm,salePrice_house_age_lm)

cor(housing_df)[1,]

salePrice_improved_lm <-    lm(Sale.Price ~ square_feet_total_living + building_grade  + house_age, data=housing_df)
anova(salePrice_base_lm,salePrice_improved_lm)


anova(salePrice_base_lm,salePrice_house_age_lm)
anova(salePrice_base_lm,salePrice_year_built_lm)
resid(salePrice_house_age_lm)
large_residuals

case[large_residuals]

rstudent(salePrice_house_age_lm)

cooks.distance(salePrice_house_age_lm)
dfbeta(salePrice_house_age_lm)
dffits(salePrice_house_age_lm)

#### g. Perform casewise diagnostics to identify outliers and/or influential cases, storing each function's output in a dataframe assigned to a unique variable name.
#p290. casewise diagnostics
#p290 outliers
#p269 cooks distance & leverage
#p291 covariance.ratio
##### Look for outliers with these tests
casewise_df <- housing_df
casewise_df$cooks.distance <- cooks.distance(salePrice_house_age_lm)
casewise_dfl$leverage <- hatvalues(salePrice_house_age_lm)
casewise_df$covariance.ratios <- covratio(salePrice_house_age_lm)

casewise_df

###Cooks Distance test.
### Any value greater than is considered to have outsized influence on the model.

### p292
### I think this is out casewise diagnostic
### Look for Large residuals. any Value greater than two should be flagged as an outlier
large_residuals <- rstandard(salePrice_house_age_lm) > 2 | rstandard(salePrice_house_age_lm) < -2

### Get a count of Large residuals
sum(large_residuals)

head(housing_df)


large_residuals_df <- housing_df[large_residuals,c("Sale.Price","building_grade","square_feet_total_living","bedrooms","bath_total","house_age")]
large_residuals_df

sales_count_low <- nrow(large_residuals_df[which(large_residuals_df$Sale.Price < price_CI$lowerValue),])
sales_count_high <- nrow(large_residuals_df[which(large_residuals_df$Sale.Price > price_CI$upperValue),])

sqft_count_low <- nrow(large_residuals_df[which(large_residuals_df$square_feet_total_living < sqft_CI$lowerValue),])
sqft_count_high <- nrow(large_residuals_df[which(large_residuals_df$square_feet_total_living > sqft_CI$upperValue),])

bg_count_low <- nrow(large_residuals_df[which(large_residuals_df$building_grade < grade_CI$lowerValue),])
bg_count_high <- nrow(large_residuals_df[which(large_residuals_df$building_grade > grade_CI$upperValue),])

bath_count_low <- nrow(large_residuals_df[which(large_residuals_df$bath_total < bath_CI$lowerValue),])
bath_count_high <- nrow(large_residuals_df[which(large_residuals_df$bath_total > bath_CI$upperValue),])

bed_count_low <- nrow(large_residuals_df[which(large_residuals_df$bedrooms < bedroom_CI$lowerValue),])
bed_count_high <- nrow(large_residuals_df[which(large_residuals_df$bedrooms > bedroom_CI$upperValue),])

age_count_low <- nrow(large_residuals_df[which(large_residuals_df$house_age < age_CI$lowerValue),])
age_count_high <- nrow(large_residuals_df[which(large_residuals_df$house_age > age_CI$upperValue),])

#large_residuals_df[which(large_residuals_df$house_age < age_CI$lowerValue),]


print(paste0("Sales.Price - ",(sales_count_low + sales_count_high), " Total outliers"))
print(paste0("              ", sales_count_low, " contain values less than ",round(price_CI$lowerValue,0) ) )
print(paste0("              ", sales_count_high, " contain values more than ",round(price_CI$upperValue,0) ) ) 

print(paste0("Building Grade - ",(bg_count_low + bg_count_high), " Total outliers"))

print(paste0("Square Foot Living - ",(sqft_count_low + sqft_count_high), " Total outliers"))
print(paste0("              ", sqft_count_high, " contain values more than ",round(sqft_CI$upperValue,0) ) ) 

print(paste0("Bedrooms - ",(bed_count_low + bed_count_high), " Total outliers"))
print(paste0("              ", bed_count_low, " contain values less than ",round(bedroom_CI$lowerValue,2) ) )
print(paste0("              ", bed_count_high, " contain values more than ",round(bedroom_CI$upperValue,0) ) ) 

print(paste0("Bathrooms - ",(bath_count_low + bath_count_high), " Total outliers"))
print(paste0("              ", bath_count_low, " contain values less than ",round(bath_CI$lowerValue,2) ) )
print(paste0("              ", bath_count_high, " contain values more than ",round(bath_CI$upperValue,0) ) ) 

print(paste0("House Age - ",(age_count_low + age_count_high), " Total outliers"))
print(paste0("              ", age_count_low, " contain values less than ",round(age_CI$lowerValue,2) ) )
print(paste0("              ", age_count_high, " contain values more than ",round(age_CI$upperValue,0) ) ) 

?rstandard


salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("cooks.distance","leverage","covariance.ratios")]
### Check for outliers
sum( salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("cooks.distance") ] > 1 )
##################################
### Check Leverage for outliers
##################################
### These are troublesome > 0
sum( salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("leverage") ] > average_leverage_2x_boundary )
### These are outliers > )
sum( salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("leverage") ] > average_leverage_3x_boundary )


#salePrice_base_lm$standardized.residuals <- rstandard(salePrice_house_age_lm) 
#salePrice_base_lm$studentized.residuals <- rstudent(salePrice_house_age_lm)
#salePrice_base_lm$cooks.distance <- cooks.distance(salePrice_house_age_lm)
#salePrice_base_lm$dfbeta <- dfbeta(salePrice_house_age_lm)
#salePrice_base_lm$dffit <- dffits(salePrice_house_age_lm)
#salePrice_base_lm$leverage <- hatvalues(salePrice_house_age_lm)
#salePrice_base_lm$covariance.ratios <- covratio(salePrice_house_age_lm)


#salePrice_house_age_lm
salePrice_house_age_lm$model$standardized.residuals <- rstandard(salePrice_house_age_lm) 
salePrice_house_age_lm$model$studentized.residuals <- rstudent(salePrice_house_age_lm)
salePrice_house_age_lm$model$cooks.distance <- cooks.distance(salePrice_house_age_lm)
salePrice_house_age_lm$model$dfbeta <- dfbeta(salePrice_house_age_lm)
salePrice_house_age_lm$model$dffit <- dffits(salePrice_house_age_lm)
salePrice_house_age_lm$model$leverage <- hatvalues(salePrice_house_age_lm)
salePrice_house_age_lm$model$covariance.ratios <- covratio(salePrice_house_age_lm)





## k = number of predictors: square_feet_total_living + building_grade + bedrooms + bath_total + house_age
## k= 5 
## average levarage = (k + 1)/n
## n= 12865
#covariance outliers
#p291
# Reference p270 - Recommendataion is Identifying cases with 3* the average value (average covariance in this case)
upperCov <- 1 + 3*(5 + 1)/12865
lowerCov <- 1 - 3*(5 + 1)/12865
k<-5
n <- nrow(housing_df)
upperCov <- 1 + 3*(k + 1)/n
lowerCov <- 1 - 3*(k + 1)/n
###########################################
### Check covariance ratios for outliers
###########################################
### Any Values of sum indicate outliers
sum(salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("covariance.ratios") ] > upperCov)
sum(salePrice_house_age_lm$model[salePrice_base_lm$model$large_residuals, c("covariance.ratios") ] < lowerCov)
sum(salePrice_house_age_lm$model$covariance.ratios > upperCov) + sum(salePrice_house_age_lm$model$covariance.ratios < lowerCov)


### Any values with a covariance 3x average covariance are ouliers

###Cooks Distance test.
### Any value greater than is considered an outlier

### levarage test
### k+1 / n = average leverage
average_leverage <- (k + 1) / n

average_leverage

average_leverage_2x_boundary <- average_leverage *2
average_leverage_3x_boundary <- average_leverage *3

average_leverage_2x_boundary

housing_df[housing_df$large_residuals,c("cooks.distance","leverage","covariance.ratios")]



salePrice_base_lm$large_residuals

large_residuals

##i.
sum(large_residuals)

housing_df[large_residuals,c('cooks.distance')] 
housing_df[large_residuals,c('covariance.ratios')] 
housing_df[large_residuals,c('leverage')] > average_leverage_2x_boundary

housing_df[large_residuals,c('leverage')] > average_leverage_2x_boundary






housing_df[large_residuals,c('covariance.ratios')] > upperCov | housing_df[large_residuals,c('covariance.ratios')] < lowerCov


### Should be about 1% - this model is 1.95% - Could be high
sum(salePrice_house_age_lm$standardized.residuals > 2.5 | salePrice_house_age_lm$standardized.residuals < -2.5) / nrow(salePrice_base_lm$model)
salePrice_house_age_lm$standardized.residuals > 2.5 | salePrice_house_age_lm$standardized.residuals < -2.5 

### Anything above 3 represents outliers that affect the model
sum(salePrice_base_lm$standardized.residuals > 3 | salePrice_base_lm$standardized.residuals < -3 ) / nrow(salePrice_base_lm$model)

rstandard(salePrice_house_age_lm$model$square_feet_total_living)

sum(salePrice_house_age_lm$model$square_feet_total_living > 2 | salePrice_house_age_lm$model$square_feet_total_living < -2)
sum(salePrice_house_age_lm$model$Sales.Price < 2 | salePrice_house_age_lm$model$Sales.Price < 2)
sum(salePrice_house_age_lm$model$bath_total < 2 | salePrice_house_age_lm$model$bath_total < 2)



str(salePrice_base_lm)

sum(housing_df[housing_df$large_residuals,c("standardized.residuals")])

sum(housing_df$large_residuals) /nrow(housing_df)

### Displays outliers with large residuals > 2
housing_df[housing_df$large_residuals,c("Sale.Price","square_feet_total_living","building_grade","bedrooms","bath_total","house_age")]
housing_df[housing_df$large_residuals,c("cooks.distance","leverage","covariance.ratios")]


salePrice_house_age_lm$model[salePrice_base_lm$large_residuals, c("cooks.distance","leverage","covariance.ratios")]

#salePrice_house_age_lm[ salePrice_house_age_lm$large_residuals [c("cooks.distance","leverage","covariance.ratios")]

#salePrice_house_age_lm$large_residuals

#salePrice_house_age_lm[1,]

#head(salePrice_house_age_lm)









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

tail(housing_df)


cor(num_housing_df)[1,]
head(num_housing_df)

### F ratio..larger better
### F = ssm / SSr - sum squares of the mean, the sum squares of the difference between data and prediction. 
###                 ssr is the sum squares of the residuals!!!
### F = Essentially the mean / error. Bigger is better fit

### Write Down something for T scores and Zscores.

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

