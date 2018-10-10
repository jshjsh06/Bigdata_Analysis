# 중심극한정리
# 표본평균 => 모집단 평균
library(ggplot2)
install.packages("devtools")
library(devtools)
install_github("kassambara/easyGgplot2")
library(easyGgplot2)
library(data.table)

#me_2765tmax.txt
data2 <- data.table(read.table("ME_2765tmax.txt", header = F))
data2
class(data2)
# StateId : 2자리 상태코드, 4자리 스테이션 코
colnames(data2) <- c("StateID", "YearDay", "Year", "Month", "MonthDay", "MaxTemp")

ggplot(data=data2, aes(YearDay, MaxTemp)) + geom_point()
hist(data2[,MaxTemp], xlab="Temp")
ggplot(data=data2, aes(MaxTemp)) + geom_density()

# 평균, 표준편차
table(data$Year)
range(data$Year)
data2[, mean(MaxTemp, na.rm=T)] # 평균
data2[, sd(MaxTemp, na.rm=T)] # 표준편차
data2[, sample(MaxTemp, 10000)]

################################################################################################
# me_2765tmax.txt 데이터에서 MaxTemp를 뽑자. 이 데이터에서 랜덤으로 2개를 뽑아서 평균,
# 5개를 뽑아서 평균, 25개, 49개를 뽑아서 평균을 각각 내어서 하나의 테이블에 합쳐보자.
# 그리고 이를 통해 샘플 크기가 클수록 원래 데이터의 평균값, 편차가 비슷하다는 것을 알아보자.
# 함수 Func
  # Size가 2인 변수 생성
SampleMeans <- NULL
Means <- NULL
for(i in 1:1000) {
  Means <- append(Means, mean(data2[, sample(MaxTemp, 2)], na.rm = T)) # data2의 MaxTemp에 존재하는 값들 중 
  # 2개를 임의로 뽑아서 그 두개를 평균을 낸다. 이 값을 Means 변수에 계속 추가하여 넣는다.
  i <- i+1
  print(i)
  if(i==1001) break
}
SampleMeans <- data.table(sampleSize2 = Means)
SampleMeans

  # size가 5인 변수 생성해서 SampleMeans에 추가하기
Means <- NULL
for(i in 1:1000) {
  Means <- append(Means, mean(data2[, sample(MaxTemp, 5)], na.rm = T)) # data2의 MaxTemp에 존재하는 값들 중
  # 5개를 임의로 뽑아서 그 두개를 평균을 낸다. 이 값을 초기화한 Means 변수에 계속 추가하여 넣는다.
  i <- i+1
  if(i==1001) break
}

SampleMeans[, SampleSize5 := Means] # := 는 행에 추가한다는 의미!!
SampleMeans

  # size 25
Means <- NULL
for(i in 1:1000) {
  Means <- append(Means, mean(data2[, sample(MaxTemp, 25)], na.rm = T)) 
  i <- i+1
  if(i==1001) break
}

SampleMeans[, SampleSize25 := Means]
SampleMeans

  # size 49
Means <- NULL
for(i in 1:1000) {
  Means <- append(Means, mean(data2[, sample(MaxTemp, 49)], na.rm = T)) 
  i <- i+1
  if(i==1001) break
}

SampleMeans[, SampleSize49 := Means]
SampleMeans

SampleMeans[1]
data2[, mean(MaxTemp, na.rm = T)]
SampleMeans[1] - data2[, mean(MaxTemp, na.rm = T)]
# 표본 평균의 평균
sapply(SampleMeans, mean)

SampleMeans[1:10, mean(SampleSize5)]
SampleMeans[1:100, mean(SampleSize5)]
SampleMeans[1:500, mean(SampleSize5)]
SampleMeans[1:1000, mean(SampleSize5)]
data2[, mean(MaxTemp, na.rm = T)] # sample이 늘어날 수록점점 이 값과 유사해짐을 알 수 있음

sapply(SampleMeans, sd)

# sqrt는 제곱근함수
SampleMeans[, sd(SampleSize49, na.rm = T)]*sqrt(49)
data2[, sd(MaxTemp, na.rm = T)]

dt1 <- data.table(SampleSize = "SampleSize2", SampleMeans = SampleMeans$SampleSize2)
dt1
dt2 <- data.table(SampleSize = "SampleSize5", SampleMeans = SampleMeans$SampleSize5)
dt2
dt3 <- data.table(SampleSize = "SampleSize25", SampleMeans = SampleMeans$SampleSize25)
dt4 <- data.table(SampleSize = "SampleSize49",  SampleMeans = SampleMeans$SampleSize49)

data_temp <- rbindlist(l=list(dt1, dt2, dt3, dt4))
data_temp

p <- ggplot(data_temp, aes(SampleMeans,fill=SampleMeans, color=SampleSize))
p + geom_density(alpha = 0.1)

