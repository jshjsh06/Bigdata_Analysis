#394
#405
# RMSE(Root Mean Square Error)
# MAE(Mean Absoult Error)
# caret
#install.packages("caret")
#install.packages("psych")
rm(list=ls())
library(caret)
library(psych)
head(sat.act,1)
df <- sat.act
# 519
# 521
df_ctrl <- trainControl(method="cv",
                        number = 5)
# ACT ~ gender + age + SATV + SATQ
names(df)
df_model <- train(
  ACT ~ gender + age + SATV + SATQ,
  data = df,
  trControl = df_ctrl,
  method="lm",
  na.action = na.pass)
df_model
df_model$finalModel
df_model$resample
sd(df_model$resample$Rsquared)
lm_data <- lm(ACT ~ gender + age + SATV + SATQ,
              data=df)
options(scipen = 999)
summary(lm_data)

set.seed(0123)
half_size <- floor(0.50 * nrow(df))
random_sample <- 
  sample(seq_len(nrow(df)),size=half_size)
random_sample
first_half_data <- df[random_sample,]
lm_data2 <- lm(ACT ~ gender + age + SATV + SATQ,
              data=first_half_data)
summary(lm_data2)

second_half_data <- df[-random_sample,]

lm_data3 <- lm(ACT ~ gender + age + SATV + SATQ,
               data=second_half_data)
summary(lm_data3)

