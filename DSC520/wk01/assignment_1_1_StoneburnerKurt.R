# Assignment: ASSIGNMENT 1.1
# Name: Stoneburner, Kurt
# Date: 01-06-2020

getwd()

#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")
setwd("L:\\stonk\\projects\\DSC\\dsc520\\data")


## Read the file `data/scores.csv` to `scores_df`
## Display summary statistics using the `summary()` function
scores_df <- read.csv("scores.csv", stringsAsFactors = FALSE)
summary(scores_df)

### Build Data Frame with only the Sports Section
section_sports_df <- scores_df[scores_df$Section == "Sports",]
summary(section_sports_df)

### Build Data Frame with only the Regular Section
section_regular_df <- scores_df[scores_df$Section == "Regular",]
summary(section_regular_df)


#Plot each dataframe. Each Axis must be converted to a vector first
#Draws Two plots. Red plot is the Sports Section. Blue Plot is the Regular Section.
plot(section_sports_df[,c("Score")], section_sports_df[,c("Count")], type="b", col="red", xlab="Scores", ylab="Score Frequency")
lines(section_regular_df[,c("Score")], section_regular_df[,c("Count")], type="b", col="blue", xlab="yyy")
legend("topleft", pch=c(2,2), legend=c("Section: Regular","Section: Sports"), text.col=c("blue","red"), bty="7")


#Build vectors of weighted scores, score * frequency
weighted_scores <- scores_df[,c("Score")] * scores_df[,c("Count")]

#Weighted Regular Section
weighted_regular_section <- section_regular_df[,c("Score")] * section_regular_df[,c("Count")]

#Weighted Sports Section
weighted_sports_section <- section_sports_df[,c("Score")] * section_sports_df[,c("Count")]

### Display Summaries of Weighted Values for comparison
summary(weighted_scores)
summary(weighted_regular_section)
summary(weighted_sports_section)

#Find the Mean and Median values within the mid-spread (2nd & 3rd quartiles)
#Create a new Data Frame with the weighted Scores and the Section
weighted_df <- scores_df
weighted_df$Score <- scores_df[,c("Score")] * scores_df[,c("Count")]

# Get the midspread of all scores with the values between 3050 and 6550.
# These values were found in summary(weighted_scores)
mid_spread_weighted_df <- weighted_df[ weighted_df$Score > 3050 & weighted_df$Score < 6550,]
mid_spread_regular_df <- weighted_df[ weighted_df$Score > 3050 & weighted_df$Score < 6550 & scores_df$Section == "Regular" ,]
mid_spread_sports_df <- weighted_df[ weighted_df$Score > 3050 & weighted_df$Score < 6550 & scores_df$Section == "Sports" ,]


### Display Summaries of Mid Spread Weighted Values for comparison
summary(mid_spread_weighted_df$Score)
summary(mid_spread_regular_df$Score)
summary(mid_spread_sports_df$Score)




