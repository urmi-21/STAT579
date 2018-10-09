setwd("~/GitHub/STAT579/hw6")

#2
iowa <- read.csv("iowa-brfss-2012.csv")
library(tidyverse)

#3
ggplot(data=iowa,aes(x=as.factor(DRNKDRI2))) + geom_bar() + scale_y_log10()

sort(table(iowa$DRNKDRI2,useNA = "ifany"))

#4
