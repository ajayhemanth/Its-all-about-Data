m = 4000
s = 1000

normFun = function(x) (1/(sqrt(2*pi)*s)) * (exp((-(x-m)^2)/(2*s^2)))
plot(normFun, xlim=c(1000, 7000))

integrate(normFun, -Inf, 4000)

?dnorm

normFun(4000)
dnorm(4000, mean=m, sd=s)

# integrate(normFun, -Inf, 40000)


pnorm(4000,mean=m, sd=s)

?qnorm
qnorm(p=.5, mean=m, sd=s)

plot(normFun, xlim=c(1000, 7000))
rnorm(n=10 , mean=4000, sd=1000)

hist( rnorm(n=1000000 , mean=m, sd=s) )
hist( rnorm(n=1000 , mean=m, sd=s) )
hist( rnorm(n=100 , mean=m, sd=s) )
hist( rnorm(n=10 , mean=m, sd=s) )





# ******************************************

# You can ignore the below code, as they were simply used to create the plots in the powerpoint

# Histogram
dev.new(width=6.5, height=4.5)
hist(rnorm(n=100000, mean=m, sd=s), xlab="Income", main="Income")


# PDF VS CDF
par(mfrow=c(2,1))
plot(function(x) dnorm(x,m,s) , xlim=c(1000,7000), ylab="Density", xlab="Income")
plot(function(x) pnorm(x,m,s) , xlim=c(1000,7000), ylab="Probability", xlab="Income")

# ******************************************