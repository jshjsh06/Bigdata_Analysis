# page 376
# logistic regression
# 일반화 선형 모델(Generalized Linear Model)
# y = b + ax
# 독립 변수의 선형 결합을 이용하여 사건 발생
# 가능성을 예측하는 통계 기법
# glm

# cyl, hp, wt
data <- mtcars[, c("am","cyl","hp","wt")]
head(data,1)
c1 <- cor(data)
library(corrplot)
corrplot(c1)
glm_data <- glm(am ~ cyl + hp + wt, data = data, family = binomial)
summary(glm_data)

# 스팸 확인
# 부정 결제
# 마케팅 ...
# example_adult.csv
# age
# eduacation
# marital.status
# gender
# income
library(dplyr)
data10 <- read.csv("example_adult.csv")
# 왜 읽어 올수 없는지 확인

dim(data10)
glimpse(data10) # 흘끗보기
d2 <- select_if(data10, is.numeric) # data10의 내용 중 numeric인 형태만 뽑아서 각각 행을 뽑아준다.
head(d2,2) # 각 첫째 행을 볼 수 있다.
summary(d2)
library(ggplot)2
g <- ggplot(d2, aes(x=hours.per.week))
g1 <- g + geom_density(alpjha = .2, fill ="red")
g1
top_data <- quantile(data10$hours.per.week, .99) # 99%를 뽑아준다.
data10 %>% filter(hours.per.week < top_data)
dim(data10)

data11 <- data10 %>% mutate_if(is.numeric,funs(as.numeric(scale(.)))) # funs는 바로 함수를 정의해서 적용함.
# scale는 정규화함수

head(data11,1)

factor <- data.frame(select_if(data11, is.factor))
dim(factor)
names(factor)
library(ggplot2)
names(factor)
ggplot(factor, aes(x=workclass)) + geom_bar()

# 5
# 10th Dropout

recast_data <- data11 %>%
  select(-X) %>%
  mutate(education = factor(ifelse(education == "Preschool" | education == "10th" | education == "11th" | education == "12th" | education == "1st-4th" | education == "5th-6th" | education == "7th-8th" | education == "9th", "dropout", ifelse(education == "HS-grad", "HighGrad", ifelse(education == "Some-college" | education == "Assoc-acdm" | education == "Assoc-voc", "Community",
                                                                                                                                                                                                                                                                                            ifelse(education == "Bachelors", "Bachelors",
                                                                                                                                                                                                                                                                                                   ifelse(education == "Masters" | education == "Prof-school", "Master", "PhD")))))))
names(recast_data)
recast_data %>% 
  group_by(education) %>% 
  summarise(edu_year = mean(educational.num),
            count = n()) %>% 
  arrange(edu_year)

# maritial-status
# Never-married

recast_data$gender
g2 <- 
  ggplot(recast_data, aes(x=gender, fill=income))
g3 <- g2 + geom_bar(position = "fill")
g3
names(recast_data)
g4 <- 
  ggplot(recast_data,
         aes(x=hours.per.week))
g5 <- g4 + geom_density(
  aes(color=education))
g5

g6 <- ggplot(recast_data,
             aes(x=age, y=hours.per.week))
g7 <- g6 + geom_point(
  aes(color=income), size=0.5)
g8 <- g7 + stat_smooth(method = 'lm',
                       formula = y~poly(x,2),
                       se = TRUE,
                       aes(color=income))
g8
# 379
# coef plot
# 381
