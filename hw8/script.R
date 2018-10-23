setwd("~/GitHub/STAT579/hw8")
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

#3
#how many responded
dim(starwars)[1]
starwars_yes<-starwars[which(starwars$`Have you seen any of the 6 films in the Star Wars franchise? Response` == 'Yes'),]
#people watched sw
dim(starwars_yes)[1]

