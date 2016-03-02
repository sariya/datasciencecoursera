# Date 28 Feb
# MySQL R - session week 2
#
library("RMySQL")

ucscDb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu") #open a connection -- handle
result<-dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);
result
## 
# -- work on hg19-- human genome 19 build

hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu") #open a connection -- handle

allTables<-dbListTables(hg19)
allTables
length(allTables)

allTables[1:5]

dbListFields(hg19,"affyU133Plus2") # get all columns

dbGetQuery(hg19,"select count(*)  from affyU133Plus2") # get all records

affyData<-dbReadTable(hg19,"affyU133Plus2")
head(affyData)
# subset 
query<-dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis<-fetch(query) ; quantile(affyMis$misMatches)

# -- get only subset rows
affyMisSmall<-fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall)

dbDisconnect(hg19)
