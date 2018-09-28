data <- c(20,1,6,3,11)
sort(data, decreasing = T)

order(data) 
data

data2 <- c(20, 11, 33, 50, 47)
sort(data2, decreasing = T)  # 순서 값을 바로 보여준다.
order(data2) # 순서 순위를 바로 보여준다. ex) 20은 2위, 11은 1위
order(data2, decreasing = T)


print(iris$Sepal.Length)
print(iris$Petal.Length)
with(iris, print(mean(Sepal.Length)))

with(iris, {print(mean(Sepal.Length)) print(mean(Petal.Length))})

x <- data.frame(val = c(1,2,3,4,5))
within(x, { val <- c(2,3,4,5,6)})
