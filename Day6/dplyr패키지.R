'''
* 데이터 전처리(Preprocessing) - dplyr 패키지
library -> magrittr 필요

filter()	행 추출
select()	열(변수) 추출
arrange()	정렬
mutate()	변수 추가
summarise()	통계치 산출
group_by()	집단별로 나누기
left_join()	데이터 합치기(열)
bind_rows()	데이터 합치기(행)

* 논리 연산자
<	작다
<=	작거나 같다
>	크다
>=	크거나 같다
==	같다
!=	같지 않다
│	또는
&	그리고
%in%	매칭 확인


* 산술 연산자
+	더하기
-	빼기
*	곱하기
/	나누기
^ , **	제곱
%/%	나눗셈의 몫
%%	나눗셈의 나머지
'''
# 데이터 불러오
install.packages("dplyr")
library(magrittr)
library(dplyr)
data <- read.csv("example_exam.csv")
data
str(data)

# filter 사용해보기
data %>% filter(class == 1)
filter(data, class == 1)
data %>% filter(class == 2)
filter(data, class == 2)
data %>% filter(class != 1)
filter(data, class != 1)

# &(and), |(or)
data %>% filter(class == 1 & math >= 50)
data %>% filter(english < 90 | science < 50)

# %in%
data %>% filter(class %in% c(1,3,5)) # class 값이 1, 3, 5 인 값을 가져옴

# 변수에 넣기
r <- data %>% filter(math > 50)
r
str(r)

data1 <- data %>% filter(class == 1)
mean(data1$math)

# mtcars 사용
'''
mtcars : Motor Trend Car Road Test의 약자로 1974년 미국의
Motor Trend의 잡지로 부터 추출된 자료임
각기 종류가 다른 32대의 자동차(1973-74년)를 대상으로 
조사된 자료로서 연비와 다른 10개의 독립변수로 이루어짐

mpg(Miles/gallon) - 연비
cyl(Number of cylinders) - 실린더수
disp(Displacement) - 배기량
hp(Gross horsepower)  - 마력
drat(Rear axle ratio) - 후방 차축 비율
wt(Weight(lb/1000)) - 차체 몸무게
qsec(1/4 mile time) - 400m까지 걸리는 시간(드래그 레이스 타임)
vs(V/S)
am(Transmission(0 = automatic, 1 = manual)) - 미션종류
carb(Number of carburetors) - 기화기 수

'''
mtcars
library(ggplot2)
mpg

# mpg와 dplyr 사용 문제
'''
1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려고 합니다. 
displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 높은 것은?

2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 합니다. 
"audi"와 "toyota" 중 어느 manufacturer(자동차 제조 회사)의 cty(도시 연비)가 평균적으로 높은 것은?

3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 합니다. 
이 회사들의 자동차를 추출한 뒤 hwy 전체 평균은?

'''

# 문제 1

mpg2 <- mpg
displ_4 <- mpg2 %>% filter(displ <= 4)
mean(displ_4$hwy)

displ_5 <- mpg2 %>% filter(displ >= 5)
mean(displ_5$hwy)

# 문제 2
manu_audi <- mpg2 %>% filter(manufacturer == "audi")
manu_audi
mean(manu_audi$cty)

manu_toyota <- mpg2 %>% filter(manufacturer == "toyota")
manu_toyota
mean(manu_toyota$cty)

# 문제 3
manu_CFH <- mpg2 %>% filter(manufacturer == "chevrolet" | manufacturer == "ford" | manufacturer == "honda" )
#manu_CFH <- mpg2 %>% filter(manufacturer %in% c('chevrolet', 'ford', 'honda'))
manu_CFH $ manufacturer
mean(manu_CFH$hwy)


# dplyr - select 사용해보기
data %>% select(english, math, class) %>% head(3)

data %>% select(-english) %>% head(3)

data %>% filter(class == 1) %>% select(-math) %>% head(3)

# 정렬 arrange 사용해보기
data %>% arrange(math) %>% head(5)
data %>% arrange(desc(math)) %>% head(5)
data %>% arrange(desc(math), english) %>% head(5)

mpg2 %>% filter(manufacturer == 'audi') %>% arrange(desc(hwy)) %>% select(manufacturer, hwy) %>% head(5)

# 열추가 mutate 사용해보기
data %>% mutate(total = math + english + science) %>% head(5)
