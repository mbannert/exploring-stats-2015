#' Fit a Linear Model
#' 
#' Fit the coefficients that you get from lm().
#' Of course R function is better, just re-inventing 
#' the wheel here to see how the wheels works. 
#' @param Y
#' @param X
#' @param intercept logical
#' @return matrix
fitLM <- function(Y,X,intercept=T){
  X <- as.matrix(X)
  # remember (X'X)^-1(X'Y)
  if(intercept){
    X <- cbind(rep(1,nrow(X)),X)
  } 
  bhat <- solve(t(X) %*% X) %*% (t(X) %*% Y)
  rownames(bhat)[1] <- "Intercept"
  bhat

}

fitLM(mtcars$mpg,mtcars[,-1])
lm(mpg~.,data=mtcars)



# ## Calculate vector of residuals
# res = as.matrix(women$weight-bh[1]-bh[2]*women$height)
# 
# ## Define n and k parameters
# n = nrow(women)
# k = ncol(X)
# 
# ## Calculate Variance-Covariance Matrix
# VCV = 1/(n-k) * as.numeric(t(res)%*%res) * solve(t(X)%*%X)
# 
# ## Standard errors of the estimated coefficients
# StdErr = sqrt(diag(VCV))
# 
# ## Calculate p-value for a t-test of coefficient significance
# P.Value = rbind(2*pt(abs(bh[1]/StdErr[1]), df=n-k,lower.tail= FALSE),
#                 2*pt(abs(bh[2]/StdErr[2]), df=n-k,lower.tail= FALSE))
