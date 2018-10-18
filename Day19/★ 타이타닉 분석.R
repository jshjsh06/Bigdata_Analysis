library(data.table)
library(plyr)
library(stringr)

train.data2 <- fread("train.csv", na.strings = c("", " ", NA, "NA"))
test.data2 <- fread("test.csv", na.strings = c("", " ", NA, "NA"))

names(train.data2)
# survived : 0(No), 1(Yes)
# Pclass : 1, 2, 3
# Sibsp : 형제 / 배우자 같이 탑승
# Parch : 부모 / 자녀수
str(train.data2)
colSums(is.na(train.data2))
colSums(is.na(test.data2))
train.data2$Age # Na가 많다
summary(train.data2$Age) # Na가 177개 있다는 것을 알 수 있다.
summary(train.data2)

# Na 를 없애는 방
dim(train.data2)
dim(test.data2)
all.data2 <- rbind(train.data2, test.data2, fill=TRUE) # 우선 두 데이터를 합친다.
all.data2$Age

dim(all.data2)
all.data2[is.na(Embarked)]
all.data2 <- all.data2[!is.na(Embarked)] # Embarked에 있는 Na값을 제거한다.
dim(all.data2) # 2개 행이 없어진 것을 알 수 있다.

all.data2[is.na(Cabin)]
all.data2 <- all.data2[is.na(Cabin), Cabin := "Miss"] # Cabin에 NA값이 있는 것을 Miss로 대체한다.
all.data2

head(all.data2$Fare)
head(log(all.data2$Fare))
all.data2$Fare <- log(all.data2$Fare + 1) # Fare 값을 +1 하여 로그로 환산한다. 그냥 보기 편하게 하기 위해.

all.data2[Parch == 9L]
all.data2[Parch == 9L, Parch := 0] # Parch 값이 9L이라면 0으로 바꾼다.

train.data3 <- all.data2[!is.na(Survived)] # survived값에 NA가 없는 데이터는 train으로 넣는다.
train.data3[,Survived := as.factor(Survived)] # survived 열 값을 팩터로 전환한다.
class(train.data3$Survived)
train.data3

test.data3 <- all.data2[is.na(Survived)] # survived값에 NA가 있는 데이터는 test으로 넣는다.
head(test.data3$Survived)
test.data3[,Survived := NULL] # 어차피 NA만 있는 Survived 행을 Null로 바꿔버린다.
# head(test.data3$Survived) 행이 없어졌으므로 작동되지 않는다.

# 분석
myModel2 <- glm(Survived ~ ., family = "binomial", data = train.data3[,-c("PassengerId", "Name", "Ticket")])
temp <- summary(myModel2)
options(scipen = 999) # 지수 e를 삭제하는 것
temp$coefficients
  # anova 카이제곱 검색
anova(myModel2, test = "Chisq") # **, ***이 있는 것이 의미가있음. 유의수준이 낮으니깐.

  # **, ***만 추출하여 다시 모델을 만든다.
myModel3 <- glm(Survived ~ Pclass + Sex + Age + SibSp, family = "binomial", data = train.data3[,-c("PassengerId", "Name", "Ticket")])
anova(myModel3, test = "Chisq")

summary(myModel2)
summary(myModel3) # AIC도 좋아짐?을 판단하는 척도인데, 낮을수록 좋다. myModel2보다 더 나아졌다.



#====================================================================#
# Age : Median
for(i in "Age"){
  set(all.data2, i = 
        which(is.na(all.data2[[i]])),j
      = i, value = median(all.data2$Age,
                          na.rm = T))
}
# Fare : Median
for(i in "Fare"){
  set(all.data2, i = 
        which(is.na(all.data2[[i]])),j
      = i, value = median(all.data2$Fare,
                          na.rm = T))
}
all.data2 <- all.data2[!is.na(Embarked)]
all.data2[is.na(Cabin), Cabin := "Miss"]
all.data2$Fare <- log(all.data2$Fare + 1)
all.data2[Parch == 9L, Parch := 0]
# data preprocing end

View(all.data2$Parch)
View(all.data2$Fare)

train.data3 <- all.data2[!is.na(Survived)]
train.data3[,Survived := as.factor(Survived)]
class(train.data3)
test.data3 <- all.data2[is.na(Survived)]
test.data3[,Survived := NULL]

myModel2 <- 
  glm(Survived ~ ., family = "binomial",
      data = train.data3[,-c("PassengerId",
                             "Name",
                             "Ticket")])

summary(myModel2)
options(scipen = 999)
temp$coefficients
# anova 카이제곱 검증
anova(myModel2, test = "Chisq")

myModel3 <- 
  glm(Survived ~ Pclass + Sex + Age + SibSp, family = "binomial",
      data = train.data3[,-c("PassengerId",
                             "Name",
                             "Ticket")])
anova(myModel3, test = "Chisq")
summary(myModel3)
anova(myModel2, myModel3, test = "Chisq")
library(caret)
split <- createDataPartition(
  y=train.data3$Survived, p=0.6, list=FALSE)
split
train.new <- train.data3[split]
test.new <- train.data3[-split]

myModel4 <- 
  glm(Survived ~ Pclass + Sex + Age + SibSp, family = "binomial",
      data = train.new[,-c("PassengerId",
                           "Name",
                           "Ticket")])
myResult <- predict(myModel4, newdata = test.new,
                    type="response")
myResult2 <- ifelse(myResult > 0.5, 1, 0)
myResult2
summary(myModel4)
step(myModel4)

install.packages("ROCR")
install.packages("Metrics")
library(ROCR)
library(Metrics)
p <- prediction(myResult2, test.new$Survived)
p1 <- performance(p, measure = "tpr",
                  x.measure = "fpr")
plot(p1)
