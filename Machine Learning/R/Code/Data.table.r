# Why Data.table
#   *Extremely Fast* in execution
#   Consistent and simply syntax for filter, groupby aggregate, select, and sort


library('data.table')

iris1 = as.data.table(iris)
iris1$Class = sample(c('a','b','c'), 150,replace=TRUE)

# Row Filtering
iris1[ Species=='setosa' & Petal.Length>0 ]
iris1[ Species=='setosa' & Petal.Length>0 ,  ]

iris1[1:2]
iris1[1:2,,]

# Sorting
iris1[order(Petal.Length, -Petal.Width)]


# return as vector
iris1[,Species]
# return as df
iris1[,list(Species)]
iris1[,.(Species)]
# return as df - alternative
iris1[,'Species']

# selecting more than 1 requires list
iris1[ , .(Petal.Length, Species) ]
iris1[ , list(Petal.Length, Species) ]

# renaming while selecting
iris1[ , .(a=Petal.Length, b=Species) ]

# aggregate all based on a condition
iris1[ Species=='versicolor' , result=sum(Petal.Length>4.5) ]
iris1[ Species=='versicolor' & Petal.Length>4.5 , length(Petal.Length) ]

# Aggregate with names
iris1[ Species=='versicolor' , result=sum(Petal.Length>4.5) ] # WRONG
iris1[ Species=='versicolor' , .(result=sum(Petal.Length>4.5)) ] # CORRECT
# Aggregate more than 1 column
iris1[ Species=='versicolor' , .(result1=sum(Petal.Length>4.5), result2=sum(Sepal.Width>2.5)) ] # CORRECT

# .N --> length
iris1[ Species=='versicolor' , .N ]

# Column name as vector
iris1[  , c('Petal.Length', 'Species') ]
# Column name as variable
cols = c('Petal.Length', 'Species')
iris1[  , ..cols ]
# WITH option alternative to ..
iris1[  , cols , with=FALSE ]
# more about with=FALSE later section

# NOT operator in data.table
iris1[ , !..cols ]
iris1[ , -..cols ]
iris1[ , !c('Petal.Length', 'Species') ]
iris1[ , -c('Petal.Length', 'Species') ]

# GroupBy and Aggregate
iris1[  , .N , by=Species]
iris1[  , .N , by=.(Species)]
iris1[  , .N , by=.(Species, Class)]
iris1[  , .(agg1=sum(Petal.Length), agg2=mean(Sepal.Length)) , by=.(Species)]
iris1[  , .(agg1=sum(Petal.Length), agg2=mean(Sepal.Length)) , by=.(Species)]
iris1[  , abc=sum(Petal.Length) , keyby=.(Species)] # WRONG - when groupby aggregate, the aggregate columns should be as list
iris1[  , .(abc=sum(Petal.Length)) , keyby=.(Species)] # Correct
iris1[  , abc:=sum(Petal.Length) , keyby=.(Species)] # WRONG - you can see the duplicates. 1. := not allowed when groupby+agg. 2. agg should present as a list
iris1[  , .(abc:=sum(Petal.Length)) , keyby=.(Species)] # WRONG - := not allowed for group by and aggragete
iris1[  , abc=sum(Petal.Length) , keyby=.(Species)] # Wrong - need to provide as a list

iris1[  , .(abc=sum(Petal.Length/Sepal.Length)), by=Species] # Correct
# Cross Validation
iris1$Col2 = (iris$Petal.Length / iris$Sepal.Length); iris1[  , .(sum(Col2)) , by=Species ]

iris1 = as.data.table(iris)
iris1$Class = sample(c('a','b','c'), 150,replace=TRUE)

# Find count of NAs for each class
iris[is.na(Sepal.Length), .N, by = Species]


# Sort by groupin columns (faster than 'by')
iris1[  , .N , keyby=.(Species)]

# Chaining - makes execution faster. Another good example much below
iris1[ Petal.Length>0 , .(agg1=.N) , by=.(Species,Class) ][order(Species, -Class)]
iris1[ Petal.Length>0 , .(agg1=.N) , by=.(Species) ][order(Sepal.Length, -Sepal.Width)] # WRONG - you can sort only on the group by column obviously

# Group by based on a condition
iris1[  , .(agg1=.N, agg2=sum(Sepal.Length)) , by=.(Species=='setosa', Class=='a') ]

# GroupBy Species and Class, and aggregate all other columns
iris1[  , lapply(.SD, mean) , by=.(Species, Class) ]
# GroupBy Species and Class, and aggregate Sepal.Length, and Petal.Length
iris1[  , lapply(.SD, mean) , by=.(Species, Class) , .SDcols=c('Sepal.Length', 'Petal.Length') ]
# GroupBy Species and Class, and aggregate all cols except Sepal.Length, and Petal.Length
iris1[  , lapply(.SD, mean) , by=.(Species, Class) , .SDcols=-c('Sepal.Length', 'Petal.Length') ]
# WRONG Implementation -- needs to be given as vector
iris1[  , lapply(.SD, mean) , by=.(Species, Class) , .SDcols=.(Sepal.Length, Petal.Length) ]

iris1[  , c(Petal.Length, Sepal.Length)  , by=Species ]


## Reference semantics
# BEST LINK BELOW
# http://127.0.0.1:22968/library/data.table/html/assign.html

# 

iris1 = as.data.table(iris)
iris1$Class = sample(c('a','b','c'), 150,replace=TRUE)
iris2 = iris1
head(iris1)
head(iris2)



iris1[ , c('ColA', 'ColB') := .(1:150, (1:150)+200) ]
iris1[ , `:=` (ColA=1:150, ColB=(1:150)+200) ]
head(iris1)
head(iris2)

# The below not only has the Reference relationship, but also causes the 2 variables to become completely independent
iris1$Col1 = 5
iris1$Col2 = 7
head(iris1)
head(iris2)
# Because now iris1 and iris2 are not linked to each other at all
iris1[ , c('ColA', 'ColB') := .(1, 3) ]
head(iris1)
head(iris2)

# 
iris1 = as.data.table(iris)
iris1$Class = sample(c('a','b','c'), 150,replace=TRUE)

iris2 = copy(iris1)

# Assign based on Condition -- only selected rows are changed.
iris2[ Species=='setosa' ,  Col2:=456 ]
# Assign based on Condition -- new df is created -- first df filtered, then new col created
iris2 = copy(iris1)
iris2[ Species=='setosa' ] [ , Col2:=456 ]

# Delete Column - assign NULL to it
iris2[  , Col1:=NULL ]
iris2[  , "Col1":=NULL ]

# Assigning Based on Group By - -Careful, this does will create redundancy
iris1[  , Col1:=sum(Sepal.Length) , by=.(Species, Class) ] # Wrong


# Creating new column based on calculation. ".() syntax is used for GroupBy and Aggregate only, and not for creating calculated columns"
iris1[ , .(Total:=5) ] # Wrong
iris1[ , Total:=5) ] # Correct

iris1[  , .(Total:=apply(iris1[,1:4], 1, sum)) ] # Wrong
iris1[  , Total:=apply(iris1[,1:4], 1, sum) ] # Correct

# Adding multiple columns
iris1[ , c('a', 'b', 'c') := .(1, 3, 5)]
iris1[ , `:=` (ColA=1:150, ColB=(1:150)+200) ]

# Chaining - # http://127.0.0.1:22968/library/data.table/html/assign.html
# DT[a > 4, b := c] is different from DT[a > 4][, b := c]. The first expression updates (or adds) column b with the value c on those rows where a > 4 evaluates to TRUE. X is updated by reference, therefore no assignment needed. The second expression on the other hand updates a new data.table that's returned by the subset operation. Since the subsetted data.table is ephemeral (it is not assigned to a symbol), the result would be lost; unless the result is assigned, for example, as follows: ans <- DT[a > 4][, b := c].


# 


iris1[,Total:=NULL]
iris1[ Species=='setosa' , Total:=5 ]

iris1[,Total:=NULL]
iris1 = iris1[ Species=='setosa'][ , Total:=5]
# Remember that 
iris1[ Species=='setosa'][ , Total:=5] # will not add Total to iris1.
iris1[ Species=='setosa'][ , Total:=5][] # will print the output

# 

iris1 = as.data.table(iris)
iris1$Class = sample(c('a','b','c'), 150,replace=TRUE)

# Renaming GroupBy Column causes issues - (especially if that column is present for aggregation) -- Below 2 examples tells you why ***
iris1[ , .(abc=sum(Species=='versicolor')), keyby=.(Species=substr(Species, 1, 3)) ] # Wrong
iris1[ , .(abc=sum(Species=='versicolor')), keyby=.(    abc=substr(Species, 1, 3)) ] # Correct


##################

# How to use "with=FALSE" & Column Operation

# with = FALSE disables the ability to refer to columns as if they are variables

# 

iris1 = as.data.table(iris)
iris1[  , colnames(iris1)[1:4] :=   iris1[  , colnames(iris1)[1:4] , with=FALSE ] + 5  ] # Correct
iris1[  , colnames(iris1)[1:4] :=   iris1[  , colnames(iris1)[1:4]              ] + 5  ] # Wrong
iris1


# Column name as vector
iris1[  , c('Petal.Length', 'Species') ]
# Column name as variable
cols = c('Petal.Length', 'Species')
iris1[  , ..cols ]
# WITH option alternative to ..
iris1[  , cols , with=FALSE ]


# with=FALSE needs to be used when df is recursively used 
iris1 = as.data.table(iris)
iris1[  , colnames(iris1)[1:4] :=   iris1[  , colnames(iris1)[1:4] ] + 5  ] # Wrong
iris1[  , colnames(iris1)[1:4] :=   iris1[  , colnames(iris1)[1:4] , with=FALSE ] + 5  ] # Correct

# New vs Old method with=FALSE
iris1 = as.data.table(iris)
tmp1 = "Species"
iris1[  ,  tmp1  := substr(iris1[[tmp1]], 1, 2) , with=FALSE ] # Correct - but throws warnings
iris1[  , (tmp1) := substr(iris1[[tmp1]], 1, 2)  ] # Correct - seems to be new method

# Important **
iris1 = as.data.table(iris)
iris1[  , -c(1,ncol(iris1)) ] #Wrong
iris1[  , -c(1,ncol(iris1)) , with=FALSE ] #Correct
iris1[  , -c(1,5) ] # Correct


iris1 = as.data.table(iris)
iris1[ , .(Species='a') ] [] # Wrong
iris1[ , Species := 'a' ] [] # Correct

# Adding multiple Calculated Column requires atleast 1 column of table to be selected
iris1 = as.data.table(iris)
iris1[ , .("a"=5, "b"=6) ] [] # Wrong - will have only 1 row
iris1[ Species=='setosa' , .("a"=5, "b"=6, Sepal.Length) ] [] # Correct, because atleast 1 column of table needs to be present

# operation on certain columns of the dataframe
iris1 = as.data.table(iris)
iris1[  , dateCols := lapply(iris1[,dateCols,with=FALSE], as.Date, tz="Australia/Brisbane"), with=FALSE ]



##################

# Converting into data.table

iris1 = as.data.table(iris)
# converts into a normal data frame by reference
iris1 = setDF(iris)
# setDT converts by reference (converts the existing variable), and hence the below will throw an error because iris cannot be converted as it is part of R tool
iris1 = setDT(iris)


##################


flights = fread("https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv")

colnames(flights)




# Data.table doesn't use row names. If we select row.names =TRUE during import it will import the row names as a column


# Resources
# https://cran.r-project.org/web/packages/data.table/vignettes/

# GOOD FAQ
# https://cran.r-project.org/web/packages/data.table/vignettes/datatable-faq.html

