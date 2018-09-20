x <- 1000
if(x >= 2) {
  print("x >= 2")
}

use.switch <- function(x) {
  switch(x,
         "a" = "first",
         "b" = "second",
         "c" = "third",
         "other"
         )
}
use.switch("a")
use.switch("b")
use.switch("c")
use.switch("d")

a <- c(1,1,0,1,0)
ifelse(a==1,"ok","no")

a<-c(1,1,0,1)
b<-c(2,1,0,1)
ifelse(a==1 & b==1, "yes", "no")
ifelse(a==1 && b==1, "yes", "no")

for(i in 2:9) {
  for(j in 1:9) {
    print(i)  & print(i*j)
  }
  
  
}

print("hi")
print("bye")
printf


msg <- "Hello World"
my.function <- function(msg){
  print(msg)
}
my.function(msg)

# sprintf
sprintf("Hello %s", "Jay")


hello.person <- function(first, last) {
  print(sprintf("Hello %s %s", first, last))
}

# 위치 사용
hello.person("Jay", "Tom")

# 이름으로
hello.person(first = "Jay", last = "Tom")

# 순서를 바꿔도 가능
hello.person(last = "Tom", first = "Jay")

# 하나의 인자만 넣어도 가능
hello.person(last = "Tom", "Jay")

# default
hello.person <- function(first, last="Elastine") {
  print(sprintf("Hello %s %s", first, last))
}
hello.person("jay")
hello.person("jay", "TOM")

#


ls()
rm(ls())
class(ls())
rm(list = ls())


# Graph
a<-1:10
b<-log(a)
plot(a,b)

x <- c(1, 3, 5, 7, 9)
y <- c(2,2,4,7,1)
plot(x,y, type = "o", col="skyblue") # type은 여러종류가 있다. col은 색깔
plot(x,y, type = "o", col="skyblue", xlab = "x axis", ylab = "y axis") # xlab, ylab은 x축 y축 이름
plot(x,y, type = "o", col="skyblue", xlab = "x axis", ylab = "y axis", main = "test graph") # main은 타이틀

barplot(y)

# 라이브러리 사용하여 그래프 표현
library(ggplot2)
mtcars
plot(x=mtcars$wt, y=mtcars$mpg)
plot(x=mtcars$wt, y=mtcars$mpg, xlab = "weight", ylab = "milage", xlim = c(2.5,5), ylim = c(15,30), main = "weight vs milage")
# xlim, ylim으로 x축 y축 scale 조정가능