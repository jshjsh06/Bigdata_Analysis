# vector
  # integer, numeric, character, logical. date
test <- 1
test
str(test)
test1 <- c(1,2,3,4,5)
test1
str(test1)
test2 <- 1:10
View(test2)
class(test2)
test3 <- seq(5, 9, by=0.5)
test3
test4 <- c(1,2)
names(test4) <- c("first", "second")
test4
test4[c("first", "second")]

# matrices
test5 <- matrix(c(1:10), nrow = 2, byrow = T)
test5
test5[,1]
test5[c(1,2),1:2]
test5[c(1,2),c(1,3,4)]
test5 <- matrix(c(1:10), nrow = 2, byrow = T, dimnames = list(c("row1","row2"),c(1,2,3,4,5)))
test5
rownames(test5)
colnames(test5)
rownames(test5) <- c("one", "two")

# lists (리스트는 3차원 배열이라고 생각해도 ㅇㅋ, 아니면 딕셔너리)
test6 <- list(1,2,3,4,5)
test6[[1]]
test6 <- list(c(1,2), test5, "test")
str(test6)
test6[[1]]
test6[[2]]
test6[[1]][c(1,2)] 
test6[[2]][c(1,2), c(1,3,4)]
names(test6) <- c("one", "two", "three")
test6
test6$one
test6[c(1,2)]

# arrays
test7 <- c(1,2,3)
test8 <- c(4:9)
test9 <- array(c(test7,test8), dim = c(3,3,2))
test9
test9[1:2, c(1,3), 2]
test9 <- array(c(test7,test8), dim = c(3,3,2), dimnames = list(c("row1","row2","row3"), c("col1","col2","col3"), c("matrix1","matrix2")))
test9
test9["row1", "col1", "matrix1"]
colnames(test9)
colnames(test9) <- c("row2","row3", "row4")
test9

# factors
test10 <- c("man", "woman", "man", "man")
test10
test10 <- as.factor(test10) # factor(test10)도 가능
test10
test11 <- gl(3,4, labels = c("man", "woman", "test"))
test11

# data frames
test12 <- data.frame(stuNo = c(1,2,3,4), strName = c("john", "tom", "amy", "kim"), strAddress = c("seoul", "seoul", "incheon", "busan"), strSalary = c(100,100,200,150))
test12 <- data.frame(stuNo = c(1,2,3,4), strName = c("john", "tom", "amy", "kim"), strAddress = c("seoul", "seoul", "incheon", "busan"), strSalary = c(100,100,200,150), stringsAsFactors = F)
test12
str(test12)
test12$stuNo
test12$stuNo <- c(2,3,4,5)
rownames(test12)
rownames(test12) <- c("row1", "row2", "row3", "row4")
test12
test12$etc <- c("na","na","na","na")
head(test12, n=1)
names(test12)
rownames(test12)
colnames(test12)

test12[test12$stuNo>2, c(1,3)]
subset(test12, select = c(1,3), subset = (test12$stuNo > 2))

# magrittr
library(magrittr)
mean(max(test12$stuNo), na.rm = T)
test12$stuNo %>% max %>% mean(na.rm = T)

# library(data.table)
library(data.table)
DT <- fread("../data.table.data.csv", header = T, stringsAsFactors = F, data.table = T)
str(DT)
test_row <- DT[V7 == "England"]
test_row
DT[SCT == "SCT", V7]
DT[order(V7,V8)]

data <- fread("../data.table.data.csv")
str(data)
data[,,] # where, select, group by
data2 <- data.table(c("cat", "cat", "cat", "dog", "cat"), c(1,2,1,2,1))
data2
colnames(data2) <- c("col1", "col2")
rownames(data2) <- c("row1", "row2", "row3", "row4", "row5")
data2[,,]
data2[, sum(col2), by=col1] # group by는 cat, cat, dog 라고 했을 때 한가지 카테고리로 묶는 것. (where col1 == 'cat')
data2[col1 == "cat", mean(col2), by=col1]
