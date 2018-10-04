library(dplyr)
library(magrittr)
library(readxl)

df <- data.frame()
for(i in 1:9){
  file <- paste0("C:\\MyRWorkshop\\LJS_TEST1\\아파트(매매)_실거래가_20180",i,".xlsx")
  print(file)
  data1 <- read_excel(file, skip = 16)
  rbind(data, data1) #paste0 공백 없애주기
}

df <- read_excel("아파트(매매)_실거래가_201806.xlsx",
                 skip = 16) #skip 16번째까지 skip
library(readxl)
library(stringr)
library(dplyr)


df <- read_excel("아파트(매매)_실거래가_201806.xlsx",
                 skip = 16)

colnames(df)
df2 <- data.frame(df$계약년월,
                  df$계약일,
                  df$시군구, 
                  df$`거래금액(만원)`)

colnames(df2) <- c('year_month',
                   'date',
                   'address',
                   'price')
df3 <- filter(df2, grepl('서울',address))
View(df3)
address2 <- str_split_fixed(df3[,3], " ", 4)
View(address2)
address2[,2]
df4 <- data.frame(df3$year_month,
                  address2[,2],
                  df3$price)
df4
colnames(df4)
str(df4)

df4 %>% group_by(df3.year_month, 
                 address2...2.) %>% 
  summarise(mean(df3.price))