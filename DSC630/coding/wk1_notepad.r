
#//*** Data obtained from Bureau of Labor Statistics, County Employment and Wages, 2020
#//*** https://www.bls.gov/cew/downloadable-data-files.htm

#//*** Batch Action: Load File, build dataframes and clean, convert columns to numeric
{
  library(stringr)
  library(ggplot2)
  
  #//*** Remove scientific notation
  options(scipen = 999)   
  
  #//*** Set Working Directory when working at home
  if ( grepl("family", getwd()) ){
    setwd("C:\\Users\\family\\DSCProjects\\DSC\\DSC630\\coding")
  }
  #//*** Verify Working Directory
  getwd()

    #//*** Import the CSV data Downloaded from the BLS
  raw_df <- read.csv("z_wk01_allhlcn20.csv", header=TRUE,stringsAsFactors=T)

  #//*** Build Dataframe of County Data
  county_df <- raw_df[raw_df$Ownership == "Total Covered" & raw_df$"Area.Type" == "County", ]
  
  #//*** Build DataFrame of State Totaled Data
  state_df <- raw_df[raw_df$Ownership == "Total Covered" & raw_df$"Area.Type" == "State", ]
  
  
  #//*** Remove un-needed columns
  state_df <- state_df[,c(9,14:18) ]
  

  #//*** Convert columns from character to numeric
  for (x in colnames(state_df)[2:6]){
    #//*** Remove Commas from each column
    state_df[x] <- lapply(state_df[x], function(i) gsub(",", "", i) )  
    
    #//*** Convert Column as list to numeric
    state_df[x] <- as.numeric(unlist(state_df[x]))
  }

  #//*** Rename Columns
  names(state_df)[1] <- "state"
  names(state_df)[2] <- "businesses"
  names(state_df)[3] <- "employees"
  names(state_df)[4] <- "total.wages"
  names(state_df)[5] <- "weekly.pay"
  names(state_df)[6] <- "annual.pay"
  
  #//*** Display the class of each column  
  sapply(state_df, class)
  
} #//*** End Batch Action


#//*** Display Summary Statistics for: Annual.Average.Employment, Annual.Total.Wages
summary(state_df[c("businesses","annual.pay")])


#//*******************************
#//*** Total Business Count
#//*******************************
#//*** Plot with reorderig the states by descending business value
ggplot(data=state_df, aes(x=reorder(state, -businesses),y=businesses)) +
  
  #//*** Rotate the X text 90 degrees. Makes the State names readable
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  
  #//*** Define the X Label
  xlab("") + 
  
  #//*** Define the Y Label
  ylab("Total Number of Businesses") +
  
  #//*** Title
  ggtitle("Total Average Business Count by State in 2020") +
  
  #//*** Bar Plot based on Identity. Matches the Y value to the X State name
  geom_bar(stat="identity", fill='blue') 

#//*******************************
#//*** Total Wages
#//*******************************
#//*** Plot with reorderig the states by descending business value
ggplot(data=state_df, aes(x=reorder(state, -total.wages),y=total.wages)) +
  
  #//*** Rotate the X text 90 degrees. Makes the State names readable
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  
  #//*** Define the X Label
  xlab("") + 
  
  #//*** Define the Y Label
  ylab("Total Wages") +
  
  scale_y_continuous(labels = scales::comma) + 
  
  #//*** Title
  ggtitle("Total Wages Paid by State in 2020") +
  
  #//*** Bar Plot based on Identity. Matches the Y value to the X State name
  geom_bar(stat="identity",fill='blue') 

#//*******************************
#//*** Average Annual Pay
#//*******************************
#//*** Plot with reorderig the states by descending business value
ggplot(data=state_df, aes(x=reorder(state, -annual.pay),y=annual.pay)) +
  
  #//*** Rotate the X text 90 degrees. Makes the State names readable
  theme(axis.text.x = element_text(angle = 90, hjust=1)) +
  
  #//*** Define the X Label
  xlab("") + 
  
  #//*** Define the Y Label
  ylab("Employee Annual Pay") +

  

  scale_y_continuous(labels = scales::comma) + 
  
  #//*** Title
  ggtitle("Total Wages Paid by State in 2020") +
  
  #//*** Bar Plot based on Identity. Matches the Y value to the X State name
  geom_bar(stat="identity",fill='blue') 






#//*** Display last error
#rlang::last_error()
