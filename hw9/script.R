library(tidyverse)
library(readxl)
X2018_statistical_annex_all <- read_excel("2018_statistical_annex_all.xlsx", 
                                          sheet = "Table 2")
names(X2018_statistical_annex_all)<-c("HDI Rank","Country","HDIValue1990","", "HDIValue2000","","HDIValue2010","","HDIValue2012","","HDIValue2014","","HDIValue2015","","HDIValue2016","","HDIValue2017","","ChangeinHDI2012-2017","","AvgAnualHDIgrowth1990-2000","","AvgAnualHDIgrowth2000-2010","","AvgAnualHDIgrowth2010-2017","","AvgAnualHDIgrowth1990-2017")


#5
#remove first 5 rows
data<-X2018_statistical_annex_all[-(1:5),]
#remove all blank cols
data<-data[,-which(names(data)=="")]
#remove rows which don't contain data
data<-data[-which(is.na(data$HDIValue2017)),]

#rename data
colnames(data)<-sub("HDIValue","",colnames(data))

getClass<- function(m){
  #very high for [0.8,1], high for [0.7, .8), medium for [.55, .7) and low below .55):
  res<-c()
  
  #print(length(m))
  for(x in m){
  if (x >= 0.8){
   # print("very high")
    res<-c(res,"very high")
  }
  else if (x >= 0.7){
   # print("high")
    res<-c(res,"high")
    }
  else if (x >= 0.55){
   # print("medium")
    res<-c(res,"medium")
    }
  else {
    #print("low")
    res<-c(res,"low")
  }
  }
  return(res)
    
}

data<-data%>%gather(key = year, value = HDI,3:10) %>% select(Country,year,HDI) %>% mutate(Classification=getClass(HDI))

data$year<-as.character(data$year)
data$HDI<-as.double(data$HDI)
data$Classification<-as.factor(data$Classification)
data$Classification = factor(data$Classification,levels(data$Classification)[c(2,3,1,4)],ordered=TRUE)

#6
ggplot(data=data%>%filter(Country %in% c("United States","Norway","Germany","Canada")),aes(x=year,y=HDI,color=Country,group = 1))+geom_point()+ geom_line()+facet_wrap(~Country)+theme(axis.text.x = element_text(angle = 90, hjust = 1))

#7
data%>%group_by(Country,Classification,year)%>%filter(year==2000 | year==2017)%>% count %>% spread(key = year, value = Classification) %>% 
      mutate(change= ifelse(`2000`==`2017`,"no",ifelse(`2000`>=`2017`,"neg","pos")))%>%group_by(change) %>% count()






