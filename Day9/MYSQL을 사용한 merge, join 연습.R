'''
id = root, pwd =1234
host =

외부접속
70.12.115.68(ip address)
www.test.co.kr(domain address, 가칭*)
내부접속
M150118(computer name)
localhost(local name)
127.0.0.1(local ip address)
'''

'''
# RStuio에서 설정 
install.packages("RMySQL", type = "source")
library(RMySQL)

RMySQL::dbConnect(
drv,      # 데이터베이스 드라이버(RPgSQL, ROracle, MySQL 등)
user,     # 사용자 이름
password, # 비밀번호
dbname,   # 데이터베이스 이름
host      # 호스트
)

RMySQL::dbListTables(
conn # 데이터베이스 접속
)

RMySQL::dbGetQuery(
conn, # 데이터베이스 접속
statement # 수행할 질의
)

예)
> con <- dbConnect(MySQL(), user="rprogramming", password="<비밀번호>", dbname="rprogramming", host="127.0.0.1")

> dbListTables(con)
> dbGetQuery(con, "select * from score");

'''

library(RMySQL)

con2 <- dbConnect(
  MySQL(), # 데이터베이스 드라이버
  user = "user1", # 사용자 이름
  password = "1234", # 비밀번호
  dbname = "employees", # 데이터베이스 이름
  host = "127.0.0.1" # 호스트
)

con <- dbConnect(
  MySQL(), # 데이터베이스 드라이버
  user = "root", # 사용자 이름
  password = "1234", # 비밀번호
  dbname = "employees", # 데이터베이스 이름
  host = "127.0.0.1" # 호스트
)

dbListTables(con)
df <- dbGetQuery(con, "select * from employees")
df2 <- dbGetQuery(con, "select * from dept_emp")
df3 <- dbGetQuery(con, "select * from departments")
df4 <- dbGetQuery(con, "select * from salaries")
colnames(df)
colnames(df2)
colnames(df3)
colnames(df4)
str(df)
str(df2)

# 데이터 분석
library(dplyr)
library(magrittr)
df %>% select(emp_no, gender) %>% filter(gender == "M") %>%head(10)

  # 기본키, 외래키 기준으로 join하기
colnames(df)
colnames(df2)
left_join(df, df2, by = "emp_no") %>% head(10)
right_join(df, df2, by="emp_no") %>% head(10)
inner_join(df, df2, by="emp_no") %>% head(10)

  # merge
merge(df, df2, by=NULL) %>% head(10) # 일치 없이 모든 데이터 합병 => 너무 데이터가 커서 안됨
merge(df, df2, by = "emp_no") %>% head(10) # 기본. emp_no 기준으로 합병
merge(df, df2, by = "emp_no", all.x = TRUE) %>% head(10) # emp_no 기준으로 찾되 df는 모두 반영. df의 null값도 넣겠다는 의미 
merge(df, df2, by = "emp_no", all.y = TRUE) %>% head(10)
merge(df, df2, by.x = "emp_no", by.y = "emp_no") %>% head(10)


# apply
theMatrix <- matrix(1:9, nrow=3)
theMatrix
apply(theMatrix, 1, sum) # 각 행의 합
apply(theMatrix, 2, sum) # 각 열의 합

apply(df, 1, max)
apply(df, 2, max, na.rm = T)


