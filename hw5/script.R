setwd("~/GitHub/STAT579/hw5")
library(ggplot2)

fly <- read.csv("flying-etiquette.csv")
#cleanup
fly$Age <- factor(fly$Age, levels=c("18-29", "30-44", "45-60", "> 60", ""))
fly$Household.Income <- factor(fly$Household.Income, levels = c("$0 - $24,999","$25,000 - $49,999", "$50,000 - $99,999", "$100,000 - $149,999", "150000", ""))
fly$Education <- factor(fly$Education, levels = c("Less than high school degree", "High school degree", "Some college or Associate degree", "Bachelor degree",  "Graduate degree", ""))