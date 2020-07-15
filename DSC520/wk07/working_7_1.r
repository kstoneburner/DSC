library(foreign) #Used to import ARFF files

setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")

dataset_df <- read.arff("ThoraricSurgery.arff")


#salePrice_naieve_lm <-  lm(Sale.Price ~ zip5 + bedrooms + bath_total + square_feet_total_living, data=housing_df)
data_all_lm <- glm(Risk1Yr ~ AGE + DGN + 
                 PRE4 + PRE5 + PRE6 + PRE7 + PRE8 + PRE9 + PRE10 + PRE11 + 
                 PRE14 + PRE17 + PRE19 + PRE25 + PRE30 + PRE32,
               data=dataset_df, family=binomial())

data_less_lm <- glm(Risk1Yr ~ AGE +  
                     PRE4 + PRE5 + PRE6 + PRE7 + PRE8 + PRE9 + PRE10 + PRE11 + 
                     PRE14 + PRE17  + PRE30,
                   data=dataset_df, family=binomial())

data_less2_lm <- glm(Risk1Yr ~ PRE4 + PRE5 + PRE7 + PRE9 + PRE10 + PRE11 + 
                      PRE14 + PRE17  + PRE30,
                    data=dataset_df, family=binomial())

summary(data_less2_lm)

summary(data_less_lm)

summary(data_all_lm)

results_less <- predict(data_less_lm,dataset_df,type="response")
results_less2 <- predict(data_less_lm,dataset_df,type="response")
results_all <- predict(data_all_lm,dataset_df,type="response")

confuMatrix_all <- table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_all >.5)
confuMatrix_all

table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_less2 >.5)



confuMatrix <- table(Actual_value=dataset_df$Risk1Yr,predicted_value=results_less >.5)
confuMatrix
