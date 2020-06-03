# Use the appropriate R functions to answer the following questions:
#   1. What are the observational units in this study?
#   2. Identify the variables mentioned in the narrative paragraph and determine which are categorical and quantitative?
#   3. Create one variable to hold a subset of your data set that contains only the Regular Section and one variable for the Sports Section.
#   4. Use the Plot function to plot each Sections scores and the number of students achieving that score. 
#      Use additional Plot Arguments to label the graph and give each axis an appropriate label. 
#      Once you have produced your Plots answer the following questions:
#          a. Comparing and contrasting the point distributions between the two section, 
#             looking at both tendency and consistency: Can you say that one section tended to score more points than the other? Justify and explain your answer.
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
scores_df <- read.csv("scores.csv")
summary(scores_df)
scores_df

section_sports_df <- scores_df[scores_df$Section == "Sports",]
section_sports_df

section_regular_df <- scores_df[scores_df$Section == "Regular",]
section_regular_df
