'''
1. 제공되는 파일들
아파트(매매)_실거래가_201801 ~ 9.xls를 import하여 2018년 1월 ~ 9월까지의 서울특별시에 해당하는 구별 매매가 평균을 구하시오.

참고) xls를 파일을 개별적으로 read하지 말고 
loop식을 이용하여 합꺼번에 read하도록 한다.

출력 예)
year_month	city	price
201801		강남구 	2000000

'''
install.packages("readxl")
library(readxl)

# skip의 중요성!
a <- read_excel('apt_data/아파트(매매)_실거래가_201801.xlsx', skip = 16)
read_excel('apt_data/아파트(매매)_실거래가_201802.xlsx', skip = 16)

theFiles <- dir("apt_data/")
i <- 0

for(a in theFiles) {
  print(a)
}

# 책 259p 참조
for(a in theFiles) {
  # nameToUse <- str_sub(string = a, start = 1, end = 19) # ★★★  파일명을 만들기 위해서 사용하는 구문이다.
  i <- i + 1
  nameToUse <- paste0("APT", i)
  temp <- read_excel(paste0("apt_data/",a), skip = 16)
  assign(x = nameToUse, value = temp) # assign은 변수를 만들어서 값을 넣는 것인데, loop문에서 이렇게 주로 쓰인다.
  print(nameToUse)
}
# 차근히 되짚어보자. nameToUse 변수는 for문을 돌면서 각각 다른 변수를 만들기 위해 선언한거야. APT1, APT2..
# temp는 말그대로 excel파일을 읽는 것이고, 파일위치를 잡기위해 paste0을 사용했어. 그리고 16행부터 시작해
# assign은 변수를 만들어서 값을 넣는 과정을 한번에 처리해주는 함수야. APT1 <- "~~"를 조금 더 간편하게 해줘
# assign은 이렇듯 반복문에 주로 쓰여.

str(APT1) # 계약년월이 다르다.
str(APT9) # 계약년월이 다르다.

#APT1 ~ APT9 를 합치는 것은 rbind 를 사용한다.
b <- data.frame(A = c("a","b","c"), B = c(1, 2, 3))
c <- data.frame(A = c("d","e","f"), B = c(4, 5, 6))
b
c
rbind(b, c)

str(APT1)
str(APT2)

tmp2 <- rbind(APT1, APT2)
str(tmp2)

APTList <- list(APT1, APT2)

# ★★★ APT1, APT2...객체를 사용하기 위해서는 "APT1", "APT2"..와 같은 문자열을 사용할 수 없다.
# 이렇듯 문자열을 객체(실제변수)로 바꿔주는 것이 eval(parse()) 이다. 책 262p
eval(parse(text = "APT1"))

APT <- APT1

for(i in 2:9) {
  dataName <- paste0("APT", i)
  print(dataName)
  APT <- rbind(APT, eval(parse(text = dataName)))
}

# 최종적으로 합쳐진 APT
str(APT)
tmpApt <- APT
library(dplyr)
library(magrittr)

# 원활한 로드를 위해 colname 바꿔주기
names(tmpApt)[1] <- "city"
names(tmpApt)[9] <- "transaction"
names(tmpApt)
head(tmpApt$transaction)

# transaction은 지금 integer가 아니라 character이다. 게다가 ","가 있어서 바로 integer 변환이 안된다.
class(tmpApt$transaction)
  # 우선 ","를 제거해준다.
tmpApt$transaction <- str_replace(string=tmpApt$transaction, pattern=",", replacement="")
tmpApt$transaction <- as.integer(tmpApt$transaction)
  
# 서울특별시에 해당하는 구 모두 표현할 때
tmpApt %>% select(city, transaction) %>% filter(str_sub(string = city, start = 1, end = 5) == "서울특별시") %>% group_by(city) %>% summarise(avgAmount = mean(transaction))

# 서울특별시 전체를 요약하고자 할때
  # str_split_fixed를 통해 city를 좀더 세분화한다.
tmpApt2 <- cbind(tmpApt, str_split_fixed(tmpApt$city, " ", 3))
head(tmpApt2)

names(tmpApt2)
names(tmpApt2)[13] <- "city1"
str(tmpApt2)

tmpApt2 %>% select(city1, transaction) %>% filter(city1 == "서울특별시") %>% group_by(city1) %>% summarise(avgAmount = mean(transaction))



####################### 강사님 답
library(dplyr)
library(magrittr)
library(readxl)

df <- data.frame()
for(i in 1:9){
  file <- paste0("C:\\MyRWorkshop\\LJS_TEST1\\아파트(매매)_실거래가_20180",i,".xlsx")
  print(file)
  data1 <- read_excel(file, skip = 16)
  rbind(data, data1) #paste0 공백 없애주기
}

df <- read_excel("아파트(매매)_실거래가_201806.xlsx",
                 skip = 16) #skip 16번째까지 skip
library(readxl)
library(stringr)
library(dplyr)


df <- read_excel("아파트(매매)_실거래가_201806.xlsx",
                 skip = 16)

colnames(df)
df2 <- data.frame(df$계약년월,
                  df$계약일,
                  df$시군구, 
                  df$`거래금액(만원)`)

colnames(df2) <- c('year_month',
                   'date',
                   'address',
                   'price')
df3 <- filter(df2, grepl('서울',address))
View(df3)
address2 <- str_split_fixed(df3[,3], " ", 4)
View(address2)
address2[,2]
df4 <- data.frame(df3$year_month,
                  address2[,2],
                  df3$price)
df4
colnames(df4)
str(df4)

df4 %>% group_by(df3.year_month, 
                 address2...2.) %>% 
  summarise(mean(df3.price))
