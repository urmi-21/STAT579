setwd("~/GitHub/STAT579/hw5")
library(ggplot2)
library(plyr)
fly <- read.csv("flying-etiquette.csv")
#cleanup
fly$Age <- factor(fly$Age, levels=c("18-29", "30-44", "45-60", "> 60", ""))
fly$Household.Income <- factor(fly$Household.Income, levels = c("$0 - $24,999","$25,000 - $49,999", "$50,000 - $99,999", "$100,000 - $149,999", "150000", ""))
fly$Education <- factor(fly$Education, levels = c("Less than high school degree", "High school degree", "Some college or Associate degree", "Bachelor degree",  "Graduate degree", ""))

#2


ggplot(data=fly, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")
#reorder data
#get counts for each level
counts<-count(fly$How.often.do.you.travel.by.plane.)
fly$How.often.do.you.travel.by.plane. <- factor(fly$How.often.do.you.travel.by.plane., levels = counts[order(counts$freq),1])
#plot increasing order
ggplot(data=fly2, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")

fly2<-fly[which(!fly$How.often.do.you.travel.by.plane.=="Never"),]
ggplot(data=fly2, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")
dim(fly2)

#3

#Replace "" with NA
fly2$Education[which(fly2$Education=="")]=NA
fly2$Age[which(fly2$Age=="")]=NA
fly2$Household.Income[which(fly2$Household.Income=="")]=NA
#how many ecucation are not NA
length(which(!is.na(fly2$Education)))
length(which(!is.na(fly2$Age)))
length(which(!is.na(fly2$Household.Income)))

#no missing in Education or Age or Houshold.Income
length(which(!is.na(fly2$Education) | !is.na(fly2$Age) | !is.na(fly2$Household.Income)))
length(which (!(is.na(fly2$Education) & is.na(fly2$Age) & is.na(fly2$Household.Income))))
