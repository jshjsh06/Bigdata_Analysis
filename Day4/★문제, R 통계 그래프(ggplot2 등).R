## 간단 복습 
x <- c(21,22,23,24,25,26, 98)
y <- c(21, 31:35, 30)
plot(x, y, type = "l", col="skyblue")
barplot(x, main="테스트", xlab="기온", ylab="횟수", names.arg = c("1","2","3","4","5","6","7"), col="red")

df1 <- read.csv("example_studentlist.csv")
barplot(table(df1$bloodtype), xlab = "BloodType", ylab = "count", border = "green", density = 10, col="blue")

## Titanic
library(ggplot2)

a <- Titanic 
str(a) # Titanic은 Table 형식으로 되어있다. Matrix으로 이루어져있을 것임

margin.table(a, 1) # a(Titanic)라는 데이터의 1열을 table 형식으로 보여준다. 
margin.table(a, 2) # a(Titanic)라는 데이터의 2열을 table 형식으로 보여준다. 
margin.table(a, 3) # a(Titanic)라는 데이터의 3열을 table 형식으로 보여준다. 
margin.table(a, 4) # a(Titanic)라는 데이터의 4열을 table 형식으로 보여준다. 
margin.table(a)

barplot(margin.table(a,1), xlab = "class", ylab = "count", border = "red", density = 10)

barplot(margin.table(a,1), xlab = "Class", col=c("red","green"))
        #, legend("topleft", c("Not survived", "Survied"), fill = c("red", "green"))


str(airquality)
Temp <- airquality$Temp
h <- hist(Temp, xlab="temperature", xlim = c(50,100))
h # h 그래프에 대한 상세 내역을 보여준다. 예를 들어서 'counts'의 8은 'breaks'의 55~60사이의 건수를 나타내주는 것임


# text는 h2 그래프에 데이터 레이블을 추가한다. h2$mids는 중간값을 말하며 즉, 중간값 위치에, counts 값을 넣는다는 것 
# 그리고 counts 값은 h2$counts에서 따온다고 labels에 명시한다 . 좀 더 위치 조정을 위해 adj를 사용 
h2 <- hist(Temp, ylim = c(0,40))
text(h2$mids, h2$counts, labels = h2$counts, adj = c(0.5, -0.5)) 

# breaks는 히스토그램을 그리기 위해 데이터를 어떻게 나눌지를 지정하는 데 사용한다.
# 기본값은 Sturge로, n일 때 막대의 너비를 ⌈log2(n)+1⌉로 정한다.
# breaks에 데이터를 나눌 구분 값들을 저장한 벡터,
# 데이터를 나눌 구분 값들을 계산하는 함수 등을 대신 지정할 수 있다.

hist(Temp, breaks = 4)
hist(Temp, breaks = 10)
hist(Temp, xlim=c(50,100), breaks=c(55,60,70,80,100), col="red")


diamonds
ggplot(data=diamonds, aes(x=diamonds$carat, y=diamonds$price))+geom_point()
h3 <- boxplot(airquality$Ozone,col="green", horizontal = TRUE)
h3

# 연령대 별로 대장암에 대한 도수분포표를 출력하시오
cancer <- read.csv("example_cancer.csv")
age <- cancer$age
staging <- cancer$cancerStaging

stagingGraph <- table(cancer$cancerStaging)
stagingGraph
as.data.frame(stagingGraph)
ageGraph <- summary(cancer$age)
ageGraph

plot(stagingGraph, ageGraph)
plot(table(cancer$cancerStaging, cancer$age))
table(cancer$cancerStaging, cancer$age)

plot(staging, age)
plot(age, staging)

hist(age, breaks=c(0,10,20,30,40,50,60,70,80,90,100,110))
hist(age)
age


text(age, staging, labels = taging)


cut(cancer$age)

cut(cancer$age, breaks = (1:11)*10)

seq(cancer$age, from = 1, by=10, length.out = 12)
exam= c(1:100)
exam
seq(exam, from=1, to=100, by = 10, length.out = 10)

## 연령대 별로 암에 대한 도수분포표를 출력하시오
cancer <- read.csv("example_cancer.csv")

df10 <- table(cut(cancer$age, breaks = (1:11)*10)) #seq로 구간을 잘라줘도 된다고는 하는데 아마 안되는 듯.
  # cut은 구간을 잘라주는 역할을 하지만, seq는 값을 생성하는 함수임
  # breaks는 자료 범위의 구간을 지정해주는 것
  # cut은 구간을 잘라주는 것, breaks를 인자로 갖는다. 즉 seq와 비슷한 성격
df10
str(df10)
rownames(df10) <- c("10세", "20세", "30세","40세", "50세", "60세","70세", "80세", "90세", "100세")

df11 <- as.data.frame(df10)
df11
plot(df11$Var1, df11$Freq, type="o")


## ggplot2과 geom으로 그래프 생성 
# aes는 어디에 넣어도 된다. 이름 자체에 할당이 되어 있기 때문이다. 아래 4가지 모두 같은 결과값을 낸다.
ggplot(data = diamonds[diamonds$carat<2.5,], aes(x=carat, y=price)) + geom_point(aes(color = color))
ggplot(data = diamonds[diamonds$carat<2.5,]) + geom_point(aes(x=carat, y=price, color = color))
ggplot(data = diamonds[diamonds$carat<2.5,], aes(color = color)) + geom_point(aes(x=carat, y=price))
ggplot(data = diamonds[diamonds$carat<2.5,], aes(x=carat, y=price, color = color)) + geom_point()

# 이 역시 같은 결과를 낸다.
ggplot(data = diamonds, aes(x=carat)) + geom_histogram()
ggplot(data = diamonds) + geom_histogram(aes(x = carat))
ggplot(data = diamonds) + geom_histogram(aes(x = carat), fill = "grey50")

#
ggplot(data = diamonds[diamonds$carat<2.5,], aes(x=carat, y=price)) + geom_point(aes(color = cut)) + facet_wrap(~cut)
ggplot(data = diamonds[diamonds$carat<2.5,], aes(x=carat, y=price)) + geom_point(aes(color = color)) + facet_grid(cut~clarity)

head(diamonds)



## 문제. 도착횟수 6000 횟수가 넘는 항공사 찾기, 6000횟수가 넘는 공항들의 전체합 구하고 막대 그래프 출력
install.packages("hflights")
library(hflights)

# 내 답
b <- table(hflights$Dest)
b
p <- subset(b, b>6000)
barplot(p)

t <- unlist(p[[1]]) + unlist(p[[2]]) + unlist(p[[3]])
unlist(t)
p$test2 <- unlist(t)

class(p[1])
class(p[[1]])
unlist(p[[1]])

q <- p[[1]] + p[[2]] + p[[3]] + p[[4]] + p[[5]]
q
class(q)
q <- as.numeric(p[[1]])
q
p$test <- q
p
p[1]
p
p$sum <- p[[1]] + p[[2]] + p[[3]] + p[[4]] + p[[5]]
unlist(p[1])


p <- subset(b, b>6000)
aa <- unlist(p[1])
p$SUM <- aa
p
p$SUM <- as.numeric(c(p[1],p[2]))
p
class(p[1])
as.numeric(p[1])
p
barplot(p)



y <- c(10, 2, 3)
y[5]
y
as.integer(y[1])
class(as.integer(y[1]))
y$sum <- c(as.integer(y[1])+as.integer(y[2]))
###############
i<-as.vector(c[,1])
class(i)
i
i[1]
class(c[1,1])
c[,1]
h <- c(c[,1])
h
c[1,2]
################
b <- table(hflights$Dest)
b <- as.data.frame(b)
b

c <- subset(b, Freq>6000)
c

d <- c(i[1] = c[1,2])
d <- c("a" = c[1,2])
d
d <- c(as.character(c[1,1]) = c[1,2])
c[[1]]
c[1,1]
c[[1,1]]


as.character(c[1,1])
class(as.character(c[1,1]))
e <- "b"
f <- c(e = 1)


plot(c)
barplot(c)

# 강사님 답
TotalCount <- table(hflights$Dest)
TotalCount
TotalCount2 <- TotalCount[TotalCount >= 6000]
TotalCount2
addmargins(TotalCount2, 1)
TotalCount2
barplot(TotalCount2)
