''' 개발시 참고 사항
R 언어 syntax
tidyverse
...

Python 언어 syntax
Numpy, Pandas, Matplot...

2 ~ 3 Study
Database 관리자 
Database 개발자 
Database 모델링(관계형) 
Database 최적화 & 튜닝 
(Oracle,MsSql,MySql,PostgreSql..)

2 ~ 3 Study
MEAN Stack
Mongo DB(1~2), Express JS(1), Angluar JS(1), Node JS(2)
=> Javascript, NoSQL(Mongodb)
Python Django....

Javascript + HTML5, CSS3(2)  //////// Javascript => 반드시 HTML5, CSS3 공부
Javascript OOP
Javascript Pattern
Javascript Framework
(Angular JS(MVC)........)


'''
# 이산확률분포

# 1.이산균일분포
# n개의 결과 값이 균일한 확률로 
# 발생하는 확률분포
# 예) 1에서 20까지 번호가 적혀 있는 동일한 
# 20개의 공이 들어 있는 상자에서 임의로 
# 하나의 공을 꺼냈을때 나온 번호를 X라고
# 할때, X의 확률분포함수, X의 기댓값과 분산등등
#
# 2.이항분포
# -> 베르누이분포(Bernoulli distribution)는 성공활률이 일정한 1회의 시행에서 나오는 성공
# 횟수의 확률분포를 말함. 
# -> 성공확률이 일정한 n회의 시행에서 나오는 성공 횟수의 확률 분포


'''
성공확률이 각각 0.2, 0.5, 0.8인 무한모집단에서 10개씩 표본을 취하였을 때
나타나는 성공 횟수의 확률분포는?
'''
n <- 10 # 시행횟수
p <- c(0.2, 0.5, 0.8) # 성공 확률
x <- 0:n # 확률변수 x의 범위
# (11행, 3열)
fx <- array(NA, dim=c(11,3))
fx
dim(fx)
for(i in 1:3) fx[,i] <- dbinom(x, n, p[i])
fx[,1]
fx[,2]
fx[,3]

colnames(fx) <- p
rownames(fx) <- x
fx
d <- round(t(fx),4)
d
apply(d, 1, sum)
par(mfrow=c(3,2))
plot(x, fx[,1])
plot(x, fx[,2])
plot(x, fx[,3])
# 불량률이 0.03인 공정에서
# 20개의 표존을 추출하여 검사하고 
# 발견한 불량개수X라할때,
# X의 확률분포함
# 2개의 불량률이 발견될 확률
dbinom(0:2, 20, 0.03)

# 3. 초기하분포
# 두가지 속성의 개체들로 구성된 유한 모집단에서 일정한 개수의 표본을 비복원추출로 했을 
#때, 특정 속성을 갖는 개체수의 확률분포

# 4. 포아송분포
# 일정한 단위에서 발생한 희소한 사건의 확률분포

# 5. 기하분포
# 성공확률이 일정한 시행에서 첫번째 성공이 발생할 때까지 시행한 횟수의 확률분포

# 6. 음이항분포
# 성공확률이 일정한 시행에서 주어진 횟수(r)의 성공이 발생할때 까지 시행한 횟수의 확률분포

# 7. 다항분포
# 다수의 속성을 갖는 개체들로 구성된 무한한 모집단에서 일정한 개수의 표본을 취했을때, 
# 각속성을 갖는 개체수의 결합확률분포

# 균일확률분포

# 1. 균일분포
# 유일한 실수 구간[a,b]에서 동일한 확률로 관측되는 확률변수의 변수

# 2. 지수분포
# 확률밀도함수가 지수적으로 감소하는 확률분포

# 3. 감마분포

# 4. 와이플분포

# 5. 베타분포


# * 정규분포와 관련 분포
# 1. 기댓값 중심으로 대칭이며, 중심위치는 기댓값, 산포는 표준편차에 의해 결정되는 
# 엎어놓은 종 모양의 분포
# dnorm, pnorm, qnorm, rnorm
# 표준정규분포 기대값 = 0, 표준편차 = 1
# x축 -7 ~ 7
x <- (-140:140)/20
x
dnorm(x, 0, 1) # 기대값이 0이고, 표준편차가 1
dnorm(x, 0, 2)
dnorm(x, 2, 1)
dnorm(x, 2, 2)
data <- matrix(c(dnorm(x, 0, 1), dnorm(x, 0, 2), dnorm(x, 2, 1), dnorm(x, 2, 2)), ncol = 4, byrow = F )
head(data)
par(mfrow=c(2,2))
plot(x, data[,1], type="l")
plot(x, data[,2], type="l")
plot(x, data[,3], type="l")
plot(x, data[,4], type="l")
segments(0,0,0, max(data[,1]), lty = 2, col = 4)

# 확률변수 X가 N(2, 2^2)을 따를 때, 구간 P(-1<X<4)를 구하시오.
# X축생성(-7 ~ 7)
x3 <- (-140:140)/20
x3
mu3 <- 2
# 구간
sig3 <- 2 
a3 <- -1;b3 <- 4
# 확률밀도함수 계산
fx3 <- matrix(c(dnorm(x3, 0, 1), dnorm(x3,mu3,sig3)), ncol=2, byrow=F)
px3 <- pnorm(4, mu3, sig3); px3
px4 <- pnorm(-1, mu3, sig3); px3
# -1<x<4 구간 면적의 합은 px3 - px4와 같고 이것이 확률값이다.
px5 <- px3 - px4
plot(x3, fx3[,2], type="l")
x5 <- c(a3, seq(a3, b3, 0.01), b3)
y5 <- c(0, dnorm(seq(a3, b3, 0.01), mu3, sig3),0)
polygon(x5, y5, col='lightcyan')
text(1.5, 0.05, labels=paste0("P(",a3,"<X<",b3,")\n=", round(px5,4)))


  

# 2. 표준정규분포
# 기댓값이 0, 표준편차가 1인 정규분포

# 3. 카이제곱분포
# 표준정규모집단으로부터 추출된 확률표본을 Z1, Z2,...이라면, 
# 자유도가 n인 카이제곱분포를 따름

# 4. t-분포
# 표준정규분포를 따르는 확률변수를 Z라고하고, Z와는 독립적으로 자유도 v인 카이제곱
# 분포를 따르는 확률변수 Y라고 하면, 확률 변수는 자유도 v인 t-분포를 따름

# 5. F-분포
# 카이제곱분포를 따르며 독립적인 두개의 확률변수를 각각의 자유도로 나누어 비율을 취하면 
# F-분포를 따름, 즉, 자유도가 v1와 v2인 카이제곱분포를 따르면 독립적인 확률변수
# 각각 U와 V라함.

