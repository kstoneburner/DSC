#install.packages("factoextra") ### For beautiful graphs
library(factoextra)
library(ggplot2)

### Set working Directory to the Github data folder

setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
#setwd("L:\\stonk\\projects\\DSC\\DSC\\DSC520\\wk08")

#### Load the Binaray Classifier Dataset
dataset_df <- read.csv("clustering-data.csv")


#a. Plot the dataset using a scatter plot.

ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color="blue")

#b. Fit the dataset using the k-means algorithm from k=2 to k=12. Create a scatter plot of the resultant clusters for each value of k.

set.seed(123)

k_means_cluster_df <- data.frame()

### Calculate all the clusters from k2 - k12 and place them in a data frame.
for (k in 2:12){
  
  print(k)
  
  cluster_results <- kmeans(dataset_df, k, iter.max = 25, nstart = 1)
  
  cluster_factor <- as.factor(cluster_results$cluster)

  ### initialize additional rpw to get us started  
  if ( nrow(k_means_cluster_df) == 0 ) {
    
    k_means_cluster_df <- data.frame( k=cluster_factor) 
    
  }#//END check for new Data Frame

    k_means_cluster_df[k] <- cluster_factor
      
  if (k == 12 ){
    #### Remove First Column 
    k_means_cluster_df <- k_means_cluster_df[-1]    
    #### Rename Columns
    colnames(k_means_cluster_df)<-c("k2","k3","k4","k5","k6","k7","k8","k9","k10","k11","k12")
    
  }
  
}#//** END K plot loop

ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k2) + labs(title="K Cluster = 2")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k3) + labs(title="K Cluster = 3")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k4) + labs(title="K Cluster = 4")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k5) + labs(title="K Cluster = 5")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k6) + labs(title="K Cluster = 6")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k7) + labs(title="K Cluster = 7")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k8) + labs(title="K Cluster = 8")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k9) + labs(title="K Cluster = 9")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k10) + labs(title="K Cluster = 10")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k11) + labs(title="K Cluster = 11")
ggplot(data = dataset_df, aes(y = y, x = x) ) + geom_point(color=k_means_cluster_df$k12) + labs(title="K Cluster = 12")


#c. As k-means is an unsupervised algorithm, you cannot compute the accuracy as there are no correct values to compare the output to.
#   Instead, you will use the average distance from the center of each cluster as a measure of how well the model fits the data. 
#   To calculate this metric, simply compute the distance of each data point to the center of the cluster it is assigned to and take 
#   the average value of all of those distances.
#   Compute k-means with k = 4

