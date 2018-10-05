library(ggplot2)
str(cars)
plot(cars$speed, cars$dist, main="speed/dist", xlab = "mph", ylab = "ft", pch=1, col="blue")
summary(cars$dist)

data <- c(1,2,3,4,5,3,4,2,2,1)
mean(data) # 평
median(data) # 중간값

Nile
plot(Nile)

data <- read.csv("cafedata.csv", header = T, na.strings = "na", stringsAsFactors = F)
data
str(data)
g <- ggplot(data, aes(data$Coffees))
g2 <- g + geom_bar(fill="gray")
g2
g3 <- g2 + xlim(0, 50) + xlab("판매량") + ylab("횟수")
g3

data <- na.omit(data)
# 최소값 / 최대값
data$Coffees
sort(data$Coffees)[1]
sort(data$Coffees, decreasing = T)[1]
min(data$Coffees)
max(data$Coffees)

stem(data$Coffees)
data2 <- c(1,2,3,4,5,3,4,2,2,1)
stem(data2)
stem(data2, scale = 2)

rc <- table(cut(data$Coffees, breaks = seq(0, 50, by = 10), right = F))

rc
stem(rc, scale = 2)

# 평균 
w <- 1/length(data$Coffees)
w
sum(rc * w)
mean(rc)

# 중앙값
mean(rc, na.rm = T)
median(rc, na.rm = T)
data3 <- c(1,1,2,2,3,3,3,4,4)
mean(data3)
median(data3) # 중간에 있는 데이터(5번째)

height <- c(164, 166, 168, 170, 172, 174, 176)
height.m <- mean(height)
height.v <- var(height) # 분산
height.sd <- sd(height) # 표준편차 
height.m
height.v
height.sd

# 평균 / 표준
rc <- data$Coffees
rc.m <- mean(rc)
rc.m
rc.sd <- sd(rc)
rc.sd
cat("커피 판매량", round(rc.m, 1), "+-", round(rc.sd, 2), "잔")

par(mar=c(2,0,0,2))
x <- seq(-3, 3, by = 0.001)
plot(x, dnorm(x), type = 'l')

par(mar=c(2,0,0,2))
x <- seq(158, 182, by = 0.01)
plot(x, dnorm(x, mean=170, sd=4), type = "l", ylim = c(0,0.2))
plot(x, dnorm(x, mean=170, sd=2), type = "l", ylim = c(0,0.2))
plot(x, dnorm(x, mean=180, sd=2), type = "l", ylim = c(0,0.2))
lines(x, dnorm(x, mean=170, sd=2), lty = 2, lwd = 2)

qs <- quantile(rc)
qs
qs[4] - qs[2]

par(mar=c(2,2,2,2))
bp <- boxplot(rc, axes=T)
bp

md <- median(rc)
md


# mean, median, Quartile
# Range, Standard Deviation
# Variance
# Covariance
# Correlation, Coefficient


cars
cov(cars$speed,cars$dist)
colnames(faithful)
cov(faithful$eruptions, faithful$waiting)
cor(faithful$eruptions, faithful$waiting)


'''
1. example_studentlist.csv를 이용하여, 몸무게(height)에 대한
평균, 중앙값, 범위, 사분위, 분산, 표준편차를 구하고 
boxplot로 출력하시오.

2. example_salary.csv를 이용하여, 전국 연령별 평균 월급을 구하시오.
평균, 중앙값, 사분위, 범위를 구하고 4가지 값을 이름이 list.result라는 리스트에 입력하시오.

3. example_salary.csv를 이용하여, 그룹별 평균을 구하시오.
성별로 평균월급, 표준편차 및 그래프로 출력하시오.
경력별 평균월급, 표준편차 및 그래프로 출력하시오.
'''
library(magrittr)
library(dplyr)
#1
student <- read.csv("example_studentlist.csv")
student
mean(student$height)
median(student$height)
range(student$height)
quantile(student$height)
sd(student$height)
boxplot(student$height, axes = T)

#2
salary <- read.csv("example_salary.csv", stringsAsFactors = F)
str(salary)
class(salary$m_salary)
salary$m_salary <- as.integer(salary$m_salary)
names(salary) <- c("age", "m_salary", "s_salary", "hour", "workers", "carrer", "sex")
mean(salary$m_salary)

salary2 <- salary %>% group_by(age) %>% summarize(mean(m_salary, na.rm = T))
names(salary2)[2] <- "m_salary"
mean(salary2$m_salary)
median(salary2$m_salary)
quantile(salary2$m_salary)
range(salary2$m_salary)
list.result <- list(mean(salary2$m_salary), median(salary2$m_salary), quantile(salary2$m_salary), range(salary2$m_salary))
list.result

#3 
salary3 <- salary %>% group_by(sex) %>% summarize(mean(m_salary, na.rm = T))
salary4 <- salary %>% group_by(carrer) %>% summarize(mean(m_salary, na.rm = T))
salary3
salary4
g <- ggplot(salary3, aes(salary3$`mean(m_salary, na.rm = T)`))
g2 <- g + geom_bar(fill="gray")
g2
plot(salary3$sex, salary3$`mean(m_salary, na.rm = T)`)
plot(salary4$carrer, salary4$`mean(m_salary, na.rm = T)`)



############답 #############
library(ggplot2)
library(dplyr)
library(dplyr)

data <- read.csv("example_studentlist.csv")

# 1
mean(data$weight)
median(data$weight)
range(data$weight)
sd(data$weight)
var(data$weight)
#par(mfrow = c(2,2))
barplot(data$weight, names.arg = data$age)
plot(data$weight)
stem(data$weight, scale = 2)
data

#2 
data2 <- read.csv("example_salary.csv", na.strings = "-")
colnames(data2)
colnames(data2) <-
  c('age', 'salaryMonth', 'salaryYearSpecial',
    'timeWork', 'numberOfCompany', 'experiences', 'gender')

temp1 <- 
  aggregate(data2$salaryMonth ~ data2$age, 
            data2, mean)

temp2 <- aggregate(data2$salaryMonth ~ data2$age, 
                   data2, median)

temp3 <- aggregate(data2$salaryMonth ~ data2$age, 
                   data2, quantile)

temp4 <- aggregate(data2$salaryMonth ~ data2$age, 
                   data2, range)


list.results <- list(temp1, temp2, temp3, temp4)
list.results

# 3
temp5 <- aggregate(data2$salaryMonth ~ data2$gender, 
                   data2, mean)

temp6 <- aggregate(data2$salaryMonth ~ data2$gender, 
                   data2, sd)

temp7 <- aggregate(data2$salaryMonth ~ data2$experiences, 
                   data2, mean)

temp8 <- aggregate(data2$salaryMonth ~ data2$experiences, 
                   data2, sd)

temp5
temp6
temp7
temp8
ggplot(temp8, aes(x=temp8$`data2$experiences`,
                  y=temp8$`data2$salaryMonth`,
                  group=1)) + geom_bar(stat="identity")



'''
4. example_salary.csv를 이용하여 IQR을 구하시오.

5. example_cancer.csv를 이용하여 아웃라이어를 찾고 제거하시오.

6. example_salary.csv를 이용하여 평균값을 표준화 하여 그래프로 출력하시오.
'''

sort(cars$dist)
mean(cars$dist)
sd(cars$dist)
quantile(cars$dist)

q <- quantile(cars$dist)

ll <- q[2] - 1.5 * cars$dist
ul <- q[4] + 1.5 * cars$dist
ll
ul
cars$dist
boxplot(cars$dist, main="BoxPlot")

data3 <- c(1,2,3,4,3,2,1,1,200)
hist(data3)
boxplot(data3)

data <- read.csv("example_cancer.csv", na.strings = "-")
summary(data$age)
#1 
quantile(data$age)

#2
boxplot(data$age)
IQR(data$age, na.rm = T)
boxplot(data$age, range = 1.5)
location <- quantile(data$age, 
                     probs = c(0.25,0.75), na.rm=T)
down <- location[[1]]
up <- location[[2]]
down
up
outlier <- subset(data, 
                  subset=(data$age < down | data$age > up))
outlier

#3
data2 <- 
  aggregate(data$age ~ data$sex + data$age, data, mean)
data2

colnames(data2) <- c('gender', 'age')
library(varhandle)
library(ggplot2)
class(data2)
data3 <- data2
ggplot(data3, aes(x=data3$age, 
                  y=data3$gender,
                  fill=data3$gender)) 
+ geom_bar("identity")




