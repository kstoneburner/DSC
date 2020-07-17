#DGN: Diagnosis - specific combination of ICD-10 codes for primary and secondary as well multiple tumours if any (DGN3,DGN2,DGN4,DGN6,DGN5,DGN8,DGN1)
#2. PRE4: Forced vital capacity - FVC (numeric)
#3. PRE5: Volume that has been exhaled at the end of the first second of forced expiration - FEV1 (numeric)
#4. PRE6: Performance status - Zubrod scale (PRZ2,PRZ1,PRZ0)
#5. PRE7: Pain before surgery (T,F)
#6. PRE8: Haemoptysis before surgery (T,F)
#7. PRE9: Dyspnoea before surgery (T,F)
#8. PRE10: Cough before surgery (T,F)
#9. PRE11: Weakness before surgery (T,F)
#10. PRE14: T in clinical TNM - size of the original tumour, from OC11 (smallest) to OC14 (largest) (OC11,OC14,OC12,OC13)
#11. PRE17: Type 2 DM - diabetes mellitus (T,F)
#12. PRE19: MI up to 6 months (T,F)
#13. PRE25: PAD - peripheral arterial diseases (T,F)
#14. PRE30: Smoking (T,F)
#15. PRE32: Asthma (T,F)
#16. AGE: Age at surgery (numeric)
#17. Risk1Y: 1 year survival period - (T)rue value if died (T,F) 

#install.packages("mlogit")
library(foreign) #Used to import ARFF files
library(car)
library(mlogit)
setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")

dataset_df <- read.arff("ThoraricSurgery.arff")

head(dataset_df)

#salePrice_naieve_lm <-  lm(Sale.Price ~ zip5 + bedrooms + bath_total + square_feet_total_living, data=housing_df)
data_all_lm <- glm(Risk1Yr ~ AGE + DGN + 
                 PRE4 + PRE5 + PRE6 + PRE7 + PRE8 + PRE9 + PRE10 + PRE11 + 
                 PRE14 + PRE17 + PRE19 + PRE25 + PRE30 + PRE32,
               data=dataset_df, family=binomial())


data1_lm <- glm(Risk1Yr ~ DGN+PRE7+PRE8+PRE10+PRE11+PRE14+PRE30,
                   data=dataset_df, family=binomial())

confint(data1_lm)

summary(data1_lm)

summary(data_all_lm)

interpret_model <- function(input_lm) {
  ################################################
  ### Interpreting the models
  ################################################
  ### Discovering Statistics Using R, p336
  ### summary():
  ############## Estimate: how much influence the variable has on the model
  ############## Residual Deviance should be less than the Null deviance. This demonstrates the m
  ############## AIC: Akaike Information Criterion - Lower values are better
  ############## Model Chi-Square statistic p332
  ############## 
  
    ### Chi - bigger/better
  chi <- input_lm$null.deviance - input_lm$deviance
  
  ### R squared
  rSquared <- chi / input_lm$null.deviance
  
  ### chi_degrees_of_freedom - 
  chidf <- input_lm$df.null - input_lm$df.residual
  
  ### Chi Squared Probability: P  needs to be be < .005 to reject null hypothesis
  thisProb <- 1 - pchisq(chi, chidf)  
  
  ### Build Chi Square
  print(paste0("Chi Squared (bigger better) :", chi))
  print(paste0("Pseudo R2 Squared :", rSquared))
  print(paste0("p (should be less than .005)  :", thisProb))
  print(paste0("AIC (lower is better)  :", AIC(input_lm)))

  ##########################
  ### Generate odds ratios
  ##########################
  ### Discovering Statistics Using R p336
  ### If the ratio is greater than 1, as the predictor (variable) increases the odds of the outcome occurring will increase.
  ### If the ratio is less than 1, as the predictor (variable) increase the odds of the outcome occurring will decrease
  print("Odds:  looking for > 1")
  print(exp(input_lm$coefficients))

    ### Look at confidence Ratios for the ratios.
  ### Confidence intervals should not cross 1. The lower levels should be greater than 1. 
  print("Confidence Interval: Odds")
  print(exp(confint(input_lm)))
  

}#//END interpret_model

interpret_model(data1_lm)
interpret_model(data_less2_lm)
interpret_model(data_all_lm)

### Analysis of variance. Looking for increased deviance. The greater the number the greater the difference in outcome between models
anova(data_all_lm,data1_lm)
anova(data_all_lm,data_less2_lm)
anova(data1_lm,data_less2_lm)


#### Build predicted data set
predict_less2 <- predict(data_less2_lm,dataset_df,type="response")
predict_all <- predict(data_all_lm,dataset_df,type="response") > .5
predict_data1_lm <- predict(data1_lm,dataset_df,type="response") > .5


build_casewise_stats <- function(input_df,input_lm){
  #### Build Casewise statistics for a linear model
  input_df$predicted.probabilities <- fitted(input_lm)
  input_df$standardized.residuals <- rstandard(input_lm)
  input_df$studentized.residuals  <- rstudent(input_lm)
  input_df$dfbeta                 <- dfbeta(input_lm)
  input_df$dffit                  <- dffits(input_lm)
  input_df$leverage               <- hatvalues(input_lm)
  
  return(input_df)
  
}#//END 


evaluate_casewise_stats <- function(input_df,input_lm){
  ##########################################
  ### Evaluate Casewise stats
  ##########################################
  
  predicted.probabilities <- fitted(input_lm)
  standardized.residuals <- rstandard(input_lm)
  studentized.residuals  <- rstudent(input_lm)
  dfbeta                 <- dfbeta(input_lm)
  dffit                  <- dffits(input_lm)
  leverage               <- hatvalues(input_lm)
  
  ### Leverage
  ## k = Number of predictors. Use get the length of the $model df
  ## N = total rows
  ## average levarage = (k + 1)/n
  k<-length(input_lm$model)
  n <- length(input_df)
  
  
  #######################################
  ###  Calculate the average leverage
  #######################################
  average_leverage <- (k + 1) / n
  
  
  #######################################
  ###  Leverage boundaries are 2x & 3x
  #######################################
  average_leverage_2x_boundary <- average_leverage * 2
  average_leverage_3x_boundary <- average_leverage * 3
  
  #### Total cases that exceed boundary
  leverage_total_2x <- sum(leverage > average_leverage_2x_boundary)
  leverage_total_3x <- sum(leverage > average_leverage_3x_boundary)

  #### Percentage of cases that exceed the boundary.
  leverage_percent_2x <- sum(leverage > average_leverage_2x_boundary) / n
  leverage_percent_3x <- sum(leverage > average_leverage_3x_boundary) / n 

  ### Residuals
  
  ### dfbeta
  
  print(paste0("Average Leverage: ", round(average_leverage,4) )  )
  print(paste0("Cases Above 2x: ", leverage_total_2x, " - ", round(leverage_percent_2x,2)*100,"%   > 5% is problematic"))
  print(paste0("Cases Above 3x: ", leverage_total_3x, " - ", round(leverage_percent_3x,2)*100,"%   > 2.5% is problematic"))
  
  #######################################
  ###  DFBeta should be less than 1
  #######################################
  
  print( paste0("DFBeta: Total values greater than 1 [", sum(dfbeta > 1) , " out of ",length(dfbeta),"]"))
  
  large_residuals <- sum(standardized.residuals > 2 | standardized.residuals < -2 )
  xl_residuals <- sum(standardized.residuals > 2.58 | standardized.residuals < -2.58 )
  
  if (is.na(large_residuals) == TRUE) { large_residuals <- 0}
  if (is.na(xl_residuals) == TRUE)    { xl_residuals <- 0}
  
  print( paste0("Large Residuals: [", large_residuals , " : ",round(large_residuals/n,2)*100,"%] - Should less than 5%"))
  print( paste0("XL Residuals: [", xl_residuals , " : ",round(xl_residuals/n,2)*100,"%] - Should less than 1%"))
  
  
  #####################################################################
  #### 8. Assess the assumption of no multicollinearity using vif()
  #####################################################################
  #### p292
  #### vif(model)       - If largest value > 10 there is cause for concern
  #### mean(vif(model)) - If the average VIF is substantially greater than 1, the model may be biased
  #### 1/vif(model)     - Tolerance: values below 0.1 indicate serious problems, 0.2 indicate potential problems
  #####################################################################
  print("############################################################")  
  print("### VIF: Values greater than 10 - are problematic")
  print("############################################################")  
  print(vif(input_lm)[,1])
  print("############################################################")  
  print("### Mean VIF: Substantially greater than 1 is problematic")
  print("############################################################")  
  print(mean(vif(input_lm)))
  print("########################################################################")  
  print("### VIF Tolerance: Below .1 is a problem, Below .2 is a serious Problem")
  print("########################################################################")  
  print(1/vif(data1_lm)[,1])  

  
  
}#//END Evaluate Casewise Stats



evaluate_casewise_stats(predict_data1_lm,data1_lm)



sum(predict_data1_lm$standardized.residuals > 2 | predict_data1_lm$standardized.residuals < -2)


str(predict_data1_lm$dfbeta)

predict_data1_lm <- build_casewise_stats(predict_data1_lm,data1_lm)
predict_all <- build_casewise_stats(predict_all)
predict_less2 <- build_casewise_stats(predict_less2)

table(Actual_value=dataset_df$Risk1Yr,predicted_value=casewise_df$predicted.probabilities > .05)

predict_data1_lm > .05 == dataset_df$Risk1Yr == "T"

table(dataset_df$Risk1Yr == "T",predict_data1_lm > .05)

#data.frame(actual=dataset_df$Risk1Yr == "T", predicted=predict_data1_lm, actual2 = ( (actual=dataset_df$Risk1Yr == "T") == (predict_data1_lm) ) )

nrow(dataset_df)
### Total number where predictor matches outcome
sum( (actual=dataset_df$Risk1Yr == "T") == (predict_data1_lm) )
### Percentage  where predictor matches outcome
sum( (actual=dataset_df$Risk1Yr == "T") == (predict_data1_lm) ) / nrow(dataset_df)

#data.frame(actual=dataset_df$Risk1Yr == "T", predicted=predict_all, actual2 = ( (actual=dataset_df$Risk1Yr == "T") == (predict_all) ) )

sum( (actual=dataset_df$Risk1Yr == "T") == (predict_all) )
sum( (actual=dataset_df$Risk1Yr == "T") == (predict_all) ) / nrow(dataset_df)


################################################
### Interpreting the models
################################################
### Discovering Statistics Using R, p336
### summary():
############## Estimate: how much influence the variable has on the model
############## Residual Deviance should be less than the Null deviance. This demonstrates the m
############## AIC: Akaike Information Criterion - Lower values are better
############## Model Chi-Square statistic p332
############## 

#### Build chi square
#### The null Deviance minus the null deviance - (difference between null deviance and rsidual deviance in summary())
less2_lm_chi <- data_less2_lm$null.deviance - data_less2_lm$deviance
less2_lm_chi

### chi_degrees_of_freedom - 
less2_lm_chidf <- data_less2_lm$df.null - data_less2_lm$df.residual
less2_lm_chidf

### Chi Squared Probability: P  needs to be be < .005 to reject null hypothesis
less2_lm_chidf_prob <- 1- pchisq(less2_lm_chi, less2_lm_chidf)
less2_lm_chidf_prob

### Calculate R squared (chi Squared / null deviance)
less2_lm_rsquared <- less2_lm_chi / data_less2_lm$null.deviance
less2_lm_rsquared

##########################
### Generate odds ratios
##########################
### Discovering Statistics Using R p336
### If the ratio is greater than 1, as the predictor (variable) increases the odds of the outcome occurring will increase.
### If the ratio is less than 1, as the predictor (variable) increase the odds of the outcome occurring will decrease
exp(data_less2_lm$coefficients)

### Look at confidence Ratios for the ratios.
### Confidence intervals should not cross 1. The lower levels should be greater than 1. 
confint(data_less2_lm)

exp(confint(data1_lm))

?glm.fit()

summary(data_less2_lm)
summary(data_less_lm)
summary(data_all_lm)
AIC(data_less2_lm)

#chi-squared test = sum( (observed - model)^2  )

exp(data_less2_lm$coefficients)
?exp
summary(data_all_lm)

?mlogit

results_less <- predict(data_less_lm,dataset_df,type="response")
results_less2 <- predict(data_less_lm,dataset_df,type="response")
results_all <- predict(data_all_lm,dataset_df,type="response")

confuMatrix_all <- table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_all >.5)
confuMatrix_all

table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_less2 >.5)

data.frame(Actual_value=dataset_df$Risk1Yr,predicted_value=results_less2,value=results_less2 > .5)

sum(results_less2 > .5)


confuMatrix <- table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_less >.5)
confuMatrix
