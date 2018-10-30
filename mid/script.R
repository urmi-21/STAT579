setwd("~/GitHub/STAT579/mid")
library(tidyverse)

gss <- readRDS("gss.rds")

#num rows
dim(gss)[1]
#num inter by years
t<- gss %>% count(YEAR)
#num vars
dim(gss)[2]
#most interviews
gss %>% count(YEAR) %>% filter(n==max(n))
#plot by year
ggplot(data=gss %>% count(YEAR), aes(x=YEAR,y=n))+geom_bar(stat="identity",aes(fill=YEAR))


#3

levels(gss$AGE)[which(levels(gss$AGE)=='89 OR OLDER')]=89
levels(gss$AGE)[which(levels(gss$AGE)=='DK')]=NA

gss1<-gss %>% mutate(AGE_num=levels(gss$AGE)[as.numeric(AGE)])
#replace to NA
gss1 <-  gss1 %>% mutate(AGE_num = replace(AGE_num, AGE_num=="NA", NA))
#num missing
sum(is.na(gss1$AGE_num))

ggplot(data=gss1,aes(x=AGE_num))+geom_histogram(stat="count")+facet_wrap(~SEX,ncol = 1)+theme(axis.text.x = element_text(angle = 90, hjust = 1))



