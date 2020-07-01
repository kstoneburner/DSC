### Process US Covid Risk Assesment CSV into a more generalized set of calculations and export to CSV
### The current list is far too granular based on census tracts.
### Data obtained from:
### https://www.census.gov/data/experimental-data-products/community-resilience-estimates.html

#setwd("C:\\Users\\newcomb\\DSCProjects\\DSC\\covid")
setwd("L:\\stonk\\projects\\DSC\\DSC\\Covid")

resil_df <- read.csv("US_Covid_Risk_assesment.csv")
head(resil_df)

resil_df <- resil_df[ which(resil_df$stname == "California"), ]
head(resil_df)
resil_df
county <- unique(resil_df$county)
county

state_df <- resil_df[ which(resil_df$tract == 0), ]
head(state_df)


population_df <- data.frame()
for (i in 1:length(county)){
  ###Loop Through each county value and get one county entity for total population
  temp_row <- state_df[ which(state_df$county == county[i]), ]

  ### Add First row will just use for population
  population_df <- rbind(population_df,
                         ################################
                         ### Build Data frame to append
                         ################################
                         
                                    ### County
                         data.frame(temp_row[1,]$ctname,
                                    temp_row[1,]$popuni,
                                    ### o rf 
                                    temp_row[1,]$prednum,
                                    temp_row[1,]$prednum_moe,
                                    temp_row[1,]$predrt,
                                    temp_row[1,]$predrt_moe,
                                    ### 1-2 rf
                                    temp_row[2,]$prednum,
                                    temp_row[2,]$prednum_moe,
                                    temp_row[2,]$predrt,
                                    temp_row[2,]$predrt_moe,
                                    ### 3 rf 
                                    temp_row[3,]$prednum,
                                    temp_row[3,]$prednum_moe,
                                    temp_row[3,]$predrt,
                                    temp_row[3,]$predrt_moe
                         )### END New Data Frame
                         ) ### END rbind
  
  
}
head(population_df)
### Build County percentage of population / sum(population)
round( population_df$popuni/sum(population_df$popuni),6)

population_df <- cbind(population_df, round( population_df[2]/sum(population_df[2]),6))
colnames(population_df) <- c("county","population",
                             "no_rf_prednum", 
                             "no_rf_prednum_moe", 
                             "no_rf_predrt",
                             "no_rf_predrt_moe",
                             "onetwo_rf_prednum", 
                             "onetwo_rf_prednum_moe", 
                             "onetwo_rf_predrt",
                             "onetwo_rf_predrt_moe",
                             "three_rf_prednum", 
                             "three__prednum_moe", 
                             "three_rf__predrt",
                             "three_rf_predrt_moe",
                             "pop_percent")
population_df


### Cleanup County name
for (i in 1:length(population_df$ctname)){
  population_df$ctname[i] <- gsub(" County, CA", "",population_df$ctname[i])
}

### Write to File
write.csv(population_df,"CA_county_population.csv")


#Should be close to 100
sum(population_df$pop_percent)

sum(population_df$three_rf_prednum)
sum(population_df$population)
sum(population_df$three_rf_prednum) / sum(population_df$population)
