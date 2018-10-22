library(tidyverse)
library(caret)
df <- read.csv("eurobarometer.csv")
View(df)
# eurobarometer
# 유럽 30개국의 관련 변수들
# 경제평가, GDP, 실업률, 인플레이션, 기타..
# eb_econgood
# eb_econgood ~ gdpgrowth + unemployment
df_model <- 
  lm(eb_econgood ~ gdpgrowth + unemployment,
               data=df)
summary(df_model)
str(df)
Nm <- nrow(df)
Nm
splt <- 4
splt_data <- split(sample(1:Nm), 1:splt)
str(splt_data)
splt_data %>% unlist() %>%  length() == Nm

lm(eb_econgood ~ gdpgrowth + unemployment,
   data=df[-splt_data$`1`,]) %>% summary()
lm(eb_econgood ~ gdpgrowth + unemployment,
   data=df[-splt_data$`2`,]) %>% summary()
lm(eb_econgood ~ gdpgrowth + unemployment,
   data=df[-splt_data$`3`,]) %>% summary()
lm(eb_econgood ~ gdpgrowth + unemployment,
   data=df[-splt_data$`4`,]) %>% summary()

t <- trainControl(
  method="cv",
  number = 4,
  savePredictions = TRUE,
  verboseIter = TRUE
)

test_cv <- train(
  eb_econgood ~ gdpgrowth + unemployment,
  data=df,
  method="lm",
  trControl = t
)
test_cv$results
test_cv$pred
df[13,]
predict(df_model)[13]




