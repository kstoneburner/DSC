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

cor(housing_df[2:length(housing_df)])[1,]



lm.beta(salePrice_house_age_lm)


#################################################
### Confidence Intervals
#################################################
### T.test computes High low values from the mean
### 95% of the data lie between these points
### To get the abosolute values, we need to compute the actual Confidence interval values.
### We did this With the computeCI function

t.test(salePrice_base_lm$model)
t.test(salePrice_house_age_lm$model)

############################################
#### 1. Confidence Intervals the Hard way
############################################
# Calculate Standard Error in R 
# using the SD function / SQRT of vector length
### Determine standard error
#se <-  sd(salePrice_house_age_lm$model$Sale.Price) / sqrt(length(salePrice_house_age_lm$model$Sale.Price))

#We'll need these Later - for outliers
price_CI <- computeCI(salePrice_house_age_lm$model$Sale.Price)
sqft_CI <- computeCI(salePrice_house_age_lm$model$square_feet_total_living)
grade_CI <- computeCI(salePrice_house_age_lm$model$building_grade)
bath_CI <- computeCI(salePrice_house_age_lm$model$bath_total)
bedroom_CI <- computeCI(salePrice_house_age_lm$model$bedrooms)
age_CI <- computeCI(salePrice_house_age_lm$model$house_age)

### With the confidence intervals we can calculate for outliers

############################################
#### 2. Analysis of variance
############################################
### anova(linear_model1, linear_model2)
############################################
### Compare linear models to see if there is 
### an improvement of the second model over 
### the first.
############################################
### Looking for an improved (higher) F-Value
############################################
### Discovering Stats Using R p286
############################################
### F ratio..larger better
### F = ssm / SSr - sum squares of the mean, the sum squares of the difference between data and prediction. 
###                 ssr is the sum squares of the residuals!!!
### F = Essentially the mean / error. Bigger is better fit
anova(salePrice_base_lm,salePrice_naieve_lm)
#anova(salePrice_base_lm,square_feet_total_living)
anova(salePrice_base_lm,salePrice_house_age_lm)
anova(salePrice_base_lm,salePrice_year_built_lm)
anova(salePrice_base_lm,salePrice_house_age_lm,salePrice_year_built_lm)
anova(salePrice_base_lm,salePrice_year_built_lm,salePrice_house_age_lm)



#############################################################################
#### 3. Casewise diagnostics - Examine the Large residuals
#############################################################################
#p290. casewise diagnostics
#p290 outliers
#p269 cooks distance & leverage
#p291 covariance.ratio
##### Look for outliers with these tests
#############################################################################

#### rstandard() - Standardized (or studentized residuals). Gives the residual as somethink akin to a zScore.
####               The score is the error in deviations. Anything above a 2 is deemed a large error.
####               Large Residuals > 2 should be less than 5% of the total data
####               Large Residuals > 3 should be less than 2.5% of the total data.

### p292
### Look for Large residuals. any Value greater than two should be flagged as an outlier
large_residuals <- rstandard(salePrice_house_age_lm) > 2 | rstandard(salePrice_house_age_lm) < -2

#### Example of counting the outliers for each variable.
#### Takes large residuals vector, builds a new data frame using specified variables in a c(). 
#### We count values that exceed the range calculated by the confidence interval.

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



##########################################################################################
### 4. Cooks Distance for outliers
### Any value greater than 1 is considered to have outsized influence on the model.
##########################################################################################
#p290. casewise diagnostics
#p290 outliers
#p269 cooks distance & leverage
#p291 covariance.ratio
##### Look for outliers with these tests
casewise_df <- housing_df
casewise_df$cooks.distance <- cooks.distance(salePrice_house_age_lm)
casewise_df$leverage <- hatvalues(salePrice_house_age_lm)
casewise_df$covariance.ratios <- covratio(salePrice_house_age_lm)

#### Shows problematic for cooks
sum(casewise_df$cooks.distance > 1)

##########################################################################################
#### 5. Leverage Test
##########################################################################################
### k+1 / n = average leverage
### k = predictors
### n = Sample size
###########################################################################################
### Trouble cases exceed 2x and 3x the average Leverage

##################################
### Check Leverage for outliers
##################################
### These are troublesome > 0

## k = number of predictors: square_feet_total_living + building_grade + bedrooms + bath_total + house_age
## k = 5 
## average levarage = (k + 1)/n
## n= 12865
k<-5
n <- nrow(casewise_df)

#######################################
###  Calculate the average leverage
#######################################
average_leverage <- (k + 1) / n


#######################################
###  Leverage boundaries are 2x & 3x
#######################################
average_leverage_2x_boundary <- average_leverage *2
average_leverage_3x_boundary <- average_leverage *3

#### Total cases that exceed boundary
sum(casewise_df$leverage > average_leverage_2x_boundary)
sum(casewise_df$leverage > average_leverage_3x_boundary)

#### Percentage of cases that exceed the boundary.
sum(casewise_df$leverage > average_leverage_2x_boundary) / n
sum(casewise_df$leverage > average_leverage_3x_boundary) / n 

#############################################
### 6. Check covariance ratios for outliers
#############################################
### Any values with a covariance 3x average covariance are ouliers
### Any Values of sum indicate outliers
#covariance outliers
#p291
# Reference p270 - Recommendataion is Identifying cases with 3* the average value (average covariance in this case)
upperCov <- 1 + 3*(5 + 1)/12865
lowerCov <- 1 - 3*(5 + 1)/12865

#### Checking if the covariance ratios deviate 3 times from the average leverage
upperCov <- 1 + 3*(k + 1)/n
lowerCov <- 1 - 3*(k + 1)/n

sum(casewise_df$covariance.ratios > upperCov)
sum(casewise_df$covariance.ratios < lowerCov)

#############################################################
### 7. Assessing assumption of indenpendence of error
#############################################################
### DSUR p292
### Using library car
### durbinWatsonTest
### dwt(model)
### Ideal D-W statistic is 2. Closer to 2 the better. 1 or 3 is problematic
library(car) #durbinwatsontest- dwt
dwt(salePrice_house_age_lm)

#####################################################################
#### 8. Assesd the assumption of no multicollinearity using vif()
#####################################################################
#### p292
#### vif(model)       - If largest value > 10 there is cause for concern
#### mean(vif(model)) - If the average VIF is substantially greater than 1, the model may be biased
#### 1/vif(model)     - Tolerance: values below 0.1 indicate serious problems, 0.2 indicate potential problems
#####################################################################

vif(salePrice_house_age_lm)

1/vif(salePrice_house_age_lm)

mean(vif(salePrice_house_age_lm))

#### n. Visually check the assumptions related to the residuals using the plot() and hist() functions. Summarize what each graph is informing you of and if any anomalies are present.
### DSUR 294
### plot(limear_model) - generates a series of plots
plot(salePrice_house_age_lm)
# Plot#1: Shows residuals vs fitted values. The pattern should be fairly random which indicates the assumptions of 
# linearity, randomness and homoscedasticity have been met

#Plot #2: Q-Q Plot: Shows the deviations from normalit. Data that is on the line is normally distributed. Data points off the line line indicate
######## values that are deviated from the the norm. 

#Plot #3: Residuals vs fitted values. plots closer to the line indicate normality. Further the distance indicates outliers

#We can check if the residuals deviate from a normal distribution is inspect a histogram of the residuals.
hist(rstandard(salePrice_house_age_lm))
hist(salePrice_house_age_lm)

#### o. Overall, is this regression model unbiased? If an unbiased regression model, what does this tell us about the sample vs. the entire population model?











