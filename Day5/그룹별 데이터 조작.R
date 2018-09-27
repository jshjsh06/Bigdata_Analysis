c(1,2,3,4)
data2 <- rbind(c(1,2,3), c(5,6,7))
data2
data3 <- cbind(c(1,2,3), c(5,6,7))
data3

# apply
data4 <- matrix(1:9, ncol=3)
data4
apply(data4, 1, sum) # 1은 행을 기준으로, 2는 열을 기준
myfunc <- function(a){a*a}
apply(data4, 1, myfunc)
colSums(data4)
rowSums(data4)

colSums(iris[,1:4])
table(iris[,1:4])

# lapply, saaply..
lapply(iris[,1:4], sum)
lapply(iris[,1:4], mean)

sapply(iris[,1:4], sum)
sapply(iris[,1:4], mean)

tapply(1:10, rep(1, 10), sum)
tapply(iris$Sepal.Length, iris$Species, mean)

mapply(rnorm, c(1,2,3), c(0,10,100), c(1,1,1))

mapply(sum, c(1,2,3), c(0,10,100), c(1,1,1))


# aggregate
data(diamonds, package = "ggplot2")
aggregate(price ~ cut, diamonds, mean)
aggregate(price ~ cut + color, diamonds, mean)
aggregate(cbind(price, carat) ~ cut, diamonds, mean)
aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)

aggregate(iris$Sepal.Width ~ iris$Species, iris, mean)
tapply(iris$Sepal.Width, iris$Species, mean)
