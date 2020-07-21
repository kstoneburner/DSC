library(ggplot2)
knn_accuracy <- function(input_df,k_vector,sampling_rate){
  #### Test the accuracy of knn by runing the algorithm with accross multiple
  #### k values stored in k_vector
  
  loop_max <- 1
  
  output_vector <- c()
  
  ### Loop through each value in k_vector
  for (mainCount in 1:length(k_vector)) {
    
    k_value <- k_vector[mainCount]
    
    accuracy_counter <- c()
    
    for (avg_counter in 1:loop_max) {
      
      #### Run the model average counter number of times to build a set of accuracy values.
      #### Keep the mean of the accuracy values
      
      
      ### Generate a 90% random same of data for training
      training_rows <- sample(1:nrow(input_df), sampling_rate * nrow(input_df))
      
      ##extract training set
      input_df_train <- input_df[training_rows,] ##extract testing set
      input_df_test <- input_df[-training_rows,] ##extract testing set
      
      #extract 1st column of train dataset because it will be used as 'cl' argument in knn function.
      input_df_train_category <- input_df[training_rows,1] 
      
      
      ##extract 1st column of test dataset to measure the accuracy
      input_df_test_category <- input_df[-training_rows,1]
      
      
      ##run knn function
      pr <- knn(input_df_train,input_df_test,cl=input_df_train_category,k=k_value)
      
      
      ### The total where prediction equals the test value
      total_correct = sum(pr==input_df_test_category)
      
      data_count = length(input_df_test_category)
      
      
      
      accuracy_counter <- append(accuracy_counter,total_correct / data_count)
      
    }#//*** END 
    
    
    output_vector <- append(output_vector,mean(accuracy_counter))
    
  }#//*** END EACH K Vector
  
  return(output_vector)
  
  
  ###########################################################################################################################
  ##this function divides the correct predictions by total number of predictions that tell us how accurate the model is.
  ##This is a very R way of doing things
  ##I prefer the simple method abouve, but I'll keep this for completeness
  ###########################################################################################################################
  #accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
  #round(accuracy(tab),2)
  
}#//END Knn accuracy
### Set working Directory to the Github data folder

setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk08")

#### Load the Binaray Classifier Dataset
binary_class_df <- read.csv("binary-classifier-data.csv")

#### Load the Trinary Classifier Dataset
trinary_class_df <- read.csv("trinary-classifier-data.csv")

#a. Plot the data from each dataset using a scatter plot.
ggplot(data = binary_class_df, aes(y = y, x = x, color=label ) ) + geom_point()

ggplot(data = trinary_class_df, aes(y = y, x = x, color=label )) + geom_point() 


#b. Fit a k nearest neighbors model for each dataset for k=3, k=5, k=10, k=15, k=20, and k=25. 
#Compute the accuracy of the resulting models for each value of k. 
#Plot the results in a graph where the x-axis is the different values of k and the y-axis is the accuracy of the model.


###################################
### K Nearest Neighbor Modeling
###################################

binary_accuracy_v <- knn_accuracy(binary_class_df,c(3,5,10,15,20,25),0.9)
binary_accuracy_v
binary_accuracy_df <- data.frame(k=c(3,5,10,15,20,25),accuracy=binary_accuracy_v)
plot(binary_accuracy_df)


trinary_accuracy_v <- knn_accuracy(trinary_class_df,c(3,5,10,15,20,25),0.9)
trinary_accuracy_v
trinary_accuracy_df <- data.frame(k=c(3,5,10,15,20,25),accuracy=trinary_accuracy_v)
plot(trinary_accuracy_df)
