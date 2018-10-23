setwd("~/GitHub/STAT579/hw8")
library(tidyverse)
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

#3
#how many responded
dim(starwars)[1]
starwars_yes<-starwars[which(starwars$`Have you seen any of the 6 films in the Star Wars franchise? Response` == 'Yes'),]
#people watched sw
dim(starwars_yes)[1]


#4
starwars_yes %>% count(`Gender Response`)
starwars_yes %>% count(`Age Response`)
#make factor and arrange levels
starwars_yes$`Age Response`<-factor(starwars_yes$`Age Response`, levels=c("18-29", "30-44", "45-60", "> 60", ""))
levels(starwars_yes$`Age Response`)

#5
starwars_yes[, 10:15]<-sapply(starwars_yes[, 10:15], as.numeric)

xY<-starwars_yes %>% gather(Ep,Rating,colnames(starwars_yes)[10:15])

xY<-xY[which(!is.na(xY$Rating)),] %>% group_by(Ep) %>% mutate(m=mean(Rating))

#MEAN BY MALE AND FEMALE  
meanRatings<-xY[which(!is.na(xY$Rating)),] %>% group_by(Ep,`Gender Response`) %>% summarise_at(vars("Rating"), funs(mean, length))

ggplot(data=meanRatings,aes(x=`Gender Response`)) + geom_boxplot(aes(y=mean))


#6

popularity<-starwars_yes[,25:26] %>% gather(Character,pop,colnames(starwars_yes)[25:26])
#remove NA Unfamiliar (N/A)
popularity<-popularity %>% filter(!is.na(pop))%>% filter(!(pop == "Unfamiliar (N/A)"))
#map popularity to scale -2 -1 0 1 2
# very unfavorably Somewhat unfavorably neutral Somewhat favorably Very favorably
unique(popularity$pop)

