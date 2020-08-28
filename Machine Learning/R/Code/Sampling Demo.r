
# Place your answer here (Sample Solution)
clean1 = read.csv("datasets/unclean1.csv", header=FALSE)
d1 = read.csv("datasets/iris1.csv", header=TRUE)

# Place your answer here
header  <- nrow(clean1)
clean1[-nrow(clean1),] 

# Place your answer here
datatype1 <- d1
is.numeric(datatype1$Sepal.Length)
is.numeric(datatype1$Sepal.Width)
is.numeric(datatype1$Petal.Length)
is.numeric(datatype1$Petal.Width)
is.character(datatype1$Species)
as.character(datatype1$Species)

# Place your answer here
sum_narm = mean(clean1$Petal.Width, na.rm = TRUE)

# Place your answer here
clean2 = d1
na.omit(clean2)

# Place your answer here
library("jsonlite")
jsonresult <- read_json(datasets/iris3.json)
tempdf1 <- as.data.frame(jsonresult)
tempdf2 = read.csv("datasets/iris4.csv", header=TRUE)
rbind1 <- rbind(tempdf1, tempdf2)

# Place your answer here
select_1a <- head(d1,n=5)
select_1b <- tail(d1,n=10)
select1 = rbind(select_1a , select_1b)

# Place your answer here
select2 <- d1
select2 = select2[ select2[,"Species"]!='versicolor' , ]

# Place your answer here
select3 <- d1
select3$Petal.Length[select3$Species == 'setosa'] = 0

# Place your answer here
str(select2)
select2$Species = as.factor( select2$Species )
print(select2$Species)
count1 <- table((select2$Species == "setosa"), 
                (select2$Species == "versicolor"),
                (select2$Species == "virginica"))

# Place your answer here
fun1 = function(x1, x2){
        r1 = det(x1) + det(x2)
        return (r1) ;
}

# Place your answer here
sum1 <- sum(d1$Sepal.Length)

# Place your answer here
fun2 = function(x) {
    if(is.numeric(x)) {
        return(sum(x)/ median(x)) 
    } else {
        print("Not numeric")
    }
}
apply1 <- apply(d1[,1:ncol(d1)],2,fun2)
is.numeric(d1$Sepal.Length)

# Place your answer here
agg1 <- aggregate(Sepal.Width ~ Species, d1, 
                  by=list(d1$Species), FUN = "sum", 
                  colnames(d1) == c[1:5],
                  row.names(d1) == c[d1$Species] )

# Place your answer here
source("script1.R")

# Place your answer here
fun1 = function(x1, x2){
        r1 = det(x1) + det(x2)
        r2[[1]] = x1;
        r2[[2]] = x2;
        r2[[3]] = r1;
        return r2;
}

# Place your answer here
lapply1 <- lapply(script1$list1(),function(x){
        if(is.matrix(x)){
            r1 = det(x)
            print(sum(r1))}})
sapply1 <- sapply(script1$list1(),function(x){
        if(is.matrix(x)){
            r1 = det(x)
            print(sum(r1))}})

# Place your answer here
var1 = 0
for1 <- for(var1 in script$list1){
    if(is.matrix(var1)) {
        print(sum(var1))
    }
}

while1 <- while(var1<=length(script$list1)){
        r1 = det(var1)
        return(sum(var1))
}

# Place your answer here
set.seed(55)
sample1 = sample(x=1:nrow(d11), size=80, replace = FALSE)
sample2 = sample(x=1:nrow(d11), size=80, replace = TRUE)

# Place your answer here
set.seed(55)
sample3 = sample(x=1:nrow(d1), size=80, replace=TRUE, 
               prob= (1*(d1$Species=="setosa")) + 
               (2*(d1$Species=="versicolor")) + 
               (4*(d1$Species=="virginica")) )

# Place your answer here
weighted_iterative = c()
for(i in 1:100) {
    set.seed(i)
    sample3 = sample(x=1:nrow(d1), size=80, replace=TRUE
                     prob= (1*(d1$Species=="setosa")) + 
                           (2*(d1$Species=="versicolor")) + 
                           (4*(d1$Species=="virginica")))
    weighted_iterative = c(weighted_iterative, mean(d1[ sample3 , "Sepal.Length" ]) )
}

# Place your answer here
set.seed(55)
stratified_setosa = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="setosa"))
stratified_versicolor = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="versicolor"))
stratified_virginica = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="verginica"))

# Place your answer here
setosa_mean = c()
versicolor_mean = c()
virginica_mean = c()
for (i in 1:100) {
    set.seed(i)
    stratified_setosa = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="setosa"))
    stratified_versicolor = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="versicolor"))
    stratified_virginica = sample(x=1:nrow(d1), size=10, replace=TRUE, prob=1*(d1$Species=="verginica"))
    setosa_mean = c(setosa_mean, mean(d1[ stratified_setosa , "Sepal.Length" ]) )
    versicolor_mean = c(versicolor_mean, mean(d1[ stratified_versicolor , "Sepal.Length" ]) )
    virginica_mean = c(virginica_mean, mean(d1[ stratified_virginica , "Sepal.Length" ]) )
}
