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

library(ggplot2)
library(pastecs)

# install the R package


#tinytex::install_tinytex()
#tinytex:::is_tinytex()


## Set the working directory to the root of your DSC 520 directory
## My working directory varies by my physical working environment

#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
setwd("L:\\stonk\\projects\\DSC\\dsc520")


survey_df <- read.csv("data/acs-14-1yr-s0201.csv")
head(survey_df)
str(survey_df)
nrow(survey_df)
ncol(survey_df)

#########################################################################
### Set bins using Rice's Rule - Cube Root of Observations squared
### Thanks to  Scott Breitbach for sharing this on the boards
#########################################################################
myBins <- as.integer((length(survey_df$HSDegree)^(1/3))^2)

x_label_plot <- "% High School Degree"
########################################
### Histogram, frequency Distribution
########################################
ggplot(survey_df, aes(HSDegree)) + 
  geom_histogram(
    aes(y=..density..), 
    bins = myBins, color = 'WHITE'
    )  + 
  theme_dark()  + 
  theme(
    panel.background = element_rect(fill = "linen")
    ) +
  labs(
    title= "Distribution of Population with a High School Degree",
    x=x_label_plot, 
    y="Count"
  )

################################################################################
### Combined Plot: Frequency Histogram, Normal Distribution, Probability Density
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
    subtitle = "Green - Probability Distribution    Red - Normal Curve",
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

### Using Round on stat.desc() to keep the values more readable. 
round(stat.desc(survey_df$HSDegree, basic=FALSE, norm=TRUE), digits = 5)
#stat.desc(survey_df$HSDegree, basic=FALSE, norm=TRUE)
#stat.desc(survey_df$HSDegree, basic=FALSE, norm=FALSE)
#stat.desc(survey_df$HSDegree, basic=TRUE, norm=FALSE)
shapiro.test(survey_df$HSDegree)

### Exploring the dnorm function to figure it out
norm_plot <- dnorm(survey_df$HSDegree, mean=mean(survey_df$HSDegree), sd=sd(survey_df$HSDegree))
norm_plot
plot( ( norm_plot ) )


summary(survey_df$HSDegree)





