library(tidyverse)
library(readxl)
X2018_statistical_annex_all <- read_excel("2018_statistical_annex_all.xlsx", 
                                          sheet = "Table 2")
names(X2018_statistical_annex_all)<-c("HDI Rank","Country","HDIValue1990","", "HDIValue2000","","HDIValue2010","","HDIValue2012","","HDIValue2014","","HDIValue2015","","HDIValue2016","","HDIValue2017","","ChangeinHDI2012-2017","","AvgAnualHDIgrowth1990-2000","","AvgAnualHDIgrowth2000-2010","","AvgAnualHDIgrowth2010-2017","","AvgAnualHDIgrowth1990-2017")
