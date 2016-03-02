# Reading data from the web
# Week 2 reading, and getting, and clearning data
# Date Feb 28 2016
# Sanjeev Sariya

con<-url("http://scholar.google.com/citations?user=HI-I6COAAAAJ&hl=en")
htmlCode<-readLines(con)
close(con) # -- close the connection 
htmlCode


# use XML package
library(XML)

url<-"http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html<-htmlTreeParse(url,useInternalNodes = T)
xpathSApply(html,'//title',xmlValue)

xpathSApply(html,"//td[@id='col-citedby']",xmlValue)


## -- get command
# httpr
library(httr)
html2<-GET(url)
content2<-content(html2,as="text")
parsedHtml= htmlParse(content2,asText = TRUE)
xpathSApply(parsedHtml,"//title",xmlValue)

### -- accessing using password

pg2<-GET("http://httpbin.org/basic-auth/user/passwd")
pg2
## -- get the password, and authenticate

pg2<-GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2
names(pg2)

##-- using handles
google<-GET("http://google.com")
pg1<-GET(handle = google,path="/")
pg2<-GET(handle = google,path="search")
