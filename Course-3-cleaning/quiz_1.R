#Date Feb 22 2016
# Quiz 1

# Question 1

url_file_csv<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url_file_csv,destfile = "./idaho",method = "curl")
idaho<-read.csv("./idaho",sep=",",header = TRUE)
head(idaho)
dim(idaho)
str(idaho) # gives you structure
# How many properties are worth $1,000,000 or more?


data<-filter(idaho,VAL==24) #-- VAL 24 indicates for prop value more than 10^6
dim(data)

## -- Questoin 1 ends

#2
# Tiny data rules and information

#--- Q2 ends

# Questoin 3
url_excel<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

download.file(url_excel,destfile = "./n_gas.xlsx",method = "curl")

library(xlsx)

?read.xlsx2

cls<-c("numeric","numeric","numeric","numeric","numeric","numeric","numeric")
# cls is important  to provide class to the respective column.. Could have used Lsit
dat<-read.xlsx2("./n_gas.xlsx",sheetIndex = 1,colIndex = 7:15,startRow = 18, endRow = 23, stringsAsFactors=FALSE ,
                colClasses=cls)

str(dat)
sum(dat$Zip*dat$Ext,na.rm = T)

# Question 4
xml<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
library(XML)

doc<-xmlTreeParse(xml,useInternal =TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

zip_code<-xpathSApply(rootNode,'//zipcode',xmlValue)
length(zip_code)
length(which(zip_code==21231))

# Questoin 5
csv_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(csv_url,destfile = "./american.csv",method = "curl")
DT<-fread("american.csv",header=TRUE)


system.time(sapply(split(DT$pwgtp15,DT$SEX),mean) ) # 0.001

system.time(mean(DT$pwgtp15,by=DT$SEX)) # 0

system.time(tapply(DT$pwgtp15, DT$SEX, mean)) # 0.002

system.time(DT[,mean(pwgtp15),by=SEX]) # 0.003

system.time(mean(DT[DT$SEX==1,]$pwgtp15)) # 0.02
system.time(mean(DT[DT$SEX==2,]$pwgtp15)) # 0.19

system.time(rowMeans(DT)[DT$SEX==1]) #stopped at 0.632
system.time(            rowMeans(DT)[DT$SEX==2]) # stopped at 0.617

rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
