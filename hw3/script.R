library(tidyverse)
#2
iowa <- read.csv("iowa-brfss-2012.csv")
#3
dim(iowa)
str(iowa)

#4
ggplot(data=iowa,aes(x=HEIGHT3,y=WEIGHT2))+geom_point()+facet_wrap(~SEX)
#5
ggplot(data=iowa,aes(x=HEIGHT3,y=WEIGHT2))+geom_point()+facet_wrap(~SEX)+ xlim(0, 2500)+ylim(0, 2500)

#6
iowa_feet<-iowa

iowa_feet$feet[which(iowa_feet$HEIGHT3<=711)]<-iowa_feet$HEIGHT3[which(iowa_feet$HEIGHT3<=711)]%/%100

#7
iowa_feet$inch[which(iowa_feet$HEIGHT3<=711)]<-iowa_feet$HEIGHT3[which(iowa_feet$HEIGHT3<=711)]%%100

#8
iowa_feet$height<-(iowa_feet$feet*30.48+iowa_feet$inch*2.54)/100

#9
ggplot(data=iowa_feet,aes(x=height,fill=SEX))+ geom_histogram()+facet_wrap(~SEX)
iowa_feet$sex2<-as.factor(iowa_feet$SEX)
ggplot(data=iowa_feet,aes(x=height,fill=sex2))+ geom_density(alpha = 0.2)
ggplot(data=iowa_feet,aes(x=height,fill=sex2)) + geom_histogram(alpha = 0.8,bins = 40,position ='identity')



ggplot(data=iowa_feet,aes(x=height,y=WEIGHT2))+geom_point()+facet_wrap(~SEX)
