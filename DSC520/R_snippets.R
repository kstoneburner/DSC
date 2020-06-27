#####################################################
#Read CSV
#####################################################
## Set the working directory to the root of your DSC 520 directory
setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
#setwd("L:\\stonk\\projects\\DSC\\dsc520")

survey_df <- read.csv("data/student-survey.csv")

#####################################################
#Read CSV - in markdown
#####################################################
rootDir <-"C:\\users\\newcomb\\DSCProjects\\dsc520_github"
#rootDir <- "L:\\stonk\\projects\\DSC\\dsc520"
filePath <- paste(rootDir,"\\data\\student-survey.csv",sep="")
survey_df <- read.csv(filePath)

#####################################################
#Correlation, partial
#####################################################
### Reference: Discovering Statistics Using R, p236

### Variable, Variable, Control. 
library(ggm) #for pcorr
pc1 <- pcor(c("TimeTV","TimeReading","Happiness"), var(survey_df))

#### Displays corellation (same as cor() )
pc1 

### Coefficient of determinat. Essentially how strong the connection is (higher is better)
pc1^2

### Partial correlation test
### Formula, Number of variables to controlm Sample Size
pcor.test(pc1,1,11)
