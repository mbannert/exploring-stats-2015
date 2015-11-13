require(twitteR)

source("examples/credentials.R")

setup_twitter_oauth(ck,cs)

tweets <- Rtweets(n=10000)

twdf <- twListToDF(tweets)

library(dplyr)

twdf$date <- format(twdf$created,"%Y-%m-%d")

week <- twdf %>%
  group_by(date) %>%
  summarize(count = n())

week$date <- as.Date(week$date)

library(ggplot2)
gg <- ggplot(week,aes(y=count,x = date,size=.8))
gg + geom_line() +
  xlab("") +
  ylab("") +
  theme_bw() +
  ggtitle("tweets tagged #rstats") +
  theme(legend.position="none")





