# 403
# Simple Linear Regression
cars$speed
cars$dist
cars
m <- lm(dist ~ speed, data=cars)
m
summary(m)
coef(m)
# fitted value
fitted(m)
residuals(m)
r <-fitted(m) + residuals(m)
cars$dist
confint(m)
deviance(m)
predict(m, newdata = data.frame(speed=3))
summary(m)
options(scipen = 999)
anova(m)
summary(m)
m2 <- lm(dist ~ 1, data=cars)
summary(m2)
anova(m, m2)
# page 404
par(mfrow = c(2,2))
plot(m)
par(mfrow = c(1,1))
with(cars, plot(speed, dist))
plot(cars$speed, cars$dist)
abline(coef(m))
# page 404
# VIF(Variance Inflation Factor)
# 분산팽창계수
install.packages("car")
library(car)
#car::vif()
library(MASS)
library(tidyverse) # 데이터 변환..
library(caret) # 기계학습 
library(magrittr)
set.seed(123)
train.samples <- 
  Boston$medv %>%  
  createDataPartition(p=0.8, list=F)
train.data <- Boston[train.samples,]
test.data <- Boston[-train.samples,]

myModel <-
  lm(medv ~ ., data=train.data)
predictions <-
  myModel %>% 
  predict(test.data)
predictions
summary(myModel)
vif(myModel)


ifelse


