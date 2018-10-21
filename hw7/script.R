setwd("~/GitHub/STAT579/hw7")
library(dplyr)
library(ggplot2)
library(readr)
starwars <- read_csv("StarWars.csv")

# part of the names:
line1 <- names(starwars)
line2 <- unlist(starwars[1,])
varnames <- paste(line1, line2)
# clean up some of the multibyte characters:
names(starwars) <- enc2native(stringi::stri_trans_general(varnames, "latin-ascii"))

starwars <- starwars[-1,]
head(starwars)


#hw secB
ChickWeight

#2

ChickWeight %>% count(Chick) %>% filter(n <12)

complete<-ChickWeight %>% group_by(Chick) %>% mutate(count = n())  %>% filter(count==12)

chkList<-unique(as.character(complete$Chick))

#3
complete<-complete  %>%  group_by(Chick) %>% mutate(weightgain = weight-first(weight))


#4

ggplot(data=complete %>% filter(Time==21),aes(x=Diet)) + geom_boxplot(aes(y=weightgain,fill=Diet))
#sort increasing
ggplot(data=complete %>% filter(Time==21),aes(x=reorder(Diet,weightgain,FUN = median))) + geom_boxplot(aes(y=weightgain,fill=reorder(Diet,weightgain,FUN = median)))+
  xlab("Diet") + scale_fill_discrete(guide = guide_legend(title = "Diet"))

#5

ggplot(data=complete ,aes(x=Time,y=weight))+ geom_point(aes(colour=Diet)) + facet_wrap(~Diet)+ geom_line(aes(x=Time,y=weight, group = Chick, colour=Diet))

#6


ggplot(data=complete%>%group_by(Diet)%>%filter(Time==21)%>%filter(weight==max(weight)) ,aes(x=Time,y=weight))+ geom_point(aes(colour=Diet)) 

complete %>% group_by(Time,Diet) %>% mutate(a=ave(weight))

ggplot(data=complete %>% group_by(Time,Diet) %>% mutate(avgWt=ave(weight)) ,aes(x=Time,y=avgWt))+ geom_point(aes(colour=Diet)) + facet_wrap(~Diet)+ geom_line(aes(x=Time,y=avgWt, colour=Diet))


