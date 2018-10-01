'''
plyr
dplyr

tidyverse
- ggplot2
- dplyr(대세)
- readr
- tibble
- tidyr
- purrr
- stringr
- forcats
'''
'''
dplyr의 메소드들
filter
select
arrange
mutate
summarize
group_by
left_join()
bind_rows()
'''
library(magrittr)
library(dplyr)
df <- read.csv("example_exam.csv")
df %>% filter(class == 1)
df %>% filter(math > 50)
filter(df, math >50)
df %>% filter(english > 40) %>% head(3)
df %>% filter(class %in% c(1,4,5))

library(ggplot2)
str(mtcars)
str(mpg)

mpg2 <- as.data.frame(mpg)
df2 <- mpg %>% filter(manufacturer %in% c("ford", "honda"))
mean(df2$hwy)

df %>% select(class, math) %>% filter(class > 1)
df %>% select(-class)
df %>% arrange(-math) %>% head(5)
df %>% arrange(desc(math)) %>% head(5)

df2 <- df %>% mutate(total = math + science + english, mean = (math + english + science) / 3)
df %>% mutate(total = math + science + english, mean = (math + english + science) / 3) %>% select(total, mean) %>% head(10)
df %>% mutate(total = math + science + english, mean = total / 3)
df %>% mutate(total = math + science + english, mean = total / 3)
df3 <- df %>% mutate(check = ifelse(math > 60, "합격", "과락"))
df3              
colnames(df3)[6] <- "PassFail"
colnames(df3)


diamonds %>% filter_("cut == 'Ideal'")
diamonds %>% filter(cut == 'Ideal')
diamonds %>% filter_(~cut == 'Ideal')


# 인용을 풀어서 사용하는 방
theCol <- "cut"
theCut <- "Ideal"
library(rlang)
diamonds %>% filter(UQE(as.name(theCol)) == theCut)

# slice 행 번호 필터링
diamonds %>% slice(1:5)
diamonds %>% slice(c(1:5, 8, 15:20))

# summarize(mean, median, sum, min, max, n)
summarize(diamonds, mean(price))
diamonds %>% summarize(mean(price))
diamonds %>% summarize(AvgPrice = mean(price), MedianPrice = median(price), AvgCarat = mean(carat), n= n())

# group_by
diamonds %>% group_by(cut) %>% summarize(AvgPrice = mean(price))
diamonds %>% group_by(cut) %>% summarize(AvgPrice = mean(price), SumCarat = sum(carat))
diamonds %>% group_by(cut, color) %>% summarize(AvgPrice = mean(price), SumCarat = sum(carat))
diamonds %>% group_by(carat)

# do 
topN <- function(x, N=5) {
  x %>% arrange(desc(price)) %>% head(N)
}

diamonds %>% group_by(cut) %>% do(topN(., N=3))
diamonds %>% group_by(cut) %>% do(top = topN(., N=3))


# 문제 1
str(mpg2)
mpg3 <- mpg2 %>% group_by(manufacturer) %>% filter(class == "suv") %>% mutate(sumcty = (cty + hwy) / 2, avgcty = mean(cty + hwy)) %>% arrange(-avgcty) %>% head(5)
mpg3
# 문제 2
mpg4 <- mpg2 %>% group_by(manufacturer) %>% summarize(mhwy = mean(hwy)) %>% arrange(-mhwy) %>% head(3)

