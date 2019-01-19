setwd("~/GitHub/STAT579/hw5")
library(ggplot2)
library(plyr)
fly <- read.csv("flying-etiquette.csv")
#cleanup
fly$Age <- factor(fly$Age, levels=c("18-29", "30-44", "45-60", "> 60", ""))
fly$Household.Income <- factor(fly$Household.Income, levels = c("$0 - $24,999","$25,000 - $49,999", "$50,000 - $99,999", "$100,000 - $149,999", "150000", ""))
#fly$Education <- factor(fly$Education, levels = c("Less than high school degree", "High school degree", "Some college or Associate degree", "Bachelor degree",  "Graduate degree", ""))

# SB edit-----
head(fly)
#2

#new comment

ggplot(data=fly, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
#reorder data
#get counts for each level
counts<-count(fly$How.often.do.you.travel.by.plane.)
fly$How.often.do.you.travel.by.plane. <- factor(fly$How.often.do.you.travel.by.plane., levels = counts[order(counts$freq),1])
#plot increasing order
ggplot(data=fly2, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

fly2<-fly[which(!fly$How.often.do.you.travel.by.plane.=="Never"),]
ggplot(data=fly2, aes(x=How.often.do.you.travel.by.plane.)) +  geom_bar(stat = "count")+ theme(axis.text.x = element_text(angle = 90, hjust = 1))
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

#5
c<-which(colnames(fly2)=="In.general..is.itrude.to.bring.a.baby.on.a.plane.")
colnames(fly2)[19]="baby.on.plane."
length(levels(fly2$baby.on.plane.))

#change levels
levels(fly2$baby.on.plane.)[1] <- "Not answered"
levels(fly2$baby.on.plane.)<-levels(factor(fly2$baby.on.plane., levels=c("No, not at all rude", "Yes, somewhat rude","Yes, very rude","Not answered")))
#plot increasing order
ggplot(data=fly2, aes(x=baby.on.plane.)) +  geom_bar(stat = "count")+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

#6
ggplot(data=fly2, aes(x=Gender)) +  geom_bar(stat = "count")+facet_wrap(~baby.on.plane.)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data=fly2, aes(x=Do.you.have.any.children.under.18.)) +  geom_bar(stat = "count")+facet_wrap(~baby.on.plane.)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data=fly2, aes(x=Do.you.have.any.children.under.18.,y=baby.on.plane.)) + geom_boxplot()

fly2$BG <- interaction(fly2$baby.on.plane., fly2$Gender)

ggplot(aes(x = BG), data = fly2) + geom_bar(stat = "count")+facet_wrap(~Do.you.have.any.children.under.18.)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))

fly2$GD <- interaction( fly2$Gender,fly2$Do.you.have.any.children.under.18.)

ggplot(aes(x = GD), data = fly2) + geom_bar(stat = "count")+facet_wrap(~baby.on.plane.)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))


#4
fly$Education = with(fly, factor(fly$Education, levels = rev(levels(fly$Education))))

ggplot(data = fly, aes(x = 1)) + 
  geom_bar(aes(fill=Education), position="fill") 

