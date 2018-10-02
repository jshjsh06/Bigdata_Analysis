library(dplyr)
library(magrittr)
data <- read.csv("example_data.csv")
data
str(data)
select(data, Index)
d <- data %>% select(Index, State)
head(d, 3)
data %>% select(-Index, -State)
data %>% select(-c(Index, State))
select(data, starts_with("Y"))
select(data, ends_with("5"))
select(data, -starts_with("Y"))
select(data, contains("l"))
# starts_with(), ends_with(), contains(), matches(), one_of(), num_range(), everything()
select(data, State, everything())

# rename
colnames(data)
data2 <- rename(data, Index1=Index)
colnames(data2)

filter(data, Index == "A")
filter(data, Index %in% c("A","C") & Y2002)
filter(data, grepl("Ar", State))

summarize(data, mean=mean(Y2015), y2015_median = median(Y2015))
# vars는 함수를 적용할 대상, funs는 함수 종류
summarize_at(data, vars(Y2005,Y2006), funs(mean, median))

myTop <- function(x, N=5) {
  x %>% arrange(desc(Y2005)) %>% head(N)
}

data %>% group_by(State) %>%do(myTop(.,N=3))

dim(data) # 행과 열을 보여줌
d1 <- select(data, Index, State)
head(d1,2)
dim(d1)



# distinct 중복을 제거하고 목록만 출력
library(dplyr)
library(magrittr)
data <- read.csv("example_data.csv")
data

distinct(data, Index) # dplyr에 있음. 데이터프레임 사용
class(distinct(data, Index))
unique(data$Index) # base에 있음. 데이터프레임 사용하지 않음
class(unique(data$Index))

distinct(df1, ID)
distinct(data, Index, State)
distinct(data, Index, State, .keep_all = T) # keep_all은 모든 열값 추



# 함수 이해
t <- 1
f <- function(x, add=1){
  x + add
}
f(t)
f(t, add=2)
s <- 3
t %>% f(s, add=.) # .은 자신을 가리킴 
t %>% f()
t %>% f(1, add=.)
f(f(f(t,1),2),3)
t %>% f(1) %>% f(2) %>% f(3)

