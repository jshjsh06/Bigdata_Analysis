'''
# dbinom(성공횟수, 샘플크기, 성공확률)

1. 무작위로 선정된 20명의 사람들이 있으며, 전국적으로 인구의 5%는 밤에 혼자 사는 것을 무서워합니다. 
20명중에서 5명은 밤에 혼자있는 것을 무서워합니다. 5명이 무서워할 확률은?
  
2. 위의 문제에서 0~20명에서 중에서 누군가 무서워할 확률을 구하고 그래프로 출력하시오.

3. 위에 문제 유형에서 100명의 무작위로 선택된 개인 그룹에서 0~100명의 사람들이 무서워할 확률은? 
(무서워할 확률 35%)

4. 75%의 성공률을 가진 약을 보유하고 있다. 
20명으로 구성된 그룹이 있고, 0~12명사이의 사람이 긍정적으로 반응할 확률은? 
그래프로 출력하시오.

'''
# 문제 1
dbinom(5, 20, 5/100)

# 문제 2
scaryPeople <- c(0:20)
totalPeople <- 20
scaryProbability <- 5/100

d <- dbinom(scaryPeople, totalPeople, scaryProbability)
d
data <- data.frame(scaryPeople, totalPeople, scaryProbability)
data
ggplot(data, aes(scaryPeople,d)) + geom_point() + geom_line()

  # 강사님 답
x <- (0:20)
y <- dbinom(0:20, 20, 0.05)
plot(x, y)
qplot(x,y)

# 문제 3
scaryPeople2 <- c(0:100)
totalPeople2 <- 100
scaryProbability2 <- 35/100

d2 <- dbinom(scaryPeople2, totalPeople2, scaryProbability2)
d2
data2 <- data.frame(scaryPeople2, totalPeople2, scaryProbability2)
data2
ggplot(data2, aes(scaryPeople2,d2)) + geom_point() + geom_line()

  # 강사님 답
x <- (0:100)
y <- dbinom(0:100, 100, .35)
qplot(x, y) 

# 문제 4
pbinom(12, 20, 0.75) # 답
pbinom(1:20, 20, 0.75)
x <- (1:20)
y <- pbinom(1:20, 20, 0.75)
qplot(x,y) # 여기서 보면 12까지의 합의 값이 0.1 정도임을 알 수 있다!!


  # 내가 푼 답(틀림)
positivePeople <- c(0:12)
people <- 20
positiveProbability <- 75/100

d3 <- dbinom(positivePeople, people, positiveProbability)
data3 <- data.frame(positivePeople, people, positiveProbability)
ggplot(data3, aes(positivePeople, d3)) + geom_point() + geom_line()


'''
#dbinom
1. 우리는 75%의 성공률을 가진 약을 가지고 있습니다.
20명의 그룹에 1000번의 시도를 하였습니다. 각 시도에 대한 이항 분포 및 그래프를 출력하시오.

#dpois
2. 2017년 뉴욕타임즈 기사에서 2009년도 부터 2017년도까지 매주 평균적으로 24마리의 말이 죽었습니다. 
1000건당 5.2건의 기록했습니다. 0~40마리의 말이 일주일안에 죽을 확률은?

3. 1주일에 30명이상의 사망자가 발행할 확률은?

#dbinom
4. 수학 퀴즈에서 객관식 문제가 10개가 있습니다. 
각 질문에서 네 가지 가능한 대답중에서 하나만 정답입니다.
학생들이 모든 문제에 무작위로 대답하고 하면 5이하의 
정답을 가질 확률은?

'''
# dbinom
# 1. 우리는 75%의 성공률을 가진 약을 가지고 있습니다.
# 20명의 그룹에 1000번의 시도를 하였습니다. 각 시도에 대한 이항 분포 및 그래프를 출력하시오.
rbinom(1000, 20, .75)

# dpois
# 2.2017년 뉴욕타임즈 기사에서 2009년도 부터 2017년도까지 매주 
# 평균적으로 24마리의 말이 죽었습니다. 
# 1000건당 5.2건의 기록했습니다. 
# 0~40마리의 말이 일주일안에 죽을 확률은?
library(ggplot2)
qplot(1:40, dpois(1:40,24))


# 3. 1주일에 30명이상의 사망자가 발행할 확률은?
ppois(30-1, 24)

# dbinom
# 4. 수학 퀴즈에서 객관식 문제가 10개가 있습니다. 
# 각 질문에서 네 가지 가능한 대답중에서 하나만 정답입니다.
# 학생들이 모든 문제에 무작위로 대답하고 하면 5이하의 
# 정답을 가질 확률은?
# probability = 1/4 = 0.25, total size=10
n = 11
k <- seq(0, 11, by=1)
y <- c(dbinom(k, size=n, prob = 0.25))
y
barplot(y, k)


