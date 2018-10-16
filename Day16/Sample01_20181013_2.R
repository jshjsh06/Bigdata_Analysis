#install.packages("tidyverse")
library(tidyverse)
library(ggpubr)
theme_set(theme_pubr)
install.packages("devtools")
library(devtools)
devtools::install_github("kassambara/datarium")
data("marketing", package="datarium")
# youtube에서 한해에 지출한 광고 예산에 따른
# 판매를 예측하고 싶다.
head(marketing,3)
library(ggplot2)
g <- ggplot(marketing, aes(x=youtube, y=sales))
g1 <- g + geom_point()
g1
# 단순 선형 회귀 분석을 하시오.
# sales = b0 + b1 * youtube
cor(marketing$sales,
    marketing$youtube)
# 양에 상관관계 
model <- lm(sales ~ youtube,
            data=marketing)
model
# sales = 8.44 + 0.047*youtube
g <- ggplot(marketing, aes(x=youtube, y=sales))
g1 <- g + geom_point() + stat_smooth(method=lm)
g1
summary(model)
# Multiple Regression
library(car)
library(corrplot)
library(visreg)
library(rgl)
library(knitr)
library(scatterplot3d)
summary(Prestige)
colnames(Prestige)
newdata <- Prestige[,c(1:4)]
newdata
dim(newdata)
plot(newdata, pch=16, col="blue")
education.c <- scale(newdata$education, 
           center = T, 
           scale = T)
prestige.c <- scale(newdata$prestige,
          center = T,
          scale = T)
women.c <- scale(newdata$women,
                    center = T,
                    scale = T)
new.vars <- cbind(education.c, 
                  prestige.c,
                  women.c)
newdata <- cbind(newdata, new.vars)
head(newdata,1)
names(newdata)[5:7] = c('education.c',
                        'prestige.c',
                        'women.c')
View(newdata)
summary(newdata)
# linear mode
# eduction.c, prestige.c, women.c -> income
model2 <- lm(income ~ education.c + 
               prestige.c + women.c,
             data=newdata)
model2
summary(model2)
newdatacor = cor(newdata[1:4])
newdatacor
par(mfrow=c(1,1))
corrplot(newdatacor, method="number")
plot(model2)
model3 <- lm(income ~ prestige.c + 
               women.c, data=newdata)
newdat <-
  expand.grid(
    prestige.c=seq(-35,45,by=5),
    women.c=seq(-25,70,by=5))
newdat$pp <-
  predict(model3, newdata=newdat)
colnames(newdat)
head(newdat)
with(newdata, plot3d(
  prestige.c,
  women.c,
  income,
  col="blue",
  size=1,
  type="s"
))
with(newdat, surface3d(
  unique(prestige.c),
  unique(women.c),
  pp, alpha=0.3, 
  front="line", 
  back="line"
))
colnames(newdat)

# 키 몸무게 회귀 example_studentlist.csv
# summary
# 잔차(Residuals)
df <- read.csv("example_studentlist.csv")
head(df, 3)
lm_data <- lm(height ~ weight, data=df)
lm_data
par(mfrow=c(1,1))
plot(height ~ weight, data=df)
abline(lm_data, col="red")
summary(lm_data)
par(mfrow=c(2,2))
plot(lm_data)












