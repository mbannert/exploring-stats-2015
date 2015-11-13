data(mtcars)
load("mlb.RData")

temporaryFile <- tempfile()
download.file("https://datenservice.kof.ethz.ch/api/sets/ds_bs_monthly?mime=csv",
              destfile=temporaryFile, method="curl")
kof <- read.csv(temporaryFile)




ll <- list()
ll$cars <- mtcars
ll$mlb <- mlb
ll$kof <- kof

# get all names
lapply(ll,names)

# all summaries
lapply(ll,summary)

# correlation
ll_cor <- lapply(ll,function(x){
  num_cols <- sapply(x,is.numeric)
  cor(na.omit(x[,num_cols]))
})

# what about min / max?
lapply(seq_along(ll),function(x,cnames){
  idx <- which.max(ll[[x]][,cnames[x]])
  ll[[x]][idx,]
},
cnames = c("mpg","height","chimt_d_f7_s01"))



# don't forget to teach the debug mode... 
# define custom functions:
add <- function(a,b){
  a+b
}

add(1,2)









