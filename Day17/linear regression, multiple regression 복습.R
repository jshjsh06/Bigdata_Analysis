#Linear Regression
# -1 < 0 < 1
x <- c(150, 171, 138, 186, 128, 136, 179, 152, 131, 140)
y <- c(63,81,56,91,47,57,76,72,62,42)

lm_data <- lm(y ~ x)
lm_data
# y = -33.7351 + 0.6515*x
summary(lm_data)
x1 <- data.frame(x=170)
x1
predict(lm_data, x1)
plot(y, x, col="blue")
abline(lm_data, cex=1.3, pch=16)

# multiple regression
# y = a + b1x1 + b2x2...
# lm(y ~ x1 + x1)
library(ggplot2)
df <- mtcars[, c("mpg", "disp", "hp", "wt")]
df
lm_data2 <- lm(mpg ~ disp+hp+wt, data=df)
lm_data2
# mpg = -0.000937*disp -0.031157*hp -3.800891*wt
summary(lm_data2)
options(scipen = 999) # 지수 삭제(e 삭제)
summary(lm_data2)
