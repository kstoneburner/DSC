# A professor has recently taught two sections of the same course with only one difference between the sections. 
# In one section, he used only examples taken from sports applications, and in the other section, 
# he used examples taken from a variety of application areas. 
# The sports themed section was advertised as such; so students knew which type of section they were enrolling in.
# The professor has asked you to compare student performance in the two sections
# using course grades and total points earned in the course. 
# You will need to import the Scores.csv dataset that has been provided for you.

# Use the appropriate R functions to answer the following questions:
#   1. What are the observational units in this study?
#          Test Scores, frequency of test scores
#   2. Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
#          Quantitative: Test Scores, Frequency of Test Scores
#          Categorical: Sections[Regular, Sports]
#   3. Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section.
#   4. Use the Plot function to plot each Sections scores and the number of students achieving that score. 
#      Use additional Plot Arguments to label the graph and give each axis an appropriate label. 
#      Once you have produced your Plots answer the following questions:
#         a. Comparing and contrasting the point distributions between the two section, 
#           looking at both tendency and consistency: Can you say that one section tended to score more points than the other? Justify and explain your answer.
#         b. Did every student in one section score more points than every student in the other section? 
#            If not, explain what a statistical tendency means in this context.
#         c. What could be one additional variable that was not mentioned in the narrative 
#            that could be influencing the point distributions between the two sections?


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
str(scores_df)
scores_df

### Build Data Frame with only the Sports Section
section_sports_df <- scores_df[scores_df$Section == "Sports",]
summary(section_sports_df)
summary(section_sports_df$Count)

### Build Data Frame with only the Regular Section
section_regular_df <- scores_df[scores_df$Section == "Regular",]
section_regular_df
summary(section_regular_df)


weighted_scores <- scores_df[,c("Score")] * scores_df[,c("Count")]
weighted_regular_section <- section_regular_df[,c("Score")] * section_regular_df[,c("Count")]
weighted_sports_section <- section_sports_df[,c("Score")] * section_sports_df[,c("Count")]

summary(weighted_scores)
summary(weighted_regular_section)
summary(weighted_sports_section)

iqr_weighted_scores <- IQR(weighted_scores)
iqr_weighted_regular_section <- IQR(weighted_regular_section)
iqr_weighted_sports_section <- IQR(weighted_sports_section)


summary(weighted_scores)
summary(iqr_weighted_scores)
summary(weighted_regular_section)
summary(iqr_weighted_regular_section)
summary(weighted_sports_section)
summary(iqr_weighted_sports_section)

#Plot each dataframe. Each Axis must be converted to a vector first
#Draws Two plots. Red plot is the Sports Section. Blue Plot is the Regular Section.
plot(section_sports_df[,c("Score")], section_sports_df[,c("Count")], type="b", col="red", xlab="Scores", ylab="Score Frequency")
lines(section_regular_df[,c("Score")], section_regular_df[,c("Count")], type="b", col="blue", xlab="yyy")
legend("topleft", pch=c(2,2), legend=c("Section: Regular","Section: Sports"), text.col=c("blue","red"), bty="7")

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
