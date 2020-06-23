library(ggplot2)
library(pastecs)

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
setwd("L:\\stonk\\projects\\DSC\\dsc520")

survey_df <- read.csv("data/student-survey.csv")
survey_df
stat.desc(survey_df)



cor_df <- data.frame(timeReading_cor,timeTV_cor,happiness_cor,gender_cor)
colnames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
rownames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
cor_df
abs(cor_df) >.25 & cor_df < .99

cov_df <- data.frame(timeReading_cov,timeTV_cov,happiness_cov,gender_cov)
colnames(cov_df) <- c("TimeReading","TimeTv","Happiness","Gender")
rownames(cov_df) <- c("TimeReading","TimeTv","Happiness","Gender")
cov_df


print("Pearson")
cor(survey_df,method="pearson")
cor(survey_df,method="pearson") > .25 & cor(survey_df,method="pearson") < .99
print("Kendall")
cor(survey_df,method="kendall")
print("Spearman")
cor(survey_df,method="spearman")


cov(survey_df)

mins_survey_df <- cbind(survey_df,(survey_df$TimeReading * 60) )
colnames(mins_survey_df) <- c("TimeReading","TimeTv","Happiness","Gender","readingMins")
cov(survey_df)
cov(mins_survey_df)

readByTime <- survey_df$TimeReading / survey_df$TimeTV
readByTime

cor(readByTime, survey_df$Happiness)

cohappiness_cov / cov(survey_df$Happiness,survey_df$Happiness,)

?cor

timeReading_cov = c(
  cov(survey_df$TimeReading,survey_df$TimeReading),
  cov(survey_df$TimeReading,survey_df$TimeTV),
  cov(survey_df$TimeReading,survey_df$Happiness),
  cov(survey_df$TimeReading,survey_df$Gender) )

timeReading_cov / cov(survey_df$TimeReading,survey_df$TimeReading)


cor.test(survey_df$TimeTV,surve)

stat.desc(survey_df)
pairs(survey_df)
###
###
### Looking at a Histogram of Happiness, We can see that Happiness is not normally distributed.
################################################################################
### Combined Plot: Frequency Histogram, Normal Distribution, Probability Density
### The lines are smooshed, so the y Scale is wrong
################################################################################
ggplot(survey_df, aes(Happiness)) +
  ###########
#Theming 
###########
theme_dark() + 
  theme(
    panel.background = element_rect(fill = "linen") 
  ) +
  ##################################
# Base Layer: Density Histogram
##################################
geom_histogram(
  aes(y=..density..),
  bins = 5, 
  color = 'WHITE'
) +
  #########################################
# Add Line: Normal Distribution - Green
#########################################
stat_function(
  fun = dnorm, 
  args = list(mean = mean(survey_df$Happiness), sd = sd(survey_df$Happiness)),color="red", size=1, 
) + 
  ############################################
# Add Line: Probability Density - Red
############################################
geom_density(color="green", size=1)


?cor()

timeReading_cov = c(
  cov(survey_df$TimeReading,survey_df$TimeReading),
  cov(survey_df$TimeReading,survey_df$TimeTV),
  cov(survey_df$TimeReading,survey_df$Happiness),
  cov(survey_df$TimeReading,survey_df$Gender) )

timeReading_cov

timeTV_cov = c(
  cov(survey_df$TimeTV,survey_df$TimeReading),
  cov(survey_df$TimeTV,survey_df$TimeTV),
  cov(survey_df$TimeTV,survey_df$Happiness),
  cov(survey_df$TimeTV,survey_df$Gender) )
timeTV_cov

happiness_cov = c(
  cov(survey_df$Happiness,survey_df$TimeReading),
  cov(survey_df$Happiness,survey_df$TimeTV),
  cov(survey_df$Happiness,survey_df$Happiness),
  cov(survey_df$Happiness,survey_df$Gender) )
happiness_cov

gender_cov = c(
  cov(survey_df$Gender,survey_df$TimeReading),
  cov(survey_df$Gender,survey_df$TimeTV),
  cov(survey_df$Gender,survey_df$Happiness),
  cov(survey_df$Gender,survey_df$Gender) )
gender_cov

timeReading_cor = c(
  cor(survey_df$TimeReading,survey_df$TimeReading),
  cor(survey_df$TimeReading,survey_df$TimeTV),
  cor(survey_df$TimeReading,survey_df$Happiness),
  cor(survey_df$TimeReading,survey_df$Gender) )

timeReading_cor

timeTV_cor = c(
  cor(survey_df$TimeTV,survey_df$TimeReading),
  cor(survey_df$TimeTV,survey_df$TimeTV),
  cor(survey_df$TimeTV,survey_df$Happiness),
  cor(survey_df$TimeTV,survey_df$Gender) )
timeTV_cor

happiness_cor = c(
  cor(survey_df$Happiness,survey_df$TimeReading),
  cor(survey_df$Happiness,survey_df$TimeTV),
  cor(survey_df$Happiness,survey_df$Happiness),
  cor(survey_df$Happiness,survey_df$Gender) )
happiness_cor

gender_cor = c(
  cor(survey_df$Gender,survey_df$TimeReading),
  cor(survey_df$Gender,survey_df$TimeTV),
  cor(survey_df$Gender,survey_df$Happiness),
  cor(survey_df$Gender,survey_df$Gender) )
gender_cor
