Date Feb 09 2016

Data Science Course

Programming Assignment 2

cachematrix.R script name

HOW TO RUN ----------------


source the script


###### Non zero determinant

m<-matrix(1:4,nrow = 2,ncol = 2)

ret<-makeCacheMatrix(m)

ret$getMatrix() # print matrx

ret$getInverse() # should be NULL the first one

cacheSolve(ret)


###### Zero Determinant


m<-matrix(1:9,nrow = 3,ncol = 3) 

ret<-makeCacheMatrix(m)

ret$getMatrix()

ret$getInverse()

cacheSolve(ret)

