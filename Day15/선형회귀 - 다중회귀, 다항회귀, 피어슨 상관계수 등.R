# 선형회귀
# 종속변수 또는 목표번수와 연속변수 또는 독립변수의 관계를 찾는 방법

# 변수는 연속적이어야하고, 숫자값이어야 한다.
# Residual => 종속변수의 관측된 값과 회귀에서 예측된 종속 변수값간의 차이

# 단순회귀(Simpler Linear)
# 다항(Polynomial)
# 다중(Multiple linear)
# 다수준, 다변량, 로지스틱...
# y = ax +- b
# weight = a * height + b

# 다향회귀
height <- c(58,59,60,61,62,63)
weight <- c(115,117,120,123,126,129)
data2 <- data.frame(height, weight)
data3 <- lm(weight ~ height + I(height^2), data= data2)
data3

# weight = a + bx + x^2
plot(weight ~ height, data=data2)
lines(data2$height, fitted(data3))

# 다중회귀(Multiple linear regression)
data5 <- mtcars[,c("mpg","disp","hp","wt")]
data5
model <- lm(mpg~disp+hp+wt, data=data5) # 다향회귀에서 그냥 x값 몇개를 더 넣어서 함께 비교하는 것임!
model
plot(mpg~disp+hp+wt, data=data5) # 그러므로 그래프도 총 3개가 나오겠지!
# coef 회귀계수
# (Intercept) weight
# -10         3
coef(model)
coef(model)[1]
coef(model)[2]
model # y = 37 -0.0009*disp -0.031*hp -3.8*wt
# disp, hp, wt
# coef : 회귀계수 출력
# fitted() : 적합한 값 출력
fitted(model)[1:4]
model # lm을 통해 만든 회귀모형은 다양한 값을 내포하고 있다.
model[1] # coefficients 값을 보여줌
model[2] # residuals 값을 보여줌
model[3] # effects 값을 보여줌
model[4] # rank 값을 보여줌
model[5] # fitted.values 값을 보여줌

# residuals() : 오차(error)
residuals(model)[1:4]
# confint() : 회귀계수의 신뢰구간
confint(model)
par(mfrow=c(2,2))
plot(model, pch=16, col="red")

##########################################

# 피어슨 상관계수
# 선형적 상관계 있는지 확인할 때 (-1 ~ 1)
cov(1:10, 2:11)
cov(1:5, 2:6)
cov(1:5, c(4,4,4,4,4))

# 스피어만 상관계수
# 두 데이터의 실제 값의 순위를 사용해 상관계수를 계산하는 방식
s <- c(2,3,4,3,2,1,5)
sort(s)
rank(sort(s))

x <- matrix(c(1:10, (1:10)^2), ncol=2)
x
cor(x, method = "spearman")
cor(x, method = "pearson")

#######################################
# 다중회귀분석 multiple Regression => x값이 많은 회귀분석
install.packages("car")
library(car)
library(corrplot)
install.packages("visreg")
library(visreg)
install.packages("rgl")
library(rgl)
library(knitr)
install.packages("scatterplot3d")
library(scatterplot3d)
?Prestige
head(Prestige)
str(Prestige)
summary(Prestige)
colnames(Prestige)
data <- Prestige[, c(1:4)]
data
plot(data, pch=16) # pch는 점 크기
# Income = B0 + B1*Education + B2*Prestige * B3*Women 을 뜻한다.
plot(data$education)
educ <- scale(data$education, center = T, scale = F) #scale() = (x-mean(x)) / sd(x)와 동일
educ

colnames(Prestige)
data <- Prestige[,-6]
cor(data) # 상관관계 살펴보기 => X 와 Y 가 완전히 동일하면 +1, 전혀 다르면 0, 반대방향으로 완전히 동일 하면 –1 을 가진다.
corrplot(cor(Prestige[,-6]), method="number") # 상관관계를 그래프로 살펴보자

par(mfrow=c(2,2))
# income * prestige => 상관관계에서 prestige와 income의 상관계수는 0.714957이다. 그래프와 같이 상관관계가 유의하다.
ggplot(data=Prestige, aes(x=prestige, y=income, col=type)) + geom_point()
# education * prestige
ggplot(data=Prestige, aes(x=prestige, y=education, col=type)) + geom_point()
# women * prestige => 상관관계에서 prestige와 women의 상관계수는-0.1183342이다. 그래프와 같이 상관이 거의 없다.
ggplot(data=Prestige, aes(x=prestige, y=women, col=type)) + geom_point()
# census * prestige
ggplot(data=Prestige, aes(x=prestige, y=census, col=type)) + geom_point()


lm_data3 <- lm(prestige ~ education + log(income) + women + census, data = Prestige)
lm_data3
lm_data4 <- lm(prestige ~ education + log(income), data = Prestige)
lm_data4

############
cars$speed
cars$dist
m <- lm(dist ~ speed, data = cars)
m
# dist = B0 + B1 * speed + e
# dist = -17.579 + 3.932*speed + e
coef(m) # coef 함수는 lm함수랑 동일한데, coef()[1] 와 같이 추출이 가능하다는 점만 다르다.
# fitted() : 적합한 값 출력
# residuals() : 오차(error) 출력
fitted(m)
coef(m)[1:4]
fitted(m)[1:4]
residuals(m)[1:4]
fitted(m)[1:4] + residuals(m)[1:4]
cars$dist[1:4]
confint(m)
predict(m)
predict(m, newdata = data.frame(speed=3))
coef(m)
-17.579095 + 3.932409 * 3 # predict(m, newdata = data.frame(speed=3)) 과 값이 동일한 것을 알 수 있다.
predict(m, newdata = data.frame(speed=3), interval = "prediction")
summary(m)
plot(cars$speed, cars$dist)
abline(coef(m))

summary(cars$speed)
predict(m, newdata = data.frame(speed = c(4.0,25.0,0.2)), interval = "confidence")
speed <- seq(min(cars$speed), max(cars$speed), 0.1)
speed

ys <- predict(m, newdata = data.frame(speed=speed), interval = "confidence")
matplot(speed, ys, type="n")
matlines(speed, ys, lty=c(1,2,2), col=1)
