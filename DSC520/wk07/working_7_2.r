######################
### Assignment 7.2 ###
########################################################################################################
### Uses glm()to build a logistic regression classifier from coordinate data (it does not work well)
### Inclucdes model and accuracy
########################################################################################################
### uses knn() - k nearesr 

library(class) ### K-Nearest Neighbor
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



setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")

dataset_df <- read.csv("binary-classifier-data.csv")
dataset_df$label <- dataset_df$label == 1
dataset_df

sum(dataset_df$label)

#a. What is the accuracy of the logistic regression classifier?
#b. How does the accuracy of the logistic regression classifier compare to the nearest neighbors algorithm?
#c. Why is the accuracy of the logistic regression classifier different from that of the nearest neighbors?

#######################################################
### Build Model where x & y are used to predict label
#######################################################
data_lm <- glm(label ~ x + y, data=dataset_df)

interpret_model(data_lm)


#######################################################
### Build predicted outcomes from the model
#######################################################
predict_lm <- predict(data_lm,dataset_df,type="response") > .5


data.frame(actual=dataset_df$label, predict=predict_lm, match=(dataset_df$label == predict_lm))

################################################
### Count matches where prediction = label
################################################
total_correct <- sum(dataset_df$label == predict_lm)
total_reposnses <- nrow(dataset_df)
################################################
### Display the accuracy
################################################
print(paste0("Logistic regression classifier accuracy: " ,round(total_correct / total_reposnses,4)*100,"%"))

### Iterpret the model to demonstrate why it's not a good fit
interpret_glm_model(data_lm)


###################################
### K Nearest Neighbor Modeling
###################################

### Generate a 90% random same of data for training
training_rows <- sample(1:nrow(dataset_df), 0.9 * nrow(dataset_df))

##extract training set
dataset_df_train <- dataset_df[training_rows,] ##extract testing set
dataset_df_test <- dataset_df[-training_rows,] ##extract testing set

#extract 1st column of train dataset because it will be used as 'cl' argument in knn function.
dataset_df_train_category <- dataset_df[training_rows,1] 


##extract 1st column of test dataset to measure the accuracy
dataset_df_test_category <- dataset_df[-training_rows,1]

length(dataset_df_test_category)
##run knn function
pr <- knn(dataset_df_train,dataset_df_test,cl=dataset_df_train_category,k=11)

##create confusion matrix
tab <- table(pr,dataset_df_test_category)
tab

###########################################################################################################################
##this function divides the correct predictions by total number of predictions that tell us how accurate the model is.
##This is a very R way of doing things
##I prefer the simple method abouve, but I'll keep this for completeness
###########################################################################################################################
accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
round(accuracy(tab),2)

