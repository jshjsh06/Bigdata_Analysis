data <- read.csv("input.csv")
class(data)
data
max(data$salary)
subset(data, salary == max(data$salary))
subset(data, dept == "IT")
subset(data, salary > 600 & dept == "IT")

theURL <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file = theURL, header = TRUE, sep = ",")
tomato

install.packages("readr")
library(readr)
tomato2 <- read_delim(file = theURL, delim = ',')
tomato2

install.packages("data.table")
library(data.table)
tomato3 <- fread(input = theURL, sep = ",", header=TRUE)
head(tomato3)

class(tomato3)

location <- "flights"
flight <- read_delim(file = "../flights.csv", delim = ',')
head(flight)
str(flight)
unique(flight$AIRLINE)
table(flight$YEAR, flight$MONTH)

flight2 <- fread(input = "../flights.csv", sep = ",", header=TRUE)
head(flight2)
