## These two functions - makeCacheMatrix and cacheSolve work together in 
## order to cache the results of the time-consuming inverse function the 
## first time it gets computed for a matrix.  All subsequent times that 
## the inverse of the matrix is needed, the cache can be accessed instead 
## of needing to compute the inverse again.  This saves resources.  To do this,x
## we need to create a special matrix that keeps track of this information.   


## The makeCacheMatrix function creates a special matrix which is really a 
## list containing functions that 
## 1. set the value of the matrix
## 2. get the value of the matrix
## 3. set the inverse of the matrix
## 4. get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) inverse <<- solve 
  getinverse <- function() inverse
  list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


## The cacheSolve function returns the inverse matrix.  First it checks to 
## see if the solution has already been solved and cached.  If so, it returns
## the cached data.  Otherwise, it gets the data out of the matrix, solves for 
## the inverse matrix, caches the inverse matrix, and then returns the result.


cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
    inverse <- x$getinverse()
    if (!is.null(inverse)) {
      message('getting cached data')
      return(inverse)
    }
    data <- x$get()
    inverse <- solve(data, ...)
    x$setinverse(inverse)
    inverse
}
