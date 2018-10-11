# 정수기 AS기사는 몇명이 적당할까?
# csv 파일명 : example_data01.csv
# 1열 : 총정수기 대여 대수(월)
# 2열 :10년 이상 대여 대수
# 3열 : AS시간(당월)
data <- read.csv("example_data01.csv")
head(data, 5)
str(data)
par(mfrow = c(1,2))
plot(data$purifier, data$as_time) # 그래프로 보면 어느정도 선형을 가지고 있다.
plot(data$old_purifier, data$as_time) # 그래프로 보면 어느정도 선형을 가지고 있다.
  # r 값은 X 와 Y 가 완전히 동일하면 +1, 전혀 다르면 0, 반대방향으로 완전히 동일 하면 –1 을 가진다. 
cor(data$purifier, data$as_time) # 1에 가까우므로 상관관계가 있다.
cor(data$old_purifier, data$as_time) # 1에 가까우므로 상관관계가 있다.


# 회귀분석
# 어떤 현상을 발생시키는 원인들(독립변수, 예측변수)이 결과(종속변수, 반응변)에 영향을 미치는지를 간략화된 "회귀방정식"을
# 통해서 분석/예측하는방법

# speed : 차속도, dist : 제공거리
# lm은 회귀모형을 만드는 함수. lm(y ~ x)에서 y는 종속변수, x는 독립변수
lm_result <- lm(formula = dist ~ speed, data = cars)
lm_result
summary(lm_result)
coef(lm_result)

plot(cars$speed, cars$dist)
abline(lm_result) # 분포에 대한 중간값으로 선을 그어줌

# 예시 
x <- c(151,174,160,186,150,179,153) # 아버지의 키
y <- c(63,81,56,91,47,76,62) # 자식의 키
height <- lm(formula = y ~ x)
height
summary(height)
# y = 0.94x - 86.83 + error

plot(x, y)
abline(height)

h <- data.frame(c(155,172,156,181,151,175,159))
predict(height, h)


# 예시2
p <- ggplot(faithful, aes(waiting, eruptions))
p1 <- p + geom_point()
p1
cor(faithful$waiting, faithful$eruptions)

lm_data2 <- lm(faithful$eruptions ~ faithful$waiting,data = faithful)
lm_data2
summary(lm_data2)

p2 <- p + geom_point() + geom_smooth(method = "lm") # geom_smooth(method = "lm")는 회귀 결과를 그래프로 보여준다.
p2
