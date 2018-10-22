#install.packages("googlesheets")
#install.packages("DT")
#install.packages(pander)
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
suppressWarnings(suppressMessages(library(recommenderlab)))
data(MovieLense, package = "recommenderlab")
movielense <- MovieLense
moviemeta <- MovieLenseMeta
pander(head(moviemeta), caption = "Movie Meta Data")
# View(movielense)
# View(moviemeta)
# class(movielense)
# nrow(movielense)
# ncol(movielense)
# nrow(moviemeta)
# ncol(moviemeta)
# pander(head(moviemeta), caption = "Movie Meta Data")

df <- movielense
df_m <- df[rowCounts(movielense) > 20, colCounts(movielense)>50]
df_min <- min(rowCounts(df_m))
nrow(df_m)
ncol(df_m)

set.seed(101)
train.data <- 
s <- sample(x=c(TRUE, FALSE), size=nrow(df_m),         replace = T,
         prob=c(0.8, 0.2))
str(s)
train.data2 <- df_m[s,]
test.data2 <- df_m[!s,]
train.data2
test.data2
# IBCF
myModel <- Recommender(
  data=train.data2, method="IBCF",
  parameter=list(k=25, method="Cosine")
)
num <- 5
myResult <- predict(object=myModel,
                    newdata=test.data2, n=num)
myResult2 <-
  data.frame(
    user=sort(rep(1:length(myResult@items))),
    rating=unlist(myResult@ratings),
    index=unlist(myResult@items))
myResult2

myResult2$title <- 
  myResult@itemLabels[myResult2$index]
myResult2$year <-
  moviemeta$year[myResult2$index]

myResult3 <- myResult2 %>% group_by(user) %>% 
  top_n(5, rating)
datatable(myResult3[myResult3$user %in% (1:10),])

  
  










