library(class) ### K-Nearest Neighbor

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

setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk06")

dataset_df <- read.csv("binary-classifier-data.csv")
dataset_df$label <- dataset_df$label == 1
dataset_df

sum(dataset_df$label)

#a. What is the accuracy of the logistic regression classifier?
#b. How does the accuracy of the logistic regression classifier compare to the nearest neighbors algorithm?
#c. Why is the accuracy of the logistic regression classifier different from that of the nearest neighbors?

data_lm <- glm(label ~ x + y, data=dataset_df)

summary(data_lm)
predict_lm <- predict(data_lm,dataset_df,type="response") > .5

predict_lm

data.frame(actual=dataset_df$label, predict=predict_lm, match=(dataset_df$label == predict_lm))

total_correct <- sum(dataset_df$label == predict_lm)
total_reposnses <- nrow(dataset_df)
total_correct / total_reposnses

?knn

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
pr <- knn(dataset_df_train,dataset_df_test,cl=dataset_df_train_category,k=13)

##create confusion matrix
tab <- table(pr,dataset_df_test_category)
tab
##this function divides the correct predictions by total number of predictions that tell us how accurate teh model is.

accuracy <- function(x){sum(diag(x)/(sum(rowSums(x)))) * 100}
accuracy(tab)
