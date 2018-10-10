'''
# dbinom
1. 성공확률이 0.2인 n회의 시행에서 나온 성공횟수 Xn이라고 할때, 
n=10,20,50 각각에 대하여 Xn의 확률 분포함수를 그래프로 출력하시오.

#dhyper
2.성공확률이 20%이고 200개의 단위로 구성된 모집단에서 
비복원추출한 n개의 표본에서 나온 성공회수 Xn이라고 할때, 
n=10,20,50 각각에 대하여 Xn의 확률 분포함수를 그래프로 출력하시오.

#dpois
단위 제품 당 평균 결점수가 3개인 n개의 단위 제품에서 나온 결점수를 Xn이라고 할때, 
n=2,5,10 각각에 대하여 Xn의 확률 분포 함수를 그래프로 작성하시오.
'''
# 문제 1
x10 <- 0:10
x20 <- 0:20
x50 <- 0:50
par(mfrow=c(1,3))
plot(x10, dbinom(x10, 10, 0.2), type="h")
plot(x20, dbinom(x20, 20, 0.2), type="h")
plot(x50, dbinom(x50, 50, 0.2), type="h")

# 문제 2
# hyper는 초기하분포, dhyper는 초기하 밀도함수
# 비복원추출은 상자에서 공꺼내기와 같이 꺼낸 공은 다시 넣지 않고, 모집단에서 제
# http://rfriend.tistory.com/100 에 설명이 아주 잘나와 있음 ★★
x10 <- 0:10
x20 <- 0:20
x50 <- 0:50
plot(x10, dhyper(x10, 40, 160, 10), type="h") # 40은 200개 중의 20%인 성공, 160개는 그 외인 실패
                                              # 10은 40개 중에 10개를 뽑을 목표
# 문제 3
x2 <- 0:12; x5 <- 0:30; x10 <- 0:60 # 임의로 범위를 x2는 0~12, x5는 0~30 .. 으로 설정함
par(mfrow=c(3,3))
plot(x2, dpois(x2, 2), type="h")
plot(x2, dpois(x2, 5), type="h")
plot(x2, dpois(x2, 10), type="h")

plot(x5, dpois(x5, 2), type="h")
plot(x5, dpois(x5, 5), type="h")
plot(x5, dpois(x5, 10), type="h")

plot(x5, dpois(x10, 2), type="h")
plot(x5, dpois(x10, 5), type="h")
plot(x5, dpois(x10, 10), type="h")
