setwd("~/GitHub/STAT579/hw6")

#2
iowa <- read.csv("iowa-brfss-2012.csv")
library(tidyverse)

#3
ggplot(data=iowa,aes(x=as.factor(DRNKDRI2))) + geom_bar() + scale_y_log10()

sort(table(iowa$DRNKDRI2,useNA = "ifany"))

#iowa<-iowa %>% mutate(drinkdrive = (DRNKDRI2 == 88 )*0)
iowa<-iowa %>% mutate(drinkdrive = ifelse(DRNKDRI2 == 88, 0, ifelse(DRNKDRI2 == 77 | DRNKDRI2 == 99, NA, DRNKDRI2)))


iowa[which(iowa$DRNKDRI2==99),c('drinkdrive','DRNKDRI2')]

summary(iowa[which(!is.na(iowa$drinkdrive)),c('drinkdrive')])
length(iowa[which(!is.na(iowa$drinkdrive)),c('drinkdrive')])
#for male
males<-iowa[which(!is.na(iowa$drinkdrive) & iowa$SEX==1),c('drinkdrive')]
summary(males)
length(males)
#female
females<-iowa[which(!is.na(iowa$drinkdrive) & iowa$SEX==2),c('drinkdrive')]
summary(females)
length(females)

t.test(males,females) 


#4
iowa$X_SMOKER3 <- as.factor(iowa$X_SMOKER3)
head(iowa$X_SMOKER3)
levels(iowa$X_SMOKER3)<-c("Current Smoker", "Current Smoker", "Former Smoker" ,"Never Smoked", "NA")
head(iowa$X_SMOKER3)

ggplot(data=iowa, aes(x=X_SMOKER3)) + geom_bar()+facet_wrap(~X_AGE_G) + theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(data=iowa, aes(x=AGE)) + geom_density()+facet_wrap(~X_SMOKER3) + theme(axis.text.x = element_text(angle = 90, hjust = 1))

#5
iowa_notNA<-iowa[which(!(iowa$X_SMOKER3=="NA")),]
tot<-dim(iowa_notNA)[1]
iowaNS<-iowa_notNA[which((iowa_notNA$X_SMOKER3=="Never Smoked")),]
#percent nonsmoker
totNS<-dim(iowaNS)[1]
totNS/tot*100

table(iowaNS$X_AGE_G)/tot*100

table(iowaNS$SEX)/tot*100

table(iowaNS$X_AGE_G)/totNS*100
table(iowaNS$SEX)/totNS*100

#6
iowa<-iowa %>% mutate(POORHLTHNEW = ifelse(POORHLTH == 88, 0, ifelse(POORHLTH == 77 | POORHLTH == 99, NA, POORHLTH)))
head(iowa[,c('POORHLTHNEW','POORHLTH')],100)
ggplot(data=iowa, aes(x=POORHLTHNEW,fill=SEX)) + geom_bar()+facet_wrap(~X_AGE_G, scales = "free_x") + theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(data=iowa, aes(x=POORHLTHNEW, fill=as.factor(SEX))) + geom_bar()+facet_wrap(~X_AGE_G, scales = "free_x")


