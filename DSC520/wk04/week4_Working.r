library(ggm) #for pcorr
library(pastecs) #stat.desc

## Set the working directory to the root of your DSC 520 directory
setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
#setwd("L:\\stonk\\projects\\DSC\\dsc520")

survey_df <- read.csv("data/student-survey.csv")
survey_df
stat.desc(survey_df)

library(Hmisc)
## Set the working directory to the root of your DSC 520 directory
#setwd("C:\\Users\\newcomb\\DSCProjects\\dsc520_github")
#setwd("L:\\stonk\\projects\\DSC\\dsc520")

cor(survey_df,method="kendall")
cor(survey_df,method="spearman")

bootTau <- function(survey_df,i)cor(survey_df$TimeReading[i],survey_df$TimeTV[i],use="complete.obs",method="kendall")
boot_kendall <- boot(survey_df, bootTau, 2000)
boot_kendall
boot.ci(boot_kendall, conf = 0.99)
cor.test(survey_df$D,survey_df$TimeTV,method="kendall", conf.level = 0.95, exact = FALSE)
cor.test(survey_df$TimeReading,survey_df$TimeTV,method="kendall", conf.level = 0.50, exact = FALSE)
cor.test(survey_df$TimeReading,survey_df$Happiness, conf.level = 0.95)
cor.test(survey_df$TimeReading,survey_df$TimeTV, method="kendall", exact=FALSE)

#Partial Correlation
pc1 <- pcor(c("TimeTV","TimeReading","Happiness"), var(survey_df))
pc2 <- pcor(c("TimeTV","Happiness","TimeReading"), var(survey_df))
pc3 <- pcor(c("TimeReading","Happiness","TimeTV"), var(survey_df))
pc1
pc1^2
pcor.test(pc1,1,11)
pc2
pc2^2
pcor.test(pc2,1,11)
pc3
pc3^2
pcor.test(pc3,1,11)

rcorr(survey_df$TimeReading,survey_df$TimeTV)

#cor_df <- data.frame(timeReading_cor,timeTV_cor,happiness_cor,gender_cor)
#colnames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
#rownames(cor_df) <- c("TimeReading","TimeTv","Happiness","Gender")
cor(survey_df,method="pearson")
cor(survey_df,method="pearson") > .25 & cor(survey_df,method="pearson") < .99
print("Kendall")
cor(survey_df,method="kendall")
round(cor(survey_df,method="kendall")^2*100,2)

pairs(cov(survey_df))
pairs(cor(survey_df))
?cor
