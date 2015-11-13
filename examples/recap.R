# vector
a <- 1
b <- c(1,3)
d <- 1:5

# matrix
mat <- matrix(1:9,nrow = 3)

# data.frame
dframe <- data.frame(a = c(1,2,3),
                     b = paste("a",5:7,sep="_"),
                     stringsAsFactors = F)

# list
ll <- list()
ll$a <- a
ll$b <- b
ll$dframe <- dframe

# names
names(ll)
str(ll)

# indexing
b[2]
mat[3,3]
ll[[2]]
b[c(T,F)]


# missing values
miss <- c(NA,1,3,4,2)
mean(miss)
mean(miss,na.rm=T)
na.omit(miss)

miss_dframe <- rbind(dframe,c(NA,"a_5"))
miss_dframe <- rbind(miss_dframe,c(33,NA))
na.omit(miss_dframe)

# regression to na.omit automatically!!!!




