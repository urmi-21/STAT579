setwd("~/GitHub/STAT579/mid")
library(tidyverse)

gss <- readRDS("gss.rds")

#num rows
dim(gss)[1]
#num inter by years
gss %>% count(YEAR)
#num vars
dim(gss)[2]
#most interviews
gss %>% count(YEAR) %>% filter(n==max(n))
#plot by year
ggplot(data=gss %>% count(YEAR), aes(x=YEAR,y=n))+geom_bar(stat="identity",aes(fill=YEAR))


#2

levels(gss$AGE)[which(levels(gss$AGE)=='89 OR OLDER')]=89
levels(gss$AGE)[which(levels(gss$AGE)=='DK')]=NA

gss1<-gss %>% mutate(AGE_num=levels(gss$AGE)[as.numeric(AGE)])
#replace to NA
gss1 <-  gss1 %>% mutate(AGE_num = replace(AGE_num, AGE_num=="NA", NA))
#num missing
sum(is.na(gss1$AGE_num))

ggplot(data=gss1,aes(x=AGE_num))+geom_histogram(stat="count")+facet_wrap(~SEX,ncol = 1)+theme(axis.text.x = element_text(angle = 90, hjust = 1))



#3

#freq of degree
gss1 %>% count(DEGREE)
#remove DK, IAP
levels(gss1$DEGREE)[which(levels(gss1$DEGREE)=='DK')]=NA
levels(gss1$DEGREE)[which(levels(gss1$DEGREE)=='IAP')]=NA

levels(gss1$DEGREE)<-c('LT HIGH SCHOOL', 'HIGH SCHOOL', 'JUNIOR COLLEGE', 'BACHELOR', 'GRADUATE', "NA")
gss1 <-  gss1 %>% mutate(DEGREE = replace(DEGREE, DEGREE=="NA", NA))

ggplot(data=gss1%>%filter(!is.na(DEGREE)),aes(x=AGE_num))+geom_histogram(stat="count")+facet_wrap(~DEGREE,ncol = 1)+theme(axis.text.x = element_text(angle = 90, hjust = 1))


#4

gss1 %>% group_by(SEX) %>% filter(!is.na(AGEKDBRN)) %>% summarize(avg=mean(AGEKDBRN),sd=sd(AGEKDBRN),obs=n())

avgs <- gss1 %>% group_by(YEAR,SEX,DEGREE) %>% filter(!is.na(AGEKDBRN)) %>% summarize(avg=mean(AGEKDBRN),sd=sd(AGEKDBRN),obs=n()) %>% filter(obs>=30)

ggplot(data=avgs, aes(x=avg))+geom_histogram() + facet_wrap(SEX~DEGREE)






