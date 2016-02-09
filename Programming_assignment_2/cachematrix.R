# Author: Sanjeev Sariya
# Date Feb 09 2016

## Put comments here that give an overall description of what your
## functions do
# Function - makeCacheMatrix - creates a matrix:
#                               if provided by argument it will set it that, otherwise
#                               the default matrix will be set

# Function  - cacheSolve - See if the cache is present. If present than gets from cache.
#                          Else Checks if the determinant of the matix is non-zero
#                         based on non-zero determinant inverse is set for the matrix, and printed

## Write a short comment describing this function
#makeCacheMAtrix - creates matrix.. and set the invers as NULL. It is set when cachesolver is called. Upon calling once
#                                                               stored inverse is used
#It also checks for non determinant

makeCacheMatrix <- function(x = matrix()) {
  
  inv<-NULL
  
  set_matrix<-function(matrix_temp){ 
    x<<-matrix_temp
    inv<<-NULL
  }
  
  get_matrix<-function(){  
    x
  }
  
  get_inverse<-function(){  
    inv
  }
  
  set_inverse<-function(matrix_inverse){
   inv<<-matrix_inverse
    
  }
  
  list(getMatrix=get_matrix, setMatrix=set_matrix, getInverse=get_inverse,setInverse=set_inverse)
  
} # functoin ends

## Write a short comment describing this function
# cachesolve - returns inverse if it exists else generates for matrices which have non-zero determinant

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  val_inverse<-x$getInverse() # get inverse
 
  if(!is.null(val_inverse)){
    
    print("getting cached Matrix inverse")
    return(val_inverse) 
  }
  
  else{
    
    temp_matrix<-x$getMatrix()
    
    if(det(temp_matrix)==0){
      print("Cannot get the inverse of your matrix as its Determinant is 0")
      
    }
    else{ # if det is not 0
      
      inv<-solve(temp_matrix) # get inverse
      x$setInverse(inv) # set  inverse
      inv
    }
    # -- determinant 0 ends
  }
  # -- inverse check ends
  
} # -- function ends



