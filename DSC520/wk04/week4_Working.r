library(pastecs)

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
setwd("L:\\stonk\\projects\\DSC\\dsc520")

survey_df <- read.csv("data/student-survey.csv")
survey_df
stat.desc(survey_df)

cov(survey_df$Happiness,survey_df$TimeReading)
cor(survey_df$Happiness,survey_df$TimeReading)

cov(survey_df$Happiness,survey_df$TimeTV)
cor(survey_df$Happiness,survey_df$TimeTV)

cov(survey_df$Happiness,survey_df$Gender)
cor(survey_df$Happiness,survey_df$Gender)

cov(survey_df$TimeReading,survey_df$TimeTV)
cor(survey_df$TimeReading,survey_df$TimeTV)

cov(survey_df$TimeReading,survey_df$Gender)
cor(survey_df$TimeReading,survey_df$Gender)

cov(survey_df$TimeReading,survey_df$Gender)
cor(survey_df$TimeReading,survey_df$Gender)

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

cor_df <- data.frame(timeReading_cor,timeTV_cor,happiness_cor,gender_cor)
colnames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
rownames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
cor_df
abs(cor_df) >.25 & cor_df < .99

cov_df <- data.frame(timeReading_cov,timeTV_cov,happiness_cov,gender_cov)
colnames(cov_df) <- c("TimeReading","TimeTv","Happiness","Gender")
rownames(cov_df) <- c("TimeReading","TimeTv","Happiness","Gender")
cov_df
