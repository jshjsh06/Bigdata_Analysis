install.packages("UsingR")
library(UsingR)
# galton # 부모키/자식키
str(galton)
head(galton, 5)
# par(mfrow=c(1,2))
hist(galton$child)
hist(galton$parent)
cor(galton$child, galton$parent)
options(scipen = 999)
cor.test(galton$child, galton$parent)
xtabs(~child+parent, data=galton)
lm(child ~ parent, data=galton)
# y = 0.6463x + 23.9415
lm_data <- lm(child ~ parent, data=galton)
summary(lm_data)
plot(child ~ parent, data=galton)
abline(lm_data, col="blue")

library(ggplot2)
g <- ggplot(data=galton, aes(x=parent, y=child))
g1 <- g + geom_smooth(method="lm") + geom_point()
g1

'''
www.koreabaseball.com
=> example_kbo2015.csv

1. 안타와 홈런 변수를 활용한 회귀분석을 하시오.
안타(H), 홈런(HR)

'''
data1 <- read.csv("example_kbo2015.csv")
data1
str(data1)
data1$H
data1$HR
cor(data1$H, data1$HR)
plot(HR ~ H, data=data1)
lm_data2 <- lm(HR ~ H, data=data1)
lm_data2
abline(lm_data2, col="red")


