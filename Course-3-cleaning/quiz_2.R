# APIs
# Quiz 2
# Date Feb 28 2016
# Sanjeev Sariya
##-- Questoin 1
# https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
library(httr)
library(httpuv)
oauth_endpoints("github")


myapp <- oauth_app("github",
                   key = "e440936ed4eedf791aab",
                   secret = "501fa383f11bafdb8547bf365c6e3274dd898101")

github_token <- oauth2.0_token(oauth_endpoints("github"), myapp) # run this on CLI
gtoken <- config(token = github_token)  # un this on CLI

##-----Question 2
library(sqldf)
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(url,destfile = "./survey.csv",method = "curl")

acs<-read.csv("./survey.csv",sep=",",header = TRUE)
acs

str(acs)
sqldf("select pwgtp1 from acs where AGEP < 50")

## -- Question 3
unique(acs$AGEP)

sqldf("select distinct AGEP from acs")

### --- Get number of characters from 10, 20, 30 and 100th lines
##-- Question 4

con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode<-readLines(con)
nchar(htmlCode[10]) ## -- 45
nchar(htmlCode[20]) ## -- 31

nchar(htmlCode[30]) ## -- 7
nchar(htmlCode[100]) ## -- 25
close(con) # -- close the connection 

## -- questoin 5
# -- fixed with format
# 4th and 9th column
x <- read.fwf(file="getdata_wksst8110.for",skip=4,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)) # leave -1 spaces, take 9 characters, leave 5 spaces, and so on.
# minus sign indicates what to exclude while reading, and parsing file out

head(x)
sum(x$V4) # get sum for all the elements in 4th column

