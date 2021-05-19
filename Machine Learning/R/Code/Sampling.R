
# sampling


# Simple Random Sampling

sample(x=1:7, size=5)

sample(x=1:nrow(df1), size=30)

samp1 = sample(x=1:nrow(df1), size=30)
df1[ samp1 , ]


samp1 = sample(x=1:nrow(df1), size=3)
df1[ samp1 , ]

sample(x=1:nrow(df1), size=3)

set.seed(5)
sample(x=1:nrow(df1), size=3)


sample(x=1:7, size=5)

sample(x=1:7, size=5, replace=TRUE)

?sample

# Weighted Sampling & Stratified Sampling

sample(x=1:10, size=10, replace=TRUE, prob=c(1,1,1,1,1,10,10,10,10,10))

sample(x=1:10, size=10, replace=TRUE, prob=c(1,1,1,1,1,0,0,0,0,0))

c(TRUE,TRUE,FALSE,TRUE) * 1

sample(x=1:nrow(df1), size=10, replace=TRUE, prob=1*(df1$Species=="setosa"))

samp1 = sample(x=1:nrow(df1), size=10, replace=TRUE, prob=1*(df1$Species=="setosa"))
df1[ samp1 ,  ]

c(TRUE,TRUE,FALSE,TRUE) * 1
c(TRUE,TRUE,FALSE,TRUE) * 2
c(TRUE,TRUE,FALSE,TRUE) * 3


sample(x=1:nrow(df1), size=10, replace=TRUE, prob= (1*(df1$Species=="setosa")) + (2*(df1$Species=="versicolor")) + (4*(df1$Species=="virginica")) )

samp1 = sample(x=1:nrow(df1), size=10, replace=TRUE, prob= (1*(df1$Species=="setosa")) + (2*(df1$Species=="versicolor")) + (4*(df1$Species=="virginica")) )
df1[ samp1 , ]


# Sample with replacement 20 values from df1, and find the mean of "Petal.Length" of the sample. Repeat the process for 100 iterations. Store the mean values inside "mean1" vector. The seed for each iteration is the iteration number itself.

mean1 = c()
for(i in 1:100) {
    set.seed(i)
    samp1 = sample(x=1:nrow(df1), size=50, replace=TRUE)
    mean1 = c(mean1, mean(df1[ samp1 , "Petal.Length" ]) )
}

# ************


