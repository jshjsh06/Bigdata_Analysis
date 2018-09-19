# Factor
myData1 <- c('Male', 'Male', 'Female', 'Male')
myData1
is.factor(myData1)

myData1_factors <- factor(myData1)
myData1_factors

myData2_factors <- factor(myData1, levels = c('Male', 'Female', 'Nothing'))
myData2_factors

myData3 <- gl(3,4, labels = c('Male', 'Female', 'Nothing')) # gl은 각각 만드는 갯수를 지정해서 factor 생성
myData3

# 행렬
myMatrix1 <- matrix(c(3:14), nrow = 4, byrow = TRUE)
myMatrix1

myMatrix2 <- matrix(c(3:14), nrow = 4, byrow = FALSE)
myMatrix2

nrow(myMatrix2)
ncol(myMatrix2)
dim(myMatrix2)

# 행과 열 이름 설정
myMatrix3 <- matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames = list(rownames1, colnames1))
rownames1 <- c('row1', 'row2', 'row3', 'row4')
colnames1 <- c('col1', 'col2', 'col3')
myMatrix3

# 행열 값 호출
myMatrix3[,2]
myMatrix3[3,]
myMatrix3[1,1]

# matrix간 연산
myMatrix4 <- matrix(c(1,2,3,4), nrow = 2)
myMatrix4
myMatrix5 <- matrix(c(5,6,7,8), nrow = 2)
myMatrix5
myMatrix4 + myMatrix5
myMatrix4 * myMatrix5
myMatrix4 %*% myMatrix5

# 벡터를 행렬로 만들기, 이름 넣어보기
column.names1 <- c('col1','col2','col3')
row.names1 <- c('row1','row2','row3')
matrix.names1 <- c('matrix1', 'matrix2')
myVector1 <- c(1,2,3)
myVector2 <- c(1,2,3,4,5,6)
myArray <- array(c(myVector1, myVector2), dim = c(3,3,2), dimnames = list(column.names1, row.names1, matrix.names1))
myArray


# 리스트
myList <- list('이순신', 'yellow', c(1,2), TRUE, 13.3)
myList

myList1 <- list(1,2,3)
myList2 <- list(2,3,4)
myList3 <- c(myList1, myList2)
myList3
myVector1 <- c(1,2,3)
myVector2 <- c(2,3,4)
myVector3 <- c(myVector1, myVector2)
myVector3
# list to vector
myVector4 <- unlist(myList1)
myVector4
# DataFrame
emp.data <- data.frame(
  emp_id = c(1:3),
  emp_name = c("이순신", "이순신","권율"),
  salary = c(1000,2000,3000),
  start_date = as.Date(c("2018-09-19","2018-09-19","2018-09-19")),
  stringsAsFactors = TRUE
)
emp.data
str(emp.data)
summary(emp.data)

dim(emp.data) 
names(emp.data) # 열의 이름을 알 수 있다.
names(emp.data)[3]

emp.data$emp_name
class(emp.data$emp_name)

# 데이터 프레임 열을 따서 새로운 데이터 프레임 생성
emp.data2 <- data.frame(emp.data$emp_id, emp.data$emp_name)
emp.data2

emp.data[1:2, 1:2]
emp.data[c(1,2), c(1,2)]

# 데이터 프레임에 새로운 열 추가
emp.data$dept <- c('구매팀', '생산팀', 'CEO')
emp.data

emp.data["dept"]

# 데이터 프레임을 Factor 형으로 변환하기
emp.data$dept <- factor(emp.data$dept, levels = c('구매팀', '생산팀', 'CEO', '전략팀'))
emp.data
emp.data$dept

# varhandle 패키지로 unfactor 실행하기
install.packages("varhandle")
library(varhandle)
emp.data$dept <- unfactor(emp.data$dept)
emp.data
emp.data$dept
str(emp.data)

