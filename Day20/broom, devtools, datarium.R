library(tidyverse)
#install.packages("broom")
library(ggplot2)
library(broom)
install.packages("devtools")
library(devtools)
install_github("kassambara/datarium", 
               force=TRUE)

theme_set(theme_classic())
data("marketing", package="datarium")
#sample_n(marketing,3)
#head(marketing,2)
myModel <- lm(sales ~ youtube, 
              data=marketing)
myModel
# sales = 8.43 + 0.047*youtube
library(broom)
myData <- broom::augment(myModel)
g <- ggplot(myData,aes(youtube, sales)) 
g1 <- g + geom_point()
g2 <- g1 + stat_smooth(method=lm,
                       se=FALSE)
g3 <- g2 + geom_segment(
  aes(xend = youtube, yend = .fitted),
  color="red", size=0.3)
g3
par(mfrow = c(2,2))
plot(myModel)
summary(myModel)
par(mfrow = c(1,1))
plot(myModel, 1)

