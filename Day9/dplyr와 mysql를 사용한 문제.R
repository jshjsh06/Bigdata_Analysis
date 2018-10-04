'''
# dplyr
1. 부서중 Development부서의 인원을 출력하시오.
2. employees 부서별 인원을 출력하시오. ★★★
3. employees중에서 월급이 가능 높은 상위 5명을 출력하시오.
4. 부서별로 인원을 출력하고 가장 인원이 많은 부서를 출력하시오.
'''
library(RMySQL)
library(dplyr)
library(magrittr)

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


# 문제 1
colnames(df3)
df3 %>% filter(dept_name == "Development")  # departments에서 devlopment의 dept_no를 찾는다.

df2 %>% filter(dept_no == "d005") %>% head(5)# dept_emp에서 인원을 출력한다.
df2 %>% filter(dept_no == "d005") %>% group_by(dept_no) %>% count(dept_no) # 인원 요약도 가능

# 문제 2 ★★★
df3$dept_no
df2 %>% group_by(dept_no) %>% count(dept_no) # group_by로 분류하고 그 분류를 기준으로 갯수를 센다.
head(df3)

  # 가독성을 위해 dept_name을 join
temp = df2 %>% group_by(dept_no) %>% count(dept_no)
temp
temp2 = left_join(temp, df3, by="dept_no")
colnames(temp2)[2] = c("emp_count") # select 를 사용해도 좋다! 
temp2

# 문제 3
df4 %>% arrange(desc(salary)) %>% head(5)

# 문제 4
df2 %>% group_by(dept_no) %>% count(dept_no) %>% arrange(desc(n))
temp2 %>% arrange(desc(emp_count))

