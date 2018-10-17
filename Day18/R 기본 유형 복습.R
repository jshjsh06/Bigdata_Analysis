# 1. 스칼라  
d1 <- 1
d2 <- c(1)
d3 <- c(1,2,3)
d3
# integer, numeric, character, logical, factor, raw
class(d1)
str(d1)
# 2. 벡터(vector)
# 구성인자가 1이상 (1차원)
d4 <- c("1", 2, "3", 4)
d4
d5 <- 1:20
# 3. 요인(factor)
# 범주형, 순서형 데이터 구조
d6 <- c("apple", "banana", "strawberry")
class(d6)
d6 <- as.factor(d6)
d6 <- factor(d6, order = T, 
             levels = c("banana",
                        "strawberry",
                        "apple"))
d6
# dataflame -> 1
# 1 + 1 => 2

# 행렬(Matrix)
# 2차원 데이터 구조. m * n
d7 <- matrix(1:20, nrow = 2)
dim(d7)
d8 <- matrix(1:20, ncol = 2)
d8

# 배열(Array)
d9 <- array(1:24, c(2,3,4))
d9
d9[1,1,1]
d9[1,1,]

# 데이터 프레임(Data Frame)
# 데이터 유형에 관계없이 2차원
d10 <- c(1,2,3,4)
d11 <- c("a", "b", "c", "d")
d12 <- data.frame(no=d10, nm=d11)
dim(d12)

# 리스트(list)
# 컨데이너 
d13 <- c(1,2,3,4)
d14 <- matrix(1:10, nrow = 2)
d15 <- data.frame(c(1,2,3,4),
                  c("a","b","c","d"))
d16 <- list(d13, d14, d15)
d16[[1]]
# Vector, Matrix, Factor, Array
# Dataframe
# List






