# 문자열처리
library(stringr)
data <- c("i", "am", "a", "data scientist")
str_length(data) # stringr
nchar(data) # base
length(data)

data2 <- "I am a data scientist"
str_sub(data2, 1, 4)
str_sub(data2, 6, 8)
substr(data2, 1, 4)
substr(data2, 6, 8)

paste(c("i am a", " data scientist"))
paste("i", "am", "a", "data", "scientist")
paste0(c("i am a", " data scientist"))
paste0("i", "am", "a", "data", "scientist")

str_split(data2, " ")
str_split(data2, " ", 1)
str_split(data2, " ", 2)
str_split(data2, " ", 3)
str_split(data2, " ", 4)

data5 <- "010-1212-3434"
str_split(data5, "-", 3)
data5 <- str_split_fixed(data5, "-", 3)
data5
data5[1,1]
data6 <- c("서울특별시 강남구 1111 2222", "서울턱별시 강서구 1111, 2222")
str_split_fixed(data6, " ", 4)

# 정규표현식을 활용한 문자열 처리
data7 <- c("apple", "b0anana", "strawberry")
str_detect(data7, "n")
str_detect(data7, '[a-z]')
str_detect(data7, '^[a-z]{2}') # '^'처음부터 a-z 가 '{2}' 2자리나와야한다. 

str_extract(data7, '^[a-z]{2}')

grep("\\d", data7, value=TRUE) # 숫자가 들어간 요소에 대해서만 추출

phones <- c("010 2879 2020", "032-123-4242", "031 232 1919", "02 1818 2323", "010 1111 2223")
phonePattern <- "([0-9]{3})[-.]([0-9]{3})[-.]([0-9]{4})"
str_extract(phones, phonePattern)

data8 <- c("apple", "b0anana", "strawberry")
str_replace(data8, "[ae]", "-")
str_replace_all(data8, "[ae]", "-")



