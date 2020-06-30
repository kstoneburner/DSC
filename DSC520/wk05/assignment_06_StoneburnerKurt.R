# Assignment: ASSIGNMENT 6
# Name: Stoneburner, Kurt
# Date: 2020-06-29

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
setwd("L:\\stonk\\projects\\DSC\\dsc520")

## Load the `data/r4ds/heights.csv` to
heights_df <- read.csv("data/r4ds/heights.csv")
head(heights_df)
## Load the ggplot2 library
library(ggplot2)



## Fit a linear model using the `age` variable as the predictor and `earn` as the outcome
age_lm <-  lm(earn ~ age, data=heights_df)

## View the summary of your model using `summary()`
summary(age_lm)

## Creating predictions using `predict()`
age_predict_df <- data.frame(earn = predict(age_lm, newdata=heights_df), age=heights_df$age)

head(age_predict_df)    ## remove
summary(age_predict_df) ## Remove

## Plot the predictions against the original data
ggplot(data = heights_df, aes(y = earn, x = age)) +
  geom_point(color='blue') +
  geom_line(color='red',data = age_predict_df, aes(y=earn, x=age))

mean_earn <- mean(heights_df$earn)

## Corrected Sum of Squares Total
## mean_earn - each value of earn (measures the distance from the mean, which
## is the expected value). The difference is squared (two eliminate negatives canceling out positives).
## The differences for each data point are added.
## A Large value represents a large error, or many points are distant from the mean
sst <- sum((mean_earn - heights_df$earn)^2)

## Corrected Sum of Squares for Model
## Calculate Sum of the Squares for the prediction model. Error increases with the error
ssm <- sum((mean_earn - age_predict_df$earn)^2)

## Since ssm < sst i'm predicting ssm has significance. I would be wrong.

## Residuals
## Difference between the data and the model.
residuals <- heights_df$earn - age_predict_df$earn

## Sum of Squares for Error
## This is the error or difference between the data point and the presidiction. This number is large.
## And similar to sst. If the Error of the model is similar to the error of the mean. The model isn't much
## better. sst / sse is close to 1. Not sure if this is significant.
sse <- sum(residuals^2)


## R Squared R^2 = SSM/SST
## Error of the mean / Error of the Prediction. This is the correlation coefficient of the model. 
## Small numbers have less significance. Closer to 1 the stronger the correlation.
## This value is small, the model is not a good fit for the data compared to the mean.
## Judging by the scatterplot, this makes sense.
r_squared <- ssm / sst


## Number of observations
## method: str(heights_df)
n <- 1192
## Number of regression parameters
p <- 2
## Corrected Degrees of Freedom for Model (p-1)
dfm <- p-1
## Degrees of Freedom for Error (n-p)
dfe <- n-p
## Corrected Degrees of Freedom Total:   DFT = n - 1
dft <- n-1

## Mean of Squares for Model:   MSM = SSM / DFM
msm <- ssm / dfm

## Mean of Squares for Error:   MSE = SSE / DFE
mse <- sse / dfe

## Mean of Squares Total:   MST = SST / DFT
mst <- sst / dft

## F Statistic F = MSM/MSE
f_score <- msm/mse

## Adjusted R Squared R2 = 1 - (1 - R2)(n - 1) / (n - p)
adjusted_r_squared <- 1 - (1 - r_squared ) * dft / dfe
adjusted_r_squared

## Calculate the p-value from the F distribution
p_value <- pf(f_score, dfm, dft, lower.tail=F)
p_value
