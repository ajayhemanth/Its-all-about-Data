# read data from csv file
read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE)


df1 = read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE)

df1 <- read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE)

read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE) -> df1

# Comments are not executed

# View contents of table
View(df1)

# Note: iris dataset is present in R by default in a variable called "iris" - just type View(iris) to understand what i'm saying. we imported it again from a web location just to understand how to import a dataset into R.




# Data Frame

# dataFrame_variable_name[ select rows , select columns ]

df1[ , "Sepal.Length" ]

df1[ , c("Sepal.Length","Species") ]

df1[ , c(1,5) ]

df1[ , c(TRUE,FALSE,FALSE,FALSE,TRUE) ]



df1[ c(1,2,3,4,5) , ]
df1[ 1:5 , ]

# df1[ c("name1","name2",...) , ]

df1[,"Species"]

df1[,"Species"] == 'setosa'

df1[ df1[,"Species"]=='setosa' , ]

# df1[ condition1 & condition2 & ... , ]
df1[ (df1[,"Species"]=='setosa') & ( df1[,"Sepal.Length"] >= 5.5 ) , ]


df1[,"Species"]
df1$Species


df1[ c(1,2,3,4,5) , "Species" ]
df1[ 1:5 , "Species" ]

nrow(df1)

df1[ 10 : nrow(df1) , ]

length(df1)

df1[  , 3 : length(df1) ]

df1[ , -5 ]

# df1[ , -(1:3) ] exclude first 3 columns

df1[ -1 , ]


# RECAP
# dataFrame_Variable[ select rows , select columns ]
# select using "Index", "Names", "TRUE/FALSE"

c(1,2,3,4,5)
1:5

c("Sepal.Length","Species")

c(TRUE,FALSE,FALSE,FALSE,TRUE)

df1[,"Species"]
df1$Species

is.vector(df1$Species)
is.vector(1:5)

# vector_variable[ select elements ]
# VECTOR of "Index", "Names", "TRUE/FALSE"

vector1 = 15:25

vector1

vector1[ 1:5 ]

# vector1[ c("name1", "name2", ...) ]

vector1[ vector1>20 ]

vector1>20

# vector_variable[ select elements ]

data1 = 5

is.vector(data1)

c(data1, 1:5, 15, vector1, df1$Sepal.Length)

c(1,2,'b','c')

length(vector1)

# Matrix

matrix(1:9, ncol=3)

mat1 = matrix(1:9, ncol=3)

t(mat1)

det(mat1)


row.names(df1)
colnames(df1)

colnames(mat1)
row.names(mat1)

colnames(mat1) = c('a','b','c')
row.names(mat1) = c("row1","row2","row3")

mat1[ c("row1") , c('a','c') ]

names(vector1) = c('a','b','c','d','e','f','g','h','i','j')
vector1
vector1['c']




mean(df1$Sepal.Length)
sum(vector1)
median(vector1)
summary(vector1)



# UDF

fun1 = function() {
    print("Hello")
}

fun1()

fun2 = function(m1,v1) {
    r1 = det(m1) + mean(v1)
    return (r1) ;
}

fun2(mat1,vector1)


# List

l1 = list()

l1[[1]] = df1

l1[[2]] = vector1

l1[[3]] = mat1

l1[[2]]

l1[[3]]

# list_variable [[ <select elements> ]]

# l1[["name"]]


names(l1)
names(l1) = c("data frame", "vector", "matrix")
l1[["matrix"]]



fun2 = function(m1,v1) {
    r1 = det(m1) + mean(v1)
    r2 = list()
    r2[[1]] = m1 ;
    r2[[2]] = v1 ;
    r2[[3]] = r1 ;
    return (r2) ;
}

fun2(mat1,vector1)

result1 = fun2(mat1,vector1)

result1[[2]]



# Apply Functions

# mean(df1$Sepal.Length)
# sum(vector1)
# median(vector1)
# table(vector1)


apply(df1[,1:4] , 2 , mean)

apply(df1[,1:4] , 1 , sum)

apply(mat1 , 2 , sum)
apply(mat1 , 1 , sum)

apply(df1[,1:4] , 2 , function(x) { 
        r1 = mean(x)/median(x) ;
        return(r1) ;
    } 
)


# lapply

l2 = list()
l2[[1]] = 1:5
l2[[2]] = 11:15
l2[[3]] = 21:25

lapply(l2, mean)

sapply(l2, mean)

tapply(df1$Sepal.Length, df1$Species, mean)

aggregate(df1[,1:4], by=list(df1$Species), mean)
# aggregate( . ~ Species , df1 , mean )
# aggregate( Sepal.Width ~ Species , df1 , mean )





#  if-else condition

fun2 = function(x) {
    if(is.vector(x)) {
        return(sum(x)) 
    } else {
        print("Not a vector")
    }
}

fun2(vector1)
fun2(df1)

# Loops

# print Hello 10 times
var1 = 10
while( var1 > 0 ) {
    print( paste("Hello" , var1) )
    var1 = var1 - 1 ;
}

# Example - 2 for while loop

# iterate throgh elements of list, and print sum of each vector element of list
l2 = list()
l2[[1]] = df1
l2[[2]] = vector1
l2[[3]] = df1$Sepal.Length
l2[[4]] = df1$Petal.Length

var1 = 1
while( var1 <= length(l2) ) {
    if( is.vector(l2[[var1]]) ) {
        print( sum(l2[[var1]]) )
    }
    var1 = var1 + 1 ;
}

# For Loop

# print Hello 10 times
for(var1 in 1:10) {
    print(paste("Hello",var1))
}


# iterate throgh elements of list, and print sum of each vector element of list
for(var1 in l2){
    if(is.vector(var1)) {
        print(sum(var1))
    }
}


# Additional Data Frame operation

df1$Col1 = df1$Sepal.Length + 10
df1$Col2 = df1$Sepal.Length + df1$Petal.Length

df1[ df1$Species=='setosa'  , "Sepal.Length" ] = 0

View(df1)

del1 = rbind(df1, df1)
View(del1)

del1 = cbind(df1, df1)
head(del1)

df1 = read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE)

?read.csv

?mean

?merge

# df1$id = 1:150
# merge1 = merge(x=df1, y=df1, by.x="id", by.y="id")
# View(merge1)

# Plots

plot(1:10, 1:10)

plot(1:10, 1:12)

plot(df1$Sepal.Length, df1$Petal.Length)


## Factors 

# find the count of each category in a vector
table(df1$Species)

barplot( table(df1$Species) )

df1 = df1[ df1$Species != "setosa" , ]

barplot( table(df1$Species) )

df1 = read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE)

str(df1)

df1$Species = as.factor( df1$Species )

str(df1)

df1 = df1[ df1$Species!="setosa" , ]
barplot( table(df1$Species) )
table(df1$Species)

# as.factor()
# as.character()
# as.numeric()
# as.integer()

"5" + 5
as.numeric("5") + 5


df1 = read.csv("https://raw.githubusercontent.com/ajayhemanth/Its-all-about-Data/master/Machine%20Learning/R/Dataset/iris.csv", header=TRUE, stringsAsFactors=TRUE)

str(df1)


# Packages

install.packages("plotly")

library(plotly)

fig <- plot_ly(data = df1, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species, colors = "Set1")

fig



# 1. find square root of numbers from 1 to 5
# 2. round the square roots to whole number
# 3. find the sum of the rounded number

sum(round(sqrt(1:5)))

install.packages("dplyr")
library("dplyr")

1:5 %>% sqrt %>% round %>% sum

# ************



# ALL R packages



