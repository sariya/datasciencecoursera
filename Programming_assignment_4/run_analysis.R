# run_analysis.R 
# Date 6 march 2016
# Sanjeev Sariya

# 30 volunteers
# 70% for training
# 30% test data

library(dplyr)

# Run this script Inside UCI HAR Dataset directory
# 2 step process: clean test data set
#                 clean training data set      
#   Merge both

features<-read.table("features.txt",header = F)
##-- get all features.. variable names

x_test<-read.table("test/X_test.txt", header = F )
names(x_test)<-features[,2] # set column names

names(x_test) <- make.names(names=names(x_test), unique=TRUE, allow_ = TRUE)

test_subject<-read.table("test/subject_test.txt",header = F)
test_labels<-read.table("test/y_test.txt",header = F)

x_test$label<-test_labels$V1 # add labels  column
x_test$subject<-test_subject$V1 # add subject id column

r<-select(x_test,subject,label,contains("std"),contains("mean")) # get mean, std

names(r)<-(gsub("\\.","",names(r))) # get rid of . 
names(r)<-(gsub("mean","Mean",names(r))) # replace mean with Mean
names(r)<-(gsub("std","Std",names(r))) # replace with std with Std

##- r variable has clean data until now

#### -- training data set

y_training<-read.table("train/X_train.txt", header = F )
names(y_training)<-features[,2] # set column names

# change names .. labeling done 
names(y_training) <- make.names(names=names(y_training), unique=TRUE, allow_ = TRUE)
# get rid of parenthesis, and other chracater

train_subject<-read.table("train/subject_train.txt",header = F)
train_labels<-read.table("train/y_train.txt",header = F)

y_training$label<-train_labels$V1 # add lables 
y_training$subject<-train_subject$V1 # add subject id

j<-select(y_training,subject,label,contains("std"),contains("mean")) # get mean, std
# order is important 

##

names(j)<-(gsub("\\.","",names(j)))
names(j)<-(gsub("mean","Mean",names(j)))
names(j)<-(gsub("std","Std",names(j))) # change mean to Mean, and std to Std

#-- j variable has everything clean for y data 

## ------------------ Merging data. stacking -- appending of rows

t<-rbind(r,j)

t$activity="" # add another column for activity

activity_labels<-read.table("activity_labels.txt",header = F)
activity_list <- as.list(activity_labels) #get activity list

# activity_list $V1 - has numbers 1,2,3,4,5,6
# activity_list $V2 - has activity levels: walking, standing, and others

#- add activity to each row. Drop levels
# Loop over t- merged data
# merged data has label in it. If label matches from activity list 
#                               Add respective activity to row

for(i in 1:dim(t)[1]){
  g #temp variable
  g<-activity_list$V2[which( activity_list$V1 == t$label[i])][1]  %>% droplevels
  t$activity[i]<-levels(g)
}
## for loop ends

t$activity=as.factor(t$activity) #make activty column as factor

#-- Filtering now.----------------------------------------------------------

y<-t %>% select(activity,everything()) # reodrder activity column to the first
o<-y %>% group_by(activity,subject) %>% summarise_each(funs(mean)) #group by subject, and activity

# find mean of each column then

#-- clean data writing-------------------------- in present working directory
write.table(y,file = "clean_data.txt",quote = FALSE) # you cannot write data frame
# output clean data

write.table(o,file = "mean_clean_data.txt",quote = FALSE) # you cannot write data frame
# output data means


