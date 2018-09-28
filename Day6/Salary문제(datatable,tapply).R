'''
1.월급 평균을 구하고 월급의 범위를 구하시오.
사용함수(mean, range)

2.111만원에서 406만원까지 범위에서 연령대, 성별, 경력별 월급 평균값은?

3. 성별로 평균월급을 구하시오.

4. 경력별 평균월급을 구하시오.

5. 가장 적은 월급을 받은 집단은?
'''
library(data.table)
url <- "example_salary.csv"
salary <- fread(input = url, sep = ",", header = T)
# column 명 바꾸기
names(salary) <- c("age", "monthSalary", "specialYearSalary", "workingHour", "workers", "career", "sex")
# 데이터 중 - 있는 것 제외시키기
salary <- salary[!(salary$specialYearSalary == "-")]
salary

# 문제 1 
# 월급 범위
range(salary$monthSalary)
# 월급이 character 형이므로 integer 형으로 변환
temp <- list(mSalary = salary$monthSalary)
intSalary <- as.integer(temp$mSalary)
intSalary
mean(intSalary)

# salary$monthSalry <- as.integer(salary$monthSalary) 도 가

# 문제 2
# 기존 salary의 monthSalary를 만들어둔 integer형으로 치환
salary$monthSalary <- intSalary
salary
class(salary$monthSalary)
# 111~ 406 범위 추출
salary2 <- salary[salary$monthSalary >= 1117605 & salary$monthSalary <= 4064286]
salary2

table(salary2$age)
table(salary2$sex)
table(salary2$career)
aggregate(salary2$age ~ salary2$monthSalary, salary2, mean)
aggregate(age ~ monthSalary, salary2, mean)

tapply(salary2$monthSalary, salary2$sex, mean)
tapply(salary2$monthSalary, salary2$career, mean)
tapply(salary2$monthSalary, salary2$age, mean)


meanAge <- data.table(age = salary2$age)

# 문제 3   성별로 평균월급을 구하시오.
salary3 <- data.table(sex = salary$sex, monthsalary = salary$monthSalary)
salary3
salary3[, mean(monthsalary), by = sex]

# 문제 4  경력별 평균월급
salary4 <- data.table(career = salary$career, monthsalary = salary$monthSalary)
salary4
salary4[, mean(monthsalary), by = career]




######## 강사님 답 ########
# na = '-'로 하면 - 은 na가 되므로 character가 아닌 숫자형으로 자동으로 변환된다.
df <- read.csv("example_salary.csv",
               stringsAsFactors = T,
               na='-')
str(df)
class(df)
#View(df)
names(df)
colnames(df) <- 
  c('age','salary','sSalary','workTime',
    'numberOfWorker', 'career', "sex")
df
mean(df$salary, na.rm = T)
range(df$salary, na.rm = T)
# 1117605 4064286
which(df$salary == 1117605)
which(df$salary == 4064286)
df[30:48,]
tapply(df$salary, 
       df$sex, 
       mean, 
       na.rm =T)
tapply(df$salary, df$career, 
       mean, na.rm = T)
tapply(df$salary, df$career, 
       range, na.rm = T)

df[which(df$salary == 1172399),]




