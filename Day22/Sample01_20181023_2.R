library(shiny)
library(tidyverse)
library(shinydashboard)
library(rvest)
#install.packages("shinydashboard")
url <-
  read_html("https://coinmarketcap.com/gainers-losers/")
myurl <- html_table(url)

myurl[[1]]
# 1. % remove, convert numeric 1h
# 2. Symbol -> factor

data <- myurl[[1]]
data$`% 1h` <- gsub("%", "", data$`% 1h`)
data$`% 1h` <- as.numeric(data$`% 1h`)
data$Symbol <- as.factor(data$Symbol)
str(data)
View(data)

ui <- dashboardPage(
  # header
  dashboardHeader(title="코인정보"),
  dashboardSidebar(
    h5("방가워요."),
    br()
  )


)




class(myurl)
class(myurl[[1]])
length(myurl)
View(myurl[[1]])
View(myurl[[2]])
View(myurl[[3]])

View(myurl[[4]])
View(myurl[[5]])
View(myurl[[6]])
