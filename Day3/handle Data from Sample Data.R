install.packages("ggplot2")
library(ggplot2)
class(diamonds)
diamonds
View(diamonds)
View(mtcars)

# 열 추출
diamonds[2,]
diamonds[,2,drop=F]
diamonds[,colnames(diamonds)]
colnames(diamonds)
diamonds[,grep("^c",colnames(diamonds))] # C로 시작하는 열 이름 가져오기
diamonds[,grep("c",colnames(diamonds))] # C가포함된 열 이름 가져오기
diamonds[,grep("e$",colnames(diamonds))]  # e로 끝나는 열 이름 가져오기

diamonds[,c("cut","price")]
head(diamonds[,c("cut","price")],n=15)


# 행 추출
diamonds[diamonds$price >= 18000,]
diamonds[(diamonds$cut=="Fair")&(diamonds$price>=18000),]

# 새로운 변수 만들기
diamonds$xyz.sum = (diamonds$x + diamonds$y + diamonds$y)
diamonds$xyz.sum = rowSums(diamonds[ , c(“x”, “y”, “z”)]
diamonds$xyz.mean = (diamonds$x + diamonds$y + diamonds$y) / 3
diamonds$xyz.mean = rowMeans(diamonds[ , c(“x”, “y”, “z”)]
head(diamonds)


# 데이터 삭제
diamonds[-c(1), ]
head(diamonds)

# 데이터 정렬
diamonds[order(diamonds$price, decreasing=TRUE), ]

head(diamonds[order(diamonds$price, decreasing=TRUE), ])
head(diamonds[, order(diamonds$price, decreasing=TRUE)])
head(diamonds[, c("price")])
order(diamonds[, c("cut")])
diamonds[c("cut"),]


data2 <- data.frame(c(1,1,1,2,2,2), c(3,1,2,3,1,2))

colnames(data2) <- c("col1", "col2")
data2
data2[order(data2$col1, data2$col2, decreasing = T), ]
