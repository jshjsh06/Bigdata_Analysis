myTest <= "hihi"

x1 <- 1
x2 <- FALSE
x3 <- 'Hello R'
x4 <- 2 + 3i
a <- b <- 10
a
assign("j", 5)
j

b <- 13 %/% 4
b

rm(b)

class(x1)
class(x2)
class(x3)
class(x4)

mode(x1)

nchar(x2)


# 벡터 사용
vector1 <- c(1,2,3,4)
mode(vector1)
is.numeric(vector1)

vector2 <- c("자장면", "탕수육", "짬뽕")
mode(vector2)
class(vector2)
is.character(vector2)

# 벡터 값 추출 및 제거
vector3 <- c('apple', 'strawberry', FALSE, 10)
vector3[c(1,2)]
vector3[c(TRUE, FALSE, TRUE, FALSE)]
vector3[c(-1)]
vector3[c(-2)]
vector3[c(-3)]
vector3[c(-4)]



q <- c('a' = 1, 'b' = 2, 'c' = 3)
q


vector4 <- seq(from=1, to=5, by=1)
vector4

vector5 <- seq(from=1, to=10, by=2)
vector5

vector6 <- seq(from=10, to=1, by= -1)
vector6

# a는 10번, b는 5번
vector7 <- rep(c("a", "b"), times=c(10,5))
vector7


#  any, all
x <- 10:1
y <- -4:5
any(x<y)
all(x<y)
