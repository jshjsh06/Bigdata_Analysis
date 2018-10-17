'''
차종 중에 Honda차종만 추출하여 데이터 프레임을 구성하시오.
(R에서 제공하는 mtcars를 이용함)
(변수컬럼 의미혼동 : 연비(mpg: mile per gallon), 배기량(disp : displacement))
thomas194511@gmail.com
'''

library(ggplot2)
library(dplyr)

##### 1. mtcars의 열에 Honda만 추출하여 데이터 프레임을 만드는 방법
mtcars_data1 <- as.data.frame(mtcars)
rownames(mtcars_data1) # rownames를 확인해보면 Honda Civic은 19행에 있다는 것을 알 수 있다.
mtcars_data1[19,] # 19행 데이터를 확인해본다.
mtcars_data2 <- mtcars_data1[19,] # 19행 행을 따로 변수에 저장한다.
mtcars_data2

##### 2. mpg의 열에 honda 차종만 추출하여 데이터 프레임을 만드는 방법
mpg_data1 <- as.data.frame(mpg) 
mpg_data2 <- data %>% filter(manufacturer == "honda")
mpg_data2 # honda 제조사만 분류된 것을 확인할 수 있다.

##### 3. 만약 mtcars 데이터가 많은경우, 분리해서 찾는 방법
a <- as.data.frame(mtcars)
str(a) # 32개의 행이 있는 것을 확인할 수 있다.
b <- str_split(rownames(data2), " ") # 행의 앞에 Honda라는 이름만 추출할 수 있도록 str_split으로 분리한다.
c <- data.frame("Honda" = 1:32) # 분리한 b를 넣을 수 있는 data.frame c를 선언한다.

for(i in 1:32) {
  c[i, 1] = b[[i]][1] # 반복문을 사용하여 c에 제조사명이 들어갈 수 있도록 한다.
}
c # 제조사명만 잘들어간 것을 확인할 수 있다.

d <- cbind(a,c) # 기존 mtcars에 제조사명만 분리한 c를 합친다.
d %>% filter(Honda == "Honda") # Honda만 분리되어 보이는 것을 알 수 있다.

'''
문제2
도착횟수가 6000횟수가 넘는 항공사를 찾고 그래프로 표현
'''

library(hflights)
head(hflights)
# 1. 항공사를 uniqueCarrier로 계산했을 시
hflights.data2 <- table(hflights$UniqueCarrier)  # UniqueCarrier를 table로 값을 변환한다.
hflights.data2.subset <- subset(hflights.data2, hflights.data2>6000) # table에서 값이 6000회 이상인 값을 분류
hflights.data2.subset
barplot(hflights.data2.subset) # 분류한 값을 barplot으로 그래프 표현

# 2. '도착횟수'를 기준으로 항공을 구할 시
hflights.data1 <- table(hflights$Dest) # Dest가 도착횟수를 의미하므로 Dest를 table로 값을 변환
hflights.data1.subset <- subset(hflights.data1, hflights.data1>6000) # table에서 값이 6000회 이상인 값을 분류
hflights.data1.subset
barplot(hflights.data1.subset)