# Probability(확률)
# 1.어떤 실험을 통해서 나는 결과를 
#   알지 못하는 경우
# 2. 결과를 알지 못하지만, 결과로 나타
#   날수 있는 가능성이 있은 경우
# 3. 동일한 실험을 몇번이고, 반복할 수 있음

# 표본공간, 사건
# 사건 - 합사건, 곱사건, 여사건, 배반사건,
#        독립사건

# 예)동전
# 확률실험, 표본공간, 사건
# 동전을 2번 던져 나오는 면을 확인
# 표본공간 => HH, HT, TH, TT
# 사건 => 첫번째 동전이 앞이 나올확률
#         HH, HT

# 예) 인터넷 사용시간
# 하루중 인터넷 사용시간을 관찰
# 표본공간 => 0 <= t <= 24
# 사건 => 사용시간이 1시간 이하인 사건 
#         0 <= t < 1

# N번 반복
# A사건발생 : n
# A사건 발생 확률 : P(A) = n/N

library(prob)
tosscoin(2)
rolldie(1)
urnsamples(1:3, size=2)
urnsamples(1:3, size=2, replace = T)
# 문자R3개, 문자B2구성. 
urnsamples(c(rep("R",3),
             rep("B",2)),
           size=2)
# 동전을 두번 던졌을때 나올 확률..
tosscoin(2, makespace = T)
tosscoin(3, makespace = T)

# 동전을 2번을 던졌을때 앞면이 나오는 
# 횟수
tosscoin(2)
# HH 2 1/4
# TH 1 1/4 => 2/4 => 1/2
# HT 1 1/4
# TT 0 1/4

x <- c(0, 1, 2)
px <- c(1/4, 2/4, 1/4)
Ex <- sum(x * px)

# 동전을 25번 던졌들때 19번이 
# 나올 확률은?
options(scipen = 999)
probability_value <- .5
wins <- 19
flips <- 25
dbinom(wins, flips, probability_value)
dbinom(1:18, flips, probability_value)

pbinom(wins-1, flips, probability_value)
1-pbinom(wins-1, flips, probability_value)

# 0:25
library(ggplot2)
wins <- c(0:25)
totalFlips <- 25
probability_value <- .5

x1 <- 1-pbinom(wins-1, totalFlips, 
               probability_value)
x1
x2 <- dbinom(wins, totalFlips, 
             probability_value)
data <-
  data.frame(wins1 = x1, prob_value = x2)
data
library(ggplot2)
ggplot(data, aes(x=wins, y=x2)) + geom_point() + geom_line()

# 이산확률변수, 연속확률변수,
# 이항분포...
# 연속확률분포...

# 확률변수 X가 시행의 횟수가 6이고
# 확률이 1/3인 이항분포를 따를때 

n <- 6
p <- 1/3
x <- 0:n
# dbinom(x, size, prob)
# x : 이항분포의 성공 횟수의 벡터
# size : 시행의 횟수
# prob : 성공의 확률
dbinom(2, size=n, prob=p)
dbinom(4, size=n, prob=p)
# 성공횟수, 확률
px <- dbinom(x, size=n, prob=p)
plot(x, px, type="s",
     xlab="성공횟수(x)",
     ylab="확률(P(X=x))",
     main="B(6, 1/3)")

# 이항분포 누적함수
# pbinom(x, size, prob)
# x : 이항분포의 성공횟수
# size : 시행의 횟수
# prob : 성공의 확률
pbinom(2, size=n, prob=p)
# 성공횟수가 2이하일 확률
pbinom(4, size=n, prob=p)
# 성공횟수가 4이하일 확률
pbinom(4, size=n, prob=p) 
  pbinom(2, size=n, prob=p)
# 확률(P(2<X<=4))

#1.동전 1000번 던져 490번 앞면이 
#  나올확률은?
dbinom(490, size=1000, prob=.5)
#2.흡연률이 25%로 알려진 1020명이 
# 있는 대학에서 무작위로 50명을
# 뽑았을때 흡연자일 확률은?
dbinom(50, size=1020, prob=0.25)

library(prob)
S <- rolldie(4)
S
N <- nrow(S)
N
item <- 
  c("합", "범위", "최대치","최소치")
Mt <- 
  paste("주사위 4개의 눈",item,"확률분포")
X <- vector("list", 4)
X[[1]] <- apply(S, 1, sum)    
X[[3]] <- apply(S, 1, max)
X[[4]] <- apply(S, 1, min)
X[[2]] <- X[[3]]-X[[4]]
library(corrplot)
corr.plot(X, Mt, item)

# 성공확률이 각각 0.2, 0.5, 0.8인 무한모집단에 
# 10개씩 표본을 취하였을때 나타나는 
# 성공 횟수의 확률분포표를 그리시오.(plot)
n <- 10
p <- c(0.2, 0.5, 0.8)
x <- 0:n
fx <- array(NA, dim=c(11,3))
dim(fx)
for(i in 1:3) fx[,i] <- dbinom(x, n, p[i])
colnames(fx) <- p
rownames(fx) <- x
round(t(fx),4) # t함수를 사용하여 3행, 1열로 출력
apply(fx, 2, sum)
par(mfrow=c(1, 3))
plot(x, fx[,1], type="h")
plot(x, fx[,2], type="h")
plot(x, fx[,3], type="h")

# t-분포(distibution)
# Student-t분표, 자유도 
# 표준정규분포와 자유도
# 1,5,10,30인 t-분포의 확률밀도
# 함수를 작성하시오.
# (-1,1)(-2,2)(-3,3)의 확률은?
x <- -100:100/30
mu <- c(1,5,10,30)
par(mfrow = c(1,1))
plot(x, dnorm(x), type="l")
abline(v=0, lty=2, col=3)
#for(i in 1:4) {
#  lines(x, dt(x,mu[i]),lty=i+1, lwd=2)
#}
lines(x, 
      lines(x, dt(x,mu[1]),lty=i+1, lwd=2))

lines(x, 
      lines(x, dt(x,mu[3]),lty=i+1, lwd=2))

# F-분포(distribution)
# 카이제곱분포를 따르며 독립적인 두개의
# 확률변수를 각각의 자유도로 나우어 비율을
# 취하면 F-분포를 따름.
# 자유도가8과 5인 독립적인 카이제곱분포
# 모집단에 10,000개씩 표본을 랜덤하게
# 추출하여 (x^2,8)/x^2,5) 히스토그램을 

# 1. 평균 50, 표준편차가 5인 정규분포
# 0 ~ 100, 1 x축기준
# 확률변수 값을 구해서 그래프로 출력
x <- seq(from=0, to=100, by=1)
y <- dnorm(x, mean=50, sd=12)
plot(x, y, type="l")

# 2. 100번 시행는 베루누이 시행이고
# 단일 확률 50%인 이항분포 그래프를 출력
x <- seq(from=0, to=100, by=1)
y <- dbinom(x, size=100, prob=0.5)
plot(x, y, type="l")
# 3. 
# rnorm(300, mean=70, sd=20)
# 확률 밀도함수를 정의하시오.
data <- rnorm(300, mean=70, sd=20)
data1 <- density(data)
plot(data1)







