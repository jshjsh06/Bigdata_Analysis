library(ggplot2)
# diamonds는 기본적으로 클래스이다.
df <- diamonds
str(df)

# 클래스를 데이터 프레임으로 바꾸기 위해서는 as.data.frame을 사용한다.
df2 <- as.data.frame(diamonds)
str(df2)
# 데이터 프레임으로 바꿨으므로 평균 함수가 사용이 가능해진다.
mean(df2$price)
subset(df2, select = -c(cut,price))

# subset(데이터, 조건) 을 사용해보
df3 <- subset(df2, select = c(cut,price), subset=(price > 18000))
df3
df4 <- subset(df2, select = c(cut,price), price > 18000)
df4

df5 <- read.csv("example_studentlist.csv")
                #, encoding = "ASCII")
View(df5)

df6 <- subset(df5, subset=(df5$height > 170))
df6
df7 <- subset(df5, df5$height > 170)
df7
subset(df5, select=-height)
colnames(df5)

subset(df5, df5$bloodtypetrue)

# column 이름 바꾸기
colnames(df5)[6] <- "blood"
colnames(df5)

# BMI column 추가 weight/height^2
df5$BMI <- ((df5$weight/df5$height)^2)
df5

# height 165이상, weight 50이상
subset(df5, subset = (df5$height >= 165 && df5$weight >= 50))
subset(df5, df5$height >= 165 && df5$weight >= 50)

# table 사용해보
table(df5)
table(df5$blood)
plot(table(df5$blood, df5$sex))


