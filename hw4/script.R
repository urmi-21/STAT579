setwd("~/GitHub/STAT579/hw4")
library(devtools) # error? then run install.packages("devtools")
devtools::install_github("heike/classdata")
library(classdata)
head(mojo)
library(ggplot2)

#2
summary(mojo$Week)
summary(mojo$WeekNo)

ggplot(data = mojo,aes(x=Week,y=WeekNo))+geom_boxplot()
boxplot(mojo$Week,main="Boxplot of Week", ylab="Week")
boxplot(mojo$WeekNo,main="Boxplot of WeekNo", ylab="WeekNo")

#3
ggplot(data = mojo,aes(x=WeekNo,y=`Total Gross`))+ geom_point()+ facet_wrap( ~ Year)

plot(mojo$`Total Gross`,x = mojo$WeekNo)

hg<-mojo$Title[which.max(mojo$`Total Gross`)]
mojo[which.max(mojo$`Total Gross`),]
mojo$Week[which.max(mojo$`Total Gross`)]

length(which(mojo$Title==hg & mojo$TW==1))



#4
length(mojo$Title[which(mojo$Year>=2013 & mojo$Year<=2018)])

m1<-"Super Troopers 2"
m2<-"A Quiet Place"

#data for movie1
mojo[which(mojo$Title==m1),]
#data for movie2
mojo[which(mojo$Title==m2),]

twoMovies<- rbind(mojo[which(mojo$Title==m1),],mojo[which(mojo$Title==m2),])

ggplot(data = twoMovies,aes(x=WeekNo,y=`Total Gross`))+ geom_point()+ facet_wrap( ~ Title)


#4
#find movies with budget
moviesBudget<-unique(mojo$Title[!is.na(mojo$`Budget (in Million)`)])

moviesBudgetData<- mojo[mojo$Title %in% moviesBudget,]

#find movies with less earning that budget in opening week
flopMovies_wk1<-moviesBudgetData$Title[which(moviesBudgetData$Week==1 & moviesBudgetData$`Budget (in Million)`>moviesBudgetData$`Total Gross`/1000000)]
pct_wk1<-length(unique(flopMovies_wk1))/length(moviesBudget)*100

#
flopMovies_wk3<-moviesBudgetData$Title[which(moviesBudgetData$Week==3 & moviesBudgetData$`Budget (in Million)`>moviesBudgetData$`Total Gross`/1000000)]
pct_wk3<-length(unique(flopMovies_wk3))/length(moviesBudget)*100

turboBugdetinMil=unique(moviesBudgetData[moviesBudgetData$Title=="Turbo",]$`Budget (in Million)`)*1000000
ggplot(data = moviesBudgetData[moviesBudgetData$Title=="Turbo",],aes(x=Week,y=turboBugdetinMil-`Total Gross`))+ geom_point() + geom_hline(yintercept=turboBugdetinMil, linetype="dashed", color = "red" , size=1)

#plot loss over time


#a hit movie example
spyBugdetinMil=unique(moviesBudgetData[moviesBudgetData$Title=="Spy",]$`Budget (in Million)`)*1000000
ggplot(data = moviesBudgetData[moviesBudgetData$Title=="Spy",],aes(x=Week,y=`Total Gross`))+ geom_point() + geom_hline(yintercept=spyBugdetinMil, linetype="dashed", color = "red" , size=1)

ggplot(data = moviesBudgetData[moviesBudgetData$Title=="Turbo",],aes(x=Week,y=turboBugdetinMil-`Total Gross`))+ geom_point(show.legend = T) + geom_hline(yintercept=turboBugdetinMil, linetype="dashed", color = "red" , size=1)
+ theme(legend.position="top")
