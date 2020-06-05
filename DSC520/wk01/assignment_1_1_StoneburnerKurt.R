# Assignment: ASSIGNMENT 1
# Name: Stoneburner, Kurt
# Date: 2020-06-01

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


summary(section_sports_df$Count)
summary(section_regular_df$Count)

range(section_sports_df$Score)
range(section_regular_df$Score)
395-200
380-265
sum(section_sports_df$Count)
sum(section_regular_df$Count)

weighted_scores <- scores_df[,c("Score")] * scores_df[,c("Count")]
weighted_regular_section <- section_regular_df[,c("Score")] * section_regular_df[,c("Count")]
weighted_sports_section <- section_sports_df[,c("Score")] * section_sports_df[,c("Count")]

summary(weighted_scores)
summary(weighted_regular_section)
summary(weighted_sports_section)




#Create a new Data Frame with the weighted Scores and the Section
weighted_df <- scores_df
weighted_df$Score <- scores_df[,c("Score")] * scores_df[,c("Count")]
weighted_df$Score
weighted_df
weighted_df$Score <- scores_df[( weighted_df$Score > 3050 && weighted_df$Score < 6550) ,]

weighted_df$Score

summary(weighted_df$Score)
summary(weighted_df$Score)

class(weighted_df$Score)
IQR(weighted_df$Score)
summary(tWeight)
summary(weighted_df)
tapply(weighted_df, weighted_df[1], summary)

class(weighted_df)

iqr_weighted_scores <- IQR(weighted_scores)
iqr_weighted_regular_section <- IQR(weighted_regular_section)
iqr_weighted_sports_section <- IQR(weighted_sports_section)


summary(weighted_scores)
summary(iqr_weighted_scores)
summary(weighted_regular_section)
summary(iqr_weighted_regular_section)
summary(weighted_sports_section)
summary(iqr_weighted_sports_section)


summary(section_regular_df)
summary(section_sports_df)

plot(section_sports_df[,c("Score")], section_sports_df[,c("Count")], type="b")
plot(scores_df[,c("Score")], scores_df[,c("Count")], type="b")
#plot(regular_count, regular_score)
reg_mode_count <- section_regular_df$Count
reg_mode_count
reg_mode_scores <- section_regular_df$Score
reg_mode_scores
mean(reg_mode_scores)
median(reg_mode_scores)

sum(reg_mode_count)
