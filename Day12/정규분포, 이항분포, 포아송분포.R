install.packages("prob")
library(prob)
tosscoin(1)
rolldie(1)

urnsamples(1:3, size=2)
urnsamples(1:3, size=2, replace=T)
urnsamples(c( rep("R", 3), rep("B", 2)), size=2)
tosscoin(2, makespace=T)

# 2개의 동전의 앞면이 나올 수 있는 확률
x <- c(0,1,2) # 동전 앞면이 나올 수 있는 가능 수
y <- c(1/4,2/4,1/4) # 가능 수의 확률 
barplot(y, names=x, xlab="앞면횟수(x)", ylab="확률(P[X=x])")
sum(x*y) # 1이 나와야 맞다. 모든 가능 수의 확률을 합한 것이므로.

# 정규분표에 대한 이해
# 정규분포 dnorm(), pnorm() => 연속형
x <- seq(-5, 5, length = 200)
x
y <- dnorm(x, mean=0, sd=1)
y
plot(x, y, type="l")
dnorm(4, mean = 0, sd=1)  # x값 4일 확률은 0.00013~ 이다.
  # 평균 10, 표준편차 6인, 확률변수 10
dnorm(10, mean = 10, sd = 6)

dnorm(15, mean=30, sd=7) # 평균이 30이고, 편차가 7일때, 확률 변수가 15일 때의 확률은? 
dnorm(30, mean=30, sd=7)

# 정규분포 랜덤하게 생
runif(10) # 확률 10개 생산
runif(50, min = 0, max = 100)
rnorm(10, mean = 100, sd=15) # 평균 100, 표준편차 15. norm 정규분포
rnorm(1000, mean = 800, sd=90)


# 이항분포 dbinom(), pbinom() => 이산형
# 이항분에 대한 이해
x1 <- 0:20
x1
y1 <- dbinom(x1, size = 20, prob = 0.5)
y1
plot(x1, y1, type="h")
# 동전 100번 던졌을 때 10번 앞면, 0.5 확률
dbinom(10, size=100, prob=0.5)
dbinom(490, size=1000, prob = 0.5) # 동전 앞면이 나오는 확률이 0.5일때, 1000번 중 490번 나오는 확률
dbinom(50, size=1020, prob = 0.25) # 흡연률이 25%일 때, 1020명 중 50명을 뽑았을 때, 흡현인일 확률

# 이항분포 랜덤하게 생성
rbinom(100, size = 1, prob = 0.5)
a <- rbinom(10, size = 1, prob = 1/6)
a[a==1] <- "성공"
a[a==0] <- "실패"
a

# 구간에 대한 확률
  # 0~ 235
pnorm(235, mean=240, sd=80)
  # 350 - 235
pnorm(350, mean=240, sd=80) - pnorm(235, mean=240, sd=80)
  # 2000번 동전을 던져서 앞면이 0번부터 900번까지 나올 확률
pbinom(900, size=2000, prob=0.5)


# 이항분포
# 연속된 n번의 독립적 시행에서 각 시행이 확률 p를 가질때의 이산 확률 분포
# 베르누이 시행이라고 불림
# 동전(앞뒤), 주사위(1~6), 성공/실패

sample(c("H","T"), size=20, replace=TRUE, prob=c(0.5, 0.5))
rbinom(10, 1, 0.5)
rbinom(10, 1, 0.3)
dbinom(1,1,0.5)
dbinom(c(0,1),1,1/6)
rbinom(10,4,0.1)

  # prob : 0.5 (확률은 0.5), wins : 19 (이기는 건 19번), totalflips : 25 (25번 경기)
dbinom(19, 25, 0.5)


dbinom(0:18, 25, 0.5)
sum(dbinom(0:18, 25, 0.5)) # 1에 가까움
pbinom(19-1, 25, 0.5)
1-pbinom(19-1, 25, 0.5)

library(ggplot2)
wins <- c(0:25)
totalFlips <- 25
probability <- 0.5
d <- 1-dbinom(wins-1, totalFlips, probability)
d1 <- dbinom(wins, totalFlips, probability)
data <- data.frame(wins, d, d1)
data
  # x coin tosses, y proability
ggplot(data, aes(wins,d1)) + geom_point() + geom_line()



# 책 304p~ 정규분포 
# 정규분포를 따른 변수 생성
randNorm <- rnorm(3000)

# 변수에 대한 분포 계산
randDensity <- dnorm(randNorm)

p <- ggplot(data.frame(x = randNorm, y = randDensity)) + aes(x=x, y=y) + geom_point() + 
  labs(x="Random Normal Variables", y = "Density")
p
# 가장 최저값인 맨 왼쪽부터 -1까지 연속된 숫자 생성
neg1Seq <- seq(from = min(randNorm), to = -1, by = .1)
# 연속된 값과 그 값에 해당하는 밀도값 결합하여 데이터 프레임 생성
lessThanNeg1 <- data.frame(x = neg1Seq, y = dnorm(neg1Seq))
lessThanNeg1
# rbind로 결함. 가장 왼쪽 값(최저값, 높이는 0) + lessThanNeg1 + 가장 오른쪽 값(최고값, 높이는 0)
lessThanNeg1 <- rbind(c(min(randNorm), 0), lessThanNeg1, c(max(lessThanNeg1$x),0))
lessThanNeg1
# 색칠할 부분은 다각형으로 정의한다.
p + geom_polygon(data = lessThanNeg1, aes(x=x, y=y))


# 포아송분포
# 일정한 단위 시간, 단위 공간에서 어떤 산건이 발생하는 경우에 사용할 수 있는 이산 확률분포
  # 책 500 페이지 중 200페이지에 오타가 있을 때, 1페이지와 3페이지 발견할 확인 화률은?
  # 200/500 = 0.4
dpois(3, 0.4)
  # 책 200페이지 중 10페이지에 오타가 있다. 1페이지 2개의 오류 발생 확률은?
  # 10/200 = 0.05
dpois(2, .05)

