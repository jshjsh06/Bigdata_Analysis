'''
3. 다음의 데이터를 확인하고 dplyr에서 제공하는 함수를 사용하여, 가로 합치기과 세로 합치기를 구현하시오.
# 중간고사 데이터 생성
data1 <- data.frame(id = c(1, 2, 3, 4, 5),
midterm = c(61, 83, 70, 91, 84))
# 기말고사 데이터 생성
data2 <- data.frame(id = c(1, 2, 3, 4, 5),
final = c(74, 81, 68, 91, 82))

4. 제공되는 파일 students.csv를 사용하여 키와 몸무게 회귀모델을 구하고 그래프로 출력하시오.
참고사항 : 키(height), 몸무게(weight)
- height : 181 인경우, weight를 예측하시오.
- height : 170, 181, 182, 165 인 경우, weight를 예측하시오.
'''
### 문제 1
library(dplyr)
# 데이터 생성 
  # 중간고사 데이터 생성
data1 <- data.frame(id = c(1, 2, 3, 4, 5), midterm = c(61, 83, 70, 91, 84))
  # 기말고사 데이터 생성
data2 <- data.frame(id = c(1, 2, 3, 4, 5), final = c(74, 81, 68, 91, 82))

# 가로합치기(left_join) : dplyr에서는 left_join이 사용된다.
left_join(data1, data2, by = "id") # data1, data2를 id를 기준으로 합친다.

# 세로합치기(bind_rows) : dplyr에서는 bind_rows를 사용한다.
data3 <- data2 # 변수명을 통일시키기 위해 data3를 만든다.
colnames(data3)[2] = "midterm" # data1의 midterm 또는 data2의 final 중 하나를 통일시킨다. 
                              # 여기선 임의로 mideterm으로 통일한다.
bind_rows(data1, data3) # data1, data3를 세로로 합친다.


### 문제 2

student_data1 <- read.csv("example_studentlist.csv")
str(student_data1) # student_data1을 확인한다.
cor(student_data1$height, student_data1$weight) # height와 weight 상관계수를 확인해본다.

# lm을 사용하여 회귀모델 구하기
  # y를 height, x를 weight로 설정했을 시
lm_result_height <- lm(formula = height ~ weight, data = student_data1) # lm을 사용하여 height를 y축으로 한다.
lm_result_height # 확인하는 방법 1 ==========> y = 0.4388091*weight + 143.1723748
coef(lm_result_height) # 확인하는 방법 2 ====> y = 0.4388091*weight + 143.1723748
summary(lm_result_height) # 확인하는 방법 3 => **를 통해 어느정도 상관관계가 있다는 것을 알 수 있다.

  # y를 weight, x를 height로 설정했을 시
lm_result_weight <- lm(formula = weight ~ height, data = student_data1) # lm을 사용하여 weight를 x축으로 한다.
lm_result_weight # 확인하는 방법 1 ==========> y = 1.003*weight - 109.445
coef(lm_result_weight) # 확인하는 방법 2 ====> y = 1.003*weight - 109.445
summary(lm_result_weight) # 확인하는 방법 3 => **를 통해 어느정도 상관관계가 있다는 것을 알 수 있다.

# 그래프 출력하기 - ggplot을 사용하여 그래프 출력
p <- ggplot(student_data1, aes(student_data1$height, student_data1$weight))
p1 <- p + geom_point() + geom_smooth(method = "lm")
p1

# 예측하기 - predict 사용
predict_data1 <- data.frame("height" = c(181)) # 키 181인 경우를 data.frame에 저장한다.
predict_data2 <- data.frame("height" = c(170, 181, 182, 165)) # 키 170, 181, 182, 165인 경우를 data.frame에 저장한다.
  # 키에 대한 예측이므로 y축이 weight인 lm_result_weight를 사용한다.
predict(lm_result_weight, predict_data1)
predict(lm_result_weight, predict_data2) 

