# Assignment: ASSIGNMENT 7
# Name: Stoneburner, Kurt
# Date: 2020-07-06

## Set the working directory to the root of your DSC 520 directory
setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
#setwd("L:\\stonk\\projects\\DSC\\dsc520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")
head(heights_df)
str(heights_df)
# Fit a linear model
earn_lm <-  lm(earn ~ height + sex + ed + age + race, data=heights_df)

# View the summary of your model
summary(earn_lm)

predicted_df <- data.frame(
  earn = predict(earn_lm, newdata=heights_df),
  ed=heights_df$ed, race=heights_df$race, height=heights_df$height,
  age=heights_df$age, sex=heights_df$sex
  )

## Compute deviation (i.e. residuals)
mean_earn <- mean(heights_df$earn)
mean_earn
## Corrected Sum of Squares Total
## mean_earn - each value of earn (measures the distance from the mean, which
## is the expected value). The difference is squared (to eliminate negatives canceling out positives).
## The differences for each data point are added.
## A Large value represents a large error, or many points are distant from the mean
## sst - Represents the data difference from the mean
## sst - Sum of Squares - Total
sst <- sum((mean_earn - heights_df$earn)^2)

## Corrected Sum of Squares for Model
## Calculate Sum of the Squares for the prediction model. Greater the number, the greater the error.
## This is the difference between the mean of the data set and the predicted value, 
## squared to avoid positives and negates canceling each other out. Calculating the total distance from the 
## mean (which is the expected value).
## ssm - represents the predicted difference from the mean
## ssm / sst - The closer to 1 the better - this is r_squared
ssm <- sum((mean_earn - predicted_df$earn)^2)


## Residuals
## The difference between the data and the predicted model. For each data point
residuals <- heights_df$earn - predicted_df$earn


## Sum of Squares for Error
## This is the error or difference between the data point and the prediction. This number is large.
## And similar to sst. If the Error of the model is similar to the error of the mean. The model isn't much
## better. 
sse <- sum(residuals^2)


## R Squared
## R Squared R^2 = SSM/SST
## Error of the mean / Error of the Prediction. This is the correlation coefficient of the model. 
## Small numbers have less significance. Closer to 1 the stronger the correlation.
## This value is small, the model is not a good fit for the data compared to the mean.
r_squared <- ssm/sst
r_squared
r <- sqrt(r_squared)
r

## Number of observations
n <- nrow(heights_df)

## Number of regression parameters
## Question: Why is the number of regression parameters 8? Why is this significant?
p <- 8

## Corrected Degrees of Freedom for Model (p-1)
## Question: What are Degrees of Freedom for model?
## According to Wikipedia: https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)
## "The number of independent pieces of information that go into the estimate of a parameter are called the 
## degrees of freedom. In general, the degrees of freedom of an estimate of a parameter are equal to the number 
## of independent scores that go into the estimate minus the number of parameters used as intermediate steps in
## the estimation of the parameter itself (most of the time the sample variance has N ??? 1 degrees of freedom, 
## since it is computed from N random scores minus the only 1 parameter estimated as intermediate step, 
## which is the sample mean)."
dfm <- p - 1

## Degrees of Freedom for Error (n-p)
## Not sure why the error is (sample size - regression parameters)

dfe <- n-p

## Corrected Degrees of Freedom Total:   DFT = n - 1
## Again Wikipedia: https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)
## "The sum of the residuals (unlike the sum of the errors) is necessarily 0. 
## If one knows the values of any n ??? 1 of the residuals, one can thus find the last one. 
## That means they are constrained to lie in a space of dimension n ??? 1. 
## One says that there are n ??? 1 degrees of freedom for errors"
dft <- n-1

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm/dfm

## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse / dfe

## Mean of Squares Total:   MST = SST / DFT
mst <- sst / dft

## F Statistic - F = MSM/MSE
f_score <- msm/mse

## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
adjusted_r_squared <- 1 - (1 - r_squared) * dft / dfe

## These values match the summary(earn_lm)
summary(earn_lm)
