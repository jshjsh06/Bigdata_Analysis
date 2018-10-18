data <- read.csv("example_binary.csv")
head(data)
summary(data)
sapply(data, sd)
xtabs(~admit + rank, data=data)
data
str(data)
data$rank <- factor(data$rank)
str(data)
myModel <- glm(admit ~ gre + gpa + rank, data = data, family = "binomial")
myModel
summary(myModel)
confint(myModel)
mean(data$gre)
mean(data$gpa)
factor(1:4)
data$rank
newDf <- with(data, data.frame(gre=mean(gre), gpa=mean(gpa), rank=factor(1:4)))
newDf
data$rankResult <- round(predict(myModel, newdata = newDf, type="response"), 3)



# example_binary.csv
# 70% train.data
# 30% test.data
df <- data
s <- sort(sample(nrow(df), nrow(df)*.7)) # 70%를 랜덤 선택함. 기존 데이터 400행에서 0.7을곱한 280개 선택

train.data <- df[s,] # 70%
nrow(train.data)
train.test <- df[-s,] # 30%
nrow(train.test)

glm_data <- glm(admit ~ ., data=train.data, family = "binomial")
summary(glm_data)

# step
step(glm_data)
temp <- summary(glm_data)
temp$coefficients

# 380p

