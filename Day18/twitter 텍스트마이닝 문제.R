'''
1. 어제 제공했던 twitter.csv를 이용하여 트윗 텍스트 마이닝을 하고 단어의 빈도를 나타내는 막대 그래프를 출력하시오.
그리고, Wordcloud를 만드시오.
'''

library(KoNLP)
library(dplyr)
library(ggplot2)
library(wordcloud)
library(stringr)

twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")

twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")

nouns <- extractNoun(twitter$tw)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word <- filter(df_word, nchar(word) >= 2)

top20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

top20


# order <- arrange(top20, freq)$word  
# ggplot(data = top20, aes(x = word, y = freq)) + ylim(0, 2500) + geom_col() + coord_flip() + scale_x_discrete(limit = order) + geom_text(aes(label = freq), hjust = -0.3)  



pal <- brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(words = df_word$word, freq = df_word$freq,
          #min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)
