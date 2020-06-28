##########################################################################################
### Convert NA to 0
##########################################################################################
### Hospital Data Frame - any_df
##########################################################################################
for (colCount in 1:length(any_df ) ) {
  
  ### Looping through each column
  ### Unlist converts data_frame list to vector
  thisColumn <- unlist(any_df[colCount])
  
  ### Sapply returns a vector. The function returns 0 if NA, else returns existing value
  new_column <- sapply(thisColumn, function(x){
    if (is.na(x) ) {
      return(0)
    } else { return(x) }
  },simplify="array")
  
  any_df[colCount] <- new_column
  
  
  
}#//END Each Column

head(any_df)