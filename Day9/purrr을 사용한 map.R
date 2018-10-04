# purrr
library(purrr)
theList <- list(
  a = matrix(1:9, 3),
  b = 1:5,
  c = matrix(1:4, 2),
  d = 2
)
# map. lapply와 비슷하다. 여기에 파이프 기능을 사용할 수 있게 됨
theList$a
lapply(theList, sum)
map(theList, sum)

myFunc <- function(a) {
  return(a + 1)
}
# 아래 3개 식은 동일하다.
map(theList, myFunc)
theList %>% map(myFunc)
map(theList, function(a){a+1})

# 무명함수 사용하기
theList %>% map(function(x) sum(x, na.rm = TRUE))
theList %>% map(sum, na.rm = TRUE) # 위와 같음 

# map_int
theList %>% map_int(NROW)
# map_dbl
theList %>% map_dbl(mean)

# map_chr
theList %>% map_chr(class)
theList %>% map(class)
# map_lgl
theList %>% map_lgl(function(x) NROW(x) < 3)

# map2, pmap
firstList <- list(A = matrix(1:16, 4), B = matrix(1:16, 2), c = 1:5)
secondList <- list(A = matrix(1:16, 4), B = matrix(1:16, 8), c = 15:1)
firstList
secondList

simpleFunc <- function(x, y) {
  NROW(x) + NROW(y)
}

map2(firstList, secondList, simpleFunc)
pmap(list(firstList, secondList), simpleFunc)
pmap_int(list(firstList, secondList), simpleFunc)