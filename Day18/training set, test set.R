# Logistics Regression -> 0, 1
# Training Set
# Testing Set

install.packages("tidyverse")
#install.packages("caret")
library(tidyverse)
library(caret)
theme_set(theme_bw())
install.packages("mlbench")
# 당뇨병 임상 데이터 관련
data(PimaIndiansDiabetes2, package="mlbench")
PimaIndiansDiabetes2 <- na.omit(PimaIndiansDiabetes2)
sample_n(PimaIndiansDiabetes2, 3)
set.seed(123) # 123이라는 시드값에 난수를 발생시키면, 그 후 123이라는 시드값에는 같은 난수가 나온다.
# 난수값을 기억한다는 느낌

traingSet <- PimaIndiansDiabetes2$diabetes %>% createDataPartition(p=0.8, list=F) # https://thebook.io/006723/ch09/03/03/06/
traingSet
# 80% 훈련셋
train.data <- PimaIndiansDiabetes2[traingSet,]
train.data
# 20% 테스트셋 
test.data <- PimaIndiansDiabetes2[-traingSet,]
PimaIndiansDiabetes2$diabetes
model <- glm(diabetes ~ ., data = train.data, family=binomial)
summary(model)
p_result <- model %>% predict(test.data, type="response")
p_result_classes <- ifelse(p_result > 0.5, "pos", "neg")
p_result_classes
mean(p_result_classes == test.data$diabetes)
# diabetes, glucose
model2 <- glm(diabetes ~ glucose, data = train.data,
              family=binomial)
newdata <- data.frame(glucose=c(20, 180))
p_result2 <- 
  model2 %>%  predict(newdata, type="response")
p_result2
p_result2_classes <- 
  ifelse(p_result2 > 0.5, "pos", "neg")
p_result2_classes
library(ggplot2)
df <- train.data %>% 
  mutate(prob=ifelse(diabetes 
                     == "pos", 1,0)) 
g <- ggplot(data=df, aes(glucose, prob)) 
g1 <- g + geom_point()
g2 <- g1 + geom_smooth(method="glm",
                       method.args = list(family="binomial"))
g2

