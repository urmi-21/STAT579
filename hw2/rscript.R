

library(alr3)
library("ggplot2", lib.loc="~/R/win-library/3.4")
data(banknote)
banknote$Y <- factor(banknote$Y)

#3
summary(banknote)

#4
ggplot(banknote, aes(x=Bottom,color=Y)) + geom_bar(size=1)

#5
ggplot(banknote, aes(x=Bottom, color=Y)) + geom_histogram(fill="white",bins=35)+ geom_histogram(fill="white",alpha=0.5, position="identity",bins=35)

#6
ggplot(banknote, aes(x=Length, y=Diagonal, color=Y)) + geom_point(size=2)

#7
