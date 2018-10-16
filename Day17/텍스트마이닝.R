# rvest => text mining => wordcloud
# 텍스트 마이닝 : 문자로 된 데이터에서 가치있는 정보를 얻어내는 방법

# 분석순서
# 1. 형태소 분석
# 2. 명사, 동사 형용샤 등의 의미를 지닌 품사 단어 추출
# 3. 빈도표 만들기
# 4. 시각화

# jdk install
install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP") # 파싱해주는 라이브러리
library(rJava)
library(memoise)
library(KoNLP)
useNIADic()

data <- readLines("hiphop.txt")
head(data)
library(stringr)
data <- str_replace_all(data, "\\W", " ")
head(data)

KoNLP::extractNoun("반갑습니다. 즐거운 하루 되세요") # extractNoun는 단어를 분리시켜줌
nouns <- extractNoun(data)
class(nouns)
head(nouns)
data2 <- unlist(nouns)
head(data2)
data3 <- table(data2)
data3
data4 <- data.frame(data3, stringsAsFactors = F)
head(data4)
colnames(data4)
library(wordcloud)
library(RColorBrewer)
set.seed(1234)

pal <- brewer.pal(8, "Dark2")
wordcloud(data4$data2, data4$Freq, min.freq = 2, max.words = 200, random.order = F,
          scale = c(4, 0, 3),
          colors = pal)
