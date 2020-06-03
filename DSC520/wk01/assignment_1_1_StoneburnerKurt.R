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
setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github\\data")

## R interpreted names as factors, which is not the behavior we want
## Load the same file to person_df2 using `read.csv` and setting `stringsAsFactors` to `FALSE`
## Examine the structure of `person_df2` using `str()`
person_df2 <- read.csv("tidynomicon\\person.csv", stringsAsFactors = FALSE)
str(person_df2)

## Read the file `data/scores.csv` to `scores_df`
## Display summary statistics using the `summary()` function
scores_df <- read.csv("scores.csv", stringsAsFactors = FALSE)
summary(scores_df)
str(scores_df)
scores_df

section_sports_df <- scores_df[scores_df$Section == "Sports",]
section_sports_df
sum(section_sports_df$Count)

section_regular_df <- scores_df[scores_df$Section == "Regular",]
section_regular_df
str(section_regular_df)
class(section_regular_df)
sum(section_regular_df$Count)

regular_score <- section_regular_df[,c("Score")]
regular_count <- section_regular_df[,c("Count")]

plot(section_regular_df[,c("Score")], section_regular_df[,c("Count")], type="l")
plot(section_sports_df[,c("Score")], section_sports_df[,c("Count")], type="l")
#plot(regular_count, regular_score)
reg_mode_count <- section_regular_df$Count
reg_mode_count
reg_mode_scores <- section_regular_df$Score
reg_mode_scores
mean(reg_mode_scores)
median(reg_mode_scores)
