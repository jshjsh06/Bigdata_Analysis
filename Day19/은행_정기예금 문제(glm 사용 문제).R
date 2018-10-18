'''
y <- 고객이 정기 예금에 가입 유무
glm(y ~ age + job + m...)
stepAIC(myModel)
'''

dt <- fread("example_bank_data.csv")
library(data.table)
colnames(dt)
dt[y == "no", y := 0]
dt[y == "yes", y := 1]
dt$y <- as.factor(dt$y)
class(dt$y)
# chr -> factor change


myModel_1 <- glm(y ~ ., family = "binomial", data = dt)
myModel_1_anova <- anova(myModel_1, test = "Chisq")

myModel_2 <- glm(y ~ age + job + marital + education + contact + duration + campaign , family = "binomial", data = dt[,-c("housing", "loan", "previous", "nr.employed")])
myModel_2
anova(myModel_2, test = "Chisq")

myModel_3 <- glm(y ~ age + job + marital + education + contact + duration + campaign , family = "binomial", data = dt)
anova(myModel_3, test = "Chisq")

step(myModel_2)

glm(y ~ age, family = "binomial", data = dt)
a <- glm(y ~ job, family = "binomial", data = dt)
z <- glm(y ~ education, family = "binomial", data = dt)
a$aic
z$aic
myModel_1$age
dim(dt)[2]

b <- data.frame("colnames" = 0:dim(dt)[2], "AIC" = 0:dim(dt)[2])
b
colnames(dt)

eval(parse(text = colnames(dt)[1]))

for(i in 1:dim(dt)[2]) {
  b[i,1] <- colnames(dt)[i]
  temp1 <- colnames(dt)[i]
  temp2 <- glm(y ~ eval(parse(text = temp1)), family = "binomial", data = dt)
  b[i,2] <- temp2$aic
}
b %>% arrange(AIC)

#================== 강사님 ================
library(data.table)
library(dplyr)
df <- read.csv("example_bank_data.csv", stringsAsFactors = T, na.strings = "NA")
library(MASS)
#stepAIC()
str(df)
df$y <- ifelse(df$y == "yes", 1, 0)
myModel <- glm(y ~ age + job + marital + education, data= df)

summary(myModel)
step(myModel)
stepAIC(myModel)
result <- predict(myModel, type="response", df)
df2 <- data.frame(result)
class(df2)
df3 <- cbind(df, df2)
View(df3)
result2 <- table(df2 > 0.5, df$y)
result2
