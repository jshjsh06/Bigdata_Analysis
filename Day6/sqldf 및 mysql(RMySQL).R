# sqldf 사용해보기
install.packages("sqldf")
library(sqldf)
?Orange

sqldf('SELECT * FROM Orange')
class(df)


# RMYSQL 사용
'''
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
'''

install.packages("RMySQL", type = "source")
library(RMySQL)

con <- dbConnect(MySQL(), user = "user1", password="1234", dbname="employees", host="70.12.115.72")
dbListTables(con)
dbGetQuery(con, "select * from salaries")

# 자기 자신을 접속할 때에는 localhost, 127.0.0.1 둘 중 하나를 사용
con2 <- dbConnect(MySQL(), user = "root", password="1234", dbname="employees", host="127.0.0.1")
dbListTables(con2)
dbGetQuery(con2, "Select * from salaries")

df <- dbGetQuery(con2, "Select * from salaries")
class(df)
str(df)

# data.table으로 받기
library(data.table)
df <- dbGetQuery(con2, "Select * from employees")
df2 <- data.table(df)
class(df2)
df2[emp_no > 10003,,]

# sqldf로 사용해보기
library(sqldf)
sqldf("select * from df2")

