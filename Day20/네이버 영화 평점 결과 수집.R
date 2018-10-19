library(httr)
library(rvest)
library(dplyr)
library(stringr)
library(magrittr)
library(zoo)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

url <- 
  "https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur&tg=0&date=20181015"
res <- GET(url)
html_source <- read_html(res, encoding = "ms949")
title <- html_nodes(html_source, ".title")
rating <- html_nodes(html_source, ".point")
#length(title)
#length(rating)
title <- html_text(title)
rating <- html_text(rating)
title <- gsub("\r|\n|\t", "", title)
df <- data.frame(title, rating)

url_main <- "https://movie.naver.com/movie/sdb/rank/rmovie.nhn?sel=cur&tg=0&date="
selected_date <-c("01/09/2018","02/09/2018","03/09/2018","04/09/2018","05/09/2018",
                  "06/09/2018","07/09/2018","08/09/2018","09/09/2018","10/09/2018",
                  "11/09/2018","12/09/2018","13/09/2018","14/09/2018","15/09/2018",
                  "16/09/2018","17/09/2018","18/09/2018","19/09/2018","20/09/2018",
                  "21/09/2018","22/09/2018","23/09/2018","24/09/2018","25/09/2018",
                  "26/09/2018","27/09/2018","28/09/2018","29/09/2018","30/09/2018")
df <- data.frame(stringsAsFactors = F)
for(i in date(as.Date(selected_date,"%d/%m/%Y"))){
  s_date = (gsub("-", "", as.Date(i)))
  url_all <- paste0(url_main, s_date)
  res <- GET(url_all)
  html_source <- read_html(res, encoding = "ms949")
  title <- html_nodes(html_source, ".title")
  rating <- html_nodes(html_source, ".point")
  title <- html_text(title)
  rating <- html_text(rating)
  title <- gsub("\r|\n|\t", "", title)
  df_temp <- data.frame(title, rating, stringsAsFactors = F)
  df <- rbind(df, df_temp)
}
df$rating <- as.numeric(df$rating)
#str(df)
df %>% 
  group_by(title) %>% 
  summarise(rating2 = mean(rating)) %>% 
  arrange(desc(rating2)) %>% 
  head(10)


for






