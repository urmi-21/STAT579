setwd("~/GitHub/STAT579/hw6")

#2
iowa <- read.csv("iowa-brfss-2012.csv")
library(tidyverse)

#3
ggplot(data=iowa,aes(x=as.factor(DRNKDRI2))) + geom_bar() + scale_y_log10()

sort(table(iowa$DRNKDRI2,useNA = "ifany"))

#iowa<-iowa %>% mutate(drinkdrive = (DRNKDRI2 == 88 )*0)
iowa<-iowa %>% mutate(drinkdrive = ifelse(DRNKDRI2 == 88, 0, ifelse(DRNKDRI2 == 77 | DRNKDRI2 == 99, NA, DRNKDRI2)))


iowa[,c('drinkdrive','DRNKDRI2')]

#4
