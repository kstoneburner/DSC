interpret_glm_model <- function(input_lm) {
  ####################################################################  
  ### Interpreting the models
  ####################################################################  
  ### Discovering Statistics Using R, p336
  ####################################################################  
  ### Function Purpose: Combine a series of tests used to evaluate
  ### the effectiveness of a glm() - Logistic Regression Classifier
  ### Input Variables:
  ###                input_lm - glm() based linear model to evaluate
  ####################################################################
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