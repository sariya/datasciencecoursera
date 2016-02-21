# Author Sanjeev Sariya
# Date Deb 2016 12
# Programming Assignment 3
# Question 1
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

#str(outcome)
#dim(outcome)
#head(outcome)
#names(outcome)

outcome[, 11] <- as.numeric(outcome[, 11]) #get 11 column mortality rate from heart attack

hist(outcome[, 11])
