set.seed(23)
# The Utopia example... omitted variable bias and so on...
sport <- 10 * rbeta(10000, 2, 6)
lazy <- rnorm(10000, 8, 1)
parents <- rbinom(10000, 1, 0.1)

# instrument
distance <- rnorm(10000, 100, 30)

u <- 0.2 * rnorm(10000)

# true model:
error <- rnorm(10000)
weedsmokingstar <- -3.5 + 2.5 * parents - 0.25 * sport + 1.2 * lazy - 0.01 * 
  distance + error
# check whether there a negative grams...  hint: weedsmokingstar == 0
weedsmoking <- rep(0, 10000)
weedsmoking[weedsmokingstar > 6] <- 1

# true model
gpa <- 7.8 - 0.2 * weedsmoking - 0.2 * parents -
  0.15 * sport - 0.4 * lazy + u


# we know the DGP
fit1 <- lm(gpa ~ weedsmoking + parents + sport + lazy)
summary(fit1)

qqnorm(fit1$residuals)
qqline(fit1$residuals)



fit_biased <- lm(gpa ~ weedsmoking + parents + sport)
summary(fit_biased)


# http://personality-testing.info/_rawdata/



