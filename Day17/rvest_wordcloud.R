rm(list=ls())
install.packages("scam")
install.packages("RSelenium")
install.packages("igraph")
install.packages("qdap")
install.packages("text2vec")
install.packages("RWeka")
install.packages("ggmap")
install.packages("rworldmap")
install.packages("rworldxtra")
library(rvest) # R webscraping package
library(RSelenium) # R login package
library(igraph)
library(qdap)
library(text2vec)
library(data.table)
library(stringr)
library(tm)
library(RWeka)
library(tokenizers)
library(slam)
library(wordcloud) # 워드클라우드
library(ggplot2) # 그래프
library(scam)
library(NLP) # word parsing package
library(openNLP)
library(ggmap)
library(rworldmap)
library(rworldxtra)

text.clean = function(x)                    
{ require("tm")
  x  =  gsub("<.*?>", " ", x)               # HTML 태그를 제거하기위한 정규 표현식
  x  =  iconv(x, "latin1", "ASCII", sub="") # ASCII 문자 유지
  x  =  gsub("[^[:alnum:]]", " ", x)        # 영문숫자만 유지 
  x  =  tolower(x)                          # 소문자로 변환
  x  =  removeNumbers(x)                    # 숫자 제거
  x  =  stripWhitespace(x)                  # 공백제거
  x  =  gsub("^\\s+|\\s+$", "", x)          # 선행 및 후행 공백 제거
  x  =  gsub("'", " ", x)
  return(x)
}
counts = c(0,10,20,30,40,50)
reviews = NULL

reviews = gsub("\n",' ',reviews)
#writeLines(reviews,'Wall-e reviews.txt')

temp.text = readLines(file.choose())  #  Wall-e reviews
head(temp.text, 4)

# 예시
# http://www.imdb.com/title/tt0910970/reviews?filter=love;filter=love;start=40
#url <- "http://www.imdb.com/title/tt0910970/reviews?filter=love;filter=love;start=10"
url <- "http://www.imdb.com/title/tt0910970/reviews?filter=love;filter=love;start=10"
url
page1 <- read_html(url)
class(page1)
filter_page1 <- html_nodes(page1, ".content")
filter_page1
length(filter_page1)
data <- html_text(filter_page1) # 살펴보면 \n이 들어간 것을 확인할 수 있다.
data <- gsub("\n", " ", data) # \n을 삭제함. 기본적으로는 이렇게 삭제한다.
data <- gsub("'", " ", data) # ' 를 삭제
text.clean(data) # 데이터를 완전 깔끔해주게 해주는 위의 text.clean을 해준다.
data2 <- text.clean(data)

library(tm)
stopwords("english") # 조사, 주어 등을 모아놓은 곳. 이것을 활용하여 데이터를 더 정제할 수 있다. 
stopword2 <- stopwords("english")
data2 <- removeWords(data2, stopword2)
data2 # 주어, 조사 등이 삭제데어 거의 단어만 완전히 남은 것을 볼 수 있다.
data2 <- stripWhitespace(data2) # 띄어쓰기가 조절된다.
data2
length(data2) # 25개 리뷰
data3 <- data2[1]
data3
data3 <- strsplit(data3, " ") # 데이터를 띄어쓰기 기준으로 분
data3 <- table(data3)
data3
# 상위 가장 빈도수 높은 단어 10개 추출
library(dplyr)
data3 <- as.data.frame(data3)
colnames(data3) <- c("words", "count")
str(data3)
data3 %>% arrange(desc(count)) %>% filter(count >= 3)



# html_nodes => 25건으로 된 경우 동일한 처리를 하시오
# list를 하나씩 빼온다. 뺀 리스트([1], [2],...)는 gsub, text.clean, removewords, stripwhitespace를 정리한다.
# 정리한 리스트는 data1, data2..에 각각 넣는다.
for(i in 0:24) {

  
  }

