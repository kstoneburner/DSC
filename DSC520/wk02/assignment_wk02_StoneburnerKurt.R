# 1. What are the elements in your data (including the categories and data types)?
#   
#   2. Please provide the output from the following functions: str(); nrow(); ncol()
# 
# 3. Create a Histogram of the HSDegree variable using the ggplot2 package.
# 
# a. Set a bin size for the Histogram.
# 
# b. Include a Title and appropriate X/Y axis labels on your Histogram Plot.
# 
# 4. Answer the following questions based on the Histogram produced:
#   
#   a. Based on what you see in this histogram, is the data distribution unimodal?
#   
#   b. Is it approximately symmetrical?
#   
#   c. Is it approximately bell-shaped?
#   
#   d. Is it approximately normal?
#   
#   e. If not normal, is the distribution skewed? If so, in which direction?
#   
#   f. Include a normal curve to the Histogram that you plotted.
# 
# g. Explain whether a normal distribution can accurately be used as a model for this data.
# 
# 5. Create a Probability Plot of the HSDegree variable.
# 
# 6. Answer the following questions based on the Probability Plot:
#   
#   a. Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
# 
# b. If not normal, is the distribution skewed? If so, in which direction? Explain how you know.
# 
# 7. Now that you have looked at this data visually for normality, you will now quantify normality with numbers using the stat.desc() function. Include a screen capture of the results produced.
# 
# 8. In several sentences provide an explanation of the result produced for skew, kurtosis, and z-scores. In addition, explain how a change in the sample size may change your explanation?

# Assignment: ASSIGNMENT 3
# Name: Stoneburner, Kurt
# Date: 2020-06-08

## Load the ggplot2 package
library(ggplot2)
library(pastecs)
#theme_set(theme_minimal())

## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
setwd("L:\\stonk\\projects\\DSC\\dsc520")

## Load the `acs-14-1yr-s0201.csv` to
survey_df <- read.csv("data/acs-14-1yr-s0201.csv")
head(survey_df)
str(survey_df)
nrow(survey_df)
ncol(survey_df)
myBins <- 20
x_label_plot <- "% High School Degree"
########################################
### Histogram, frequency Distribution
########################################
ggplot(survey_df, aes(HSDegree)) + geom_histogram(aes(y=..density..), bins = myBins, color = 'WHITE')  + theme_dark()  + theme(panel.background = element_rect(fill = "linen")) +
  labs(
    title= "Distribution of Population with a High School Degree",
    x=x_label_plot, 
    y="Count"
  )

################################################################################
### Combined Plot: Frquency Histogram, Normal Distribution, Probability Density
### The lines are smooshed, so the y Scale is wrong
################################################################################
ggplot(survey_df, aes(HSDegree)) +
  ###########
#Theming 
###########
theme_dark() + 
  theme(
    panel.background = element_rect(fill = "linen") 
  ) +
  ###########
#Labels
###########
labs(
  title= "Distribution of Population with a High School Degree",
  subtitle = "Green - Probability Distribution    Red - Normal Curve",
  x=x_label_plot, 
  y="Distribution Density"
)+
  ##################################
# Base Layer: Density Histogram
##################################
geom_histogram(
  bins = myBins, 
  color = 'WHITE'
) +
  #########################################
# Add Line: Normal Distribution - Green
#########################################
stat_function(
  fun = dnorm, 
  args = list(mean = mean(survey_df$HSDegree), sd = sd(survey_df$HSDegree)),color="red", size=1, 
) + 
  ############################################
# Add Line: Probability Density - Red
############################################
geom_density(color="green", size=1)

  

################################################################################
### Combined Plot: Density Histogram, Normal Distribution, Probabilty Density
################################################################################
ggplot(survey_df, aes(HSDegree)) +
  ###########
  #Theming 
  ###########
  theme_dark() + 
  theme(
    panel.background = element_rect(fill = "linen") 
  ) +
  ###########
  #Labels
  ###########
  labs(
    title= "Distribution of Population with a High School Degree",
    subtitle = "Green - Probability Distribution    Red - Normal Curve\nScale Seems smooshed",
    x=x_label_plot, 
    y="Distribution Density"
  )+
  ##################################
  # Base Layer: Density Histogram
  ##################################
  geom_histogram(
    aes(y=..density..), 
    bins = myBins, 
    color = 'WHITE'
  ) +
  #########################################
  # Add Line: Normal Distribution - Green
  #########################################
  stat_function(
    fun = dnorm, 
    args = list(mean = mean(survey_df$HSDegree), sd = sd(survey_df$HSDegree)),color="red", size=1, 
  ) + 
  ############################################
  # Add Line: Probability Density - Red
  ############################################
  geom_density(color="green", size=1)


#stat.desc(survey_df$HSDegree, basic=FALSE, norm=TRUE)
#stat.desc(survey_df$HSDegree, basic=FALSE, norm=FALSE)
round(stat.desc(survey_df$HSDegree, basic=FALSE, norm=TRUE), digits = 5)
#stat.desc(survey_df$HSDegree, basic=TRUE, norm=FALSE)

sd(survey_df$HSDegree)
mean(survey_df$HSDegree)

summary(survey_df$HSDegree)


shapiro.test(survey_df$HSDegree)
