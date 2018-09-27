'''
1.최초의 커피숍은(운영중)?
2.해마다 오픈한 커피숍 개수는?
3.bar형태의 그래프로 출력하시요.
4.년도별 영업상태를 출력하시오.
5.년도별 여업상태를 비율로 출력하시오.
6.1997년 ~ 2014년 데이터만 저장합니다.
열데이터는(년도, 오픈수, 폐업수, 오픈비율)로 구성
7.ggplot2로 geom_line과 geom_point를 사용해서 출력하시오.
'''

library(data.table)
url <- "../example_coffee.csv"
coffee <- fread(input = url, sep = ",", header = T)
View(coffee)
head(coffee$dateOflicensing)

# 1번 문제 
coffeeOpen <- coffee[coffee$stateOfbusiness == "운영중"]
coffeeOpen[coffee$yearOfStart == 1967]
coffeeOpen["yearOfStart"]
coffee[coffee$stateOfbusiness == "운영중" & coffee$yearOfStart == 1967]



# 2번 문제 
coffeeFactor <- as.factor(coffee$yearOfStart)

levels(coffeeFactor)[1]
table(coffeeFactor)

# 3번 문제
barplot(table(coffeeFactor))


# 4번 문제 (연도별 영업 상태)
num4 <- data.frame(year = coffee$yearOfStart, state = coffee$stateOfbusiness)
table(num4)

# 5번 문제 (5.년도별 영업상태를 비율로 출력하시오.)
prop.table(table(num4))

# 6번 문제
  # 우선 범위를 지정하여 조건으로 분류한다.
num6 <- coffee[coffee$yearOfStart >= 1997 & coffee$yearOfStart <= 2014]
num6
  
  # 날짜와 오픈 상태만 추출하여 data.frame을 만든다.
temp <- data.frame(year = num6$yearOfStart, state = num6$stateOfbusiness)
temp
  # 만든 data.frame을 table로 변환한다.
num6_result <- table(temp)
  # table로 변환한 data.frame을 다시 data.frame으로 만든다.
num6_result_dataframe <- as.data.frame(num6_result)
  # 운영중과 폐업이 분류되서 나타나므로 각각 분리해낸다.
dd <- data.frame(num6_result_dataframe[1:18,])
dd
ee <- data.frame(num6_result_dataframe[19:36,])
ee
  # 분리한 자료를 data.frame으로 다시 합친다.
ff <- data.frame(c(dd,ee))
  # 이름을 설정한다.
colnames(ff) <- c("year", "running", "runningFreq", "year2", "closed", "closedFreq")
  # 겹치는 year을 제거한다.
ff <- ff[-(4)]
ff
  # 오픈 비율을 추가한다.
ff$openrate <- ff$runningFreq/(ff$runningFreq+ff$closedFreq)*100
ff

# 7번 문제

library(ggplot2)

ggplot(ff, aes(x = runningFreq, y = closedFreq)) + geom_point(aes(year = year))
ggplot(ff, aes(x = runningFreq, y = closedFreq)) + geom_line()

head(coffee)
ggplot(coffee, aes(x = coffee$yearOfStart, y = coffee$sizeOfsite)) + geom_point()
ggplot(coffee, aes(x = coffee$yearOfStart, y = coffee$sizeOfsite)) + geom_line()


# 강사님 답
  # 1번 문제
DF <- fread("../example_coffee.csv", header = T, stringsAsFactors = T, data.table = F)
range(DF$yearOfStart, na.rm = T)
DF2 <- subset(DF, subset = (DF$yearOfStart==1964))
DF3 <- subset(DF, subset = (DF$stateOfbusiness == "운영중"))
head(DF3)
range(DF3$yearOfStart, na.rm=T)
DF4 <- subset(DF3, subset = (DF3$yearOfStart == 1967))
DF4

  # 2번 문제
table(DF$yearOfStart)

  # 3번 문제
library(ggplot2)
qplot(DF$yearOfStart, data=DF, geom="bar")

  # 4번 문제
DF5 <- table(DF$stateOfbusiness, DF$yearOfStart)

  # 5번 문
prop.table(DF5)

  # 6번 문제 
library(data.table)
df <- fread("../example_coffee.csv")

Freq <- table(df$stateOfbusiness,
              df$yearOfStart)
which(colnames(Freq) == "1997")
which(colnames(Freq) == "2015")
range(df$yearOfStart, na.rm = T)
Freq <- Freq[,c(30:48)]
Freq2 <- prop.table(Freq, 2)

data2 <- data.frame(colnames(Freq),Freq[1,],Freq[2,],Freq2[1,],Freq2[2,])
data2
data2 <- data.table(data2)
colnames(data2) <- c("Time","Open","Close","POpen","PClose")
rownames(data2) <- NULL
data2

  # 7번 문제
str(data2)
df2 <- data2
ggplot(data=df2,aes(x=Time, y=Close, group=1))+geom_line()+geom_point()
