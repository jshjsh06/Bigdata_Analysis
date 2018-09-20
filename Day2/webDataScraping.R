install.packages("rvest")
library(rvest)

data<-read_html("https://www.jaredlander.com/data/ribalta.html")
data1<- data %>% html_nodes('.street') %>%html_text()
data1
