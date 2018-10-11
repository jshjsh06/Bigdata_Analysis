'''
중심극한정리 
-> 동일한 확률분포를 가진 독립 확률 변수 n개의 평균 분포는 n이 적당히 크면 정규분포에 가까워진다.

'''
AClass <- c(10,10,10,100)
mean(AClass)
hist(AClass, breaks = 10)
sample(AClass, 2, replace = F)

data <- sapply(1:20, function(i) mean(
  sample(AClass, 2, replace = F)
))
data
mean(data)
hist(data)

AClass2 <- c(rep(10, 100), rep(50, 100), rep(100,100))
AClass2
length(AClass2)

data2 <- sapply(1:10000, function(i) mean(sample(AClass2, 80, replace = F)))
data2
mean(data2)
hist(data2)

'''
가설
모집단 -> 표본집단 가설 ...
수학점수 90점, 다음달 100점
- 귀무가설(Null Hypothesis) : H0
  => 가설 검증에서 연구자의 주장이 담긴 진술
- 대립가설(Alternative Hypothesis) : H1
  => 가설 검증에서 연구자의 주장에 대한 부정 진술 

p-value(유의수준/확률)
=> 귀무가설 참이라는 가정 아래 얻은 통계량이 귀무가설을 얼마나 지지하는지를 나타낸 확률
p-value >= 0.05 : 대립가설 기각, 귀무가설 채택
p-value < 0.05 : 대립가설 채택 , 귀무가설 기각 
'''

# t-test
# 학원에 다니기 전의 점수
before_study <- 
  c(34,76,76,63,73,75,67,78,81,53,58,81,77,80,43,65,76,63,54,64,85,54,70,71,71,55,40)
# 학원을 다닌 후의 점수
after_study <- 
  c(74,87,89,98,65,82,70,70,70,84,56,76,72,69,73,61,83,82,89,75,48,72,80,66,82,71,49)

boxplot(before_study, after_study, names = c("수강전", "수강후"))

# 두집단의 평균값이 다릅니까?
# 두집단의 정규분포를 따른다.
# Shaprio.test(데이터벡터)
# 샘플수가 너무 작은 경우에는 샘플만으로도 모집단이 정규분포를 따른다고 인정할 수 있는
# 검사가 필요함. => Shapiro 검증
shapiro_test <- c(74,87,89,98,65,82,70,70,70)
  # 정규분포성을 확인한다.
  # p-value가 0.05보다 크기 때문에 귀무가설을 기각할 수 없음. 
  # 정규분포를 따른다.
shapiro.test(shapiro_test) 
  

# t.test(x, y, paired = TRUE, var.equal=TRUE, alternative = "two.sided")
# x => A집단, y => B집단, paried => 독립표본은 FALSE이고 그외는 TRUE
# var.equal => TRUE인 경우 두집단의 분산이 같음
# alternative => 양측검정
var.test(before_study, after_study)
# 귀무가설 : 분산이 같다.
# 대립가설 : 분산이 다르다.

# t.test(x, y, paired = TRUE, var.equal = T, alternative = "two.sided")
# x, y => A, B집단 벡터
# paired => TRUE일 시 대응표본, FALSE일시 독립표본
## 대응표본 => 한 집단으로부터 두번 반복하여 샘플을 추출
## 독립표본 => 서로 독립된 집단에서 각각 샘플 추출
# alternative => two.sided, less, greater
## two.sided => A, B 집단이 서로 같은지 비교함.
## less : A집단이 B집단보다 작은지 비교. 유의수준이 0.05가 넘는다면 작다는 주장이 맞는 것임! 0.05보다 작다면 주장 기각!
## grater : A집단이 B집단보다 큰지 비교

t.test(before_study, after_study)
t.test(before_study, after_study, paired = TRUE)

# 대립가설 => 두 집단의 평균차이가 0이 아니다. 두 집단의 평균은 다르다.

t.test(before_study, after_study, paired = TRUE, alternative = "less")

?t.test

'''
# Data in two numeric vectors
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 

1. 남자, 여자의 몸무게에 대한 BoxPlot를 출력하시오.

2. 남자, 여자를 기준으로 총명수, 평균, 분산을 출력하시오.

3. var.test를 적용하고, 확인하시오.

4. unpaired two-samples t-test를 적용하고, 확인하시오.
'''
data2 <- data.frame(
  name=paste0(rep("M_", 10), 1:10),
  weight=round(rnorm(10,20,2),1)
)
data2
#round(rnorm(10,20,2),1)
#paste0(rep("M_", 10), 1:10)
summary(data2$weight)
boxplot(data2$weight)
# Shapiro-Wilk정규성 테스트
# Null 가설 : 데이터가 정상적으로 분산되어있음.
# 대립 가설 : 데이터 정상적으로 분산되어있않음.
shapiro.test(data2$weight)
#install.packages("ggpubr")
library(ggpubr)
ggqqplot(data2$weight, 
         ylab="Test",
         ggtheme = theme_minimal())

t.test(data2$weight, mu=25)
# 평균체중이 25kg미만인지 여부 테스트
# 
t.test(data2$weight, mu=25,
       alternative = "less")
# 평균체중이 25KG보다 큰지 여부 테스트
t.test(data2$weight, mu=25,
       alternative = "greater")

