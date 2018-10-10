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

