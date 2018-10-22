#install.packages("googlesheets")
#install.packages("DT")
#install.packages("pander")
rm(list=ls())
knitr::opts_chunk$set(message = FALSE, echo = TRUE)
suppressWarnings(suppressMessages(library(googlesheets)))
library(RCurl)
library(tidyr)
library(dplyr)
library(knitr)
library(ggplot2)
library(DT)
library(pander)
library(Matrix)
library(recommenderlab)
suppressWarnings(suppressMessages(library(recommenderlab)))
data(MovieLense, package = "recommenderlab")
movielense <- MovieLense
moviemeta <- MovieLenseMeta
pander(head(moviemeta), caption = "Movie Meta Data")

View(movielense)
View(moviemeta)
class(moviemeta)
class(movielense)
nrow(movielense)
ncol(movielense)


df <- movielense
df_m <- df[rowCounts(movielense) > 20, colCounts(movielense) > 50]
df_min <- min(rowCounts(df_m))
nrow(df_m)
ncol(df_m)

set.seed(101)
s <- train.data <- sample(x=c(TRUE,FALSE), size= nrow(df_m),prob = c(0.8,0.2), replace =  T)
train.data2 <- df_m[s,]
test.data2 <- df_m[!s,]
train.data
test.data2

#IBCF
myModel <- Recommender(
  data= train.data2, method = "IBCF",
  parameter = list(k=25, method = "Cosine")
)
myModel

num <- 10
myResult <- predict(object = myModel, newdata = test.data2, n = num)
myResult

myResult2 <- data.frame(user=sort(rep(1:length(myResult@itmes))),
                                  rating = unlist(myResult@ratings),
                                  index=unlist(myResult@items))
                                  