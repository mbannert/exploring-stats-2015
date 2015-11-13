# Programming can help to improve understanding

## generate a regressor
x <- rep(c(-1,1), 50)
## generate heteroskedastic and homoskedastic disturbances
err1 <- rnorm(100, sd=rep(c(1,10), 50))
err2 <- rnorm(100)

# whatch the labels of the axes !
hist(err1,breaks=15)
hist(err2,breaks=15)


## generate a linear relationship
y1 <- 1 + x + err1
y2 <- 1 + x + err2
## perform Breusch-Pagan test
bptest(y1 ~ x)
bptest(y2 ~ x)









