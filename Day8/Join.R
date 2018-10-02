library(dplyr)
library(magrittr)
library(ggplot2)
# 조인
df1 <- data.frame(ID = c(1:5), w = c('a','b','c','d','e'))
df1
df2 <- data.frame(ID = c(1,7,3,6,8), y = c('e','z','y','l','s'))
df2

  # inner join -> ID가 1, 3 겹치는 2개가 산출. by 는 기본키 외래키 개념이라고 생각하면 됨
inner_join(df1, df2, by="ID")

  # left join -> 왼쪽 테이블 기준으로 산출
left_join(df1, df2, by="ID")

  # right join -> 오른쪽 테이블 기준으로 산출
right_join(df1, df2, by="ID")

  # full join -> 모두 합침
full_join(df1, df2, by="ID")

  # semi join -> 일치하는 값 중 왼쪽 테이블에 열만 출력한다.
semi_join(df1, df2, by="ID")

  # anti join -> 왼쪽 테이블 중 일치하지 않는 값만 출력한다.
anti_join(df1, df2, by="ID")

# 예시1 : log, users, items
set.seed(1)
log <- data.frame(
  user_id = sample(c(1,2,3), 10, TRUE),
  item_id = sample(c(1,2,3), 10, TRUE),
  correct = sample(c(0,1), 10, TRUE)
) %>% as.tbl # 테이블로 변환함

users <- data.frame(
  user_id = c(1,2,3,4),
  age = c(21, 24, 30, 23)
) %>% as.tbl
items <- data.frame(
  item_id = 1:3,
  item = c("1+1", "2*2", "3/3")
) %>% as.tbl

distinct(log, user_id)

left_join(users, log, by="user_id")
inner_join(users, log, by="user_id")
full_join(users, log, by="user_id")
semi_join(users, log, by="user_id")
anti_join(users, log, by="user_id")

#log %>% left_join(users, c("user_id" = "id")) %>% left_join(items, c("item_id" = "id"))
log %>% left_join(users, c("user_id"))


# 예시 2
df1 <- data.frame(ID = c(1, 2, 3, 4, 5),
                  w = c('a', 'b', 'c', 'd', 'e'),
                  x = c(1, 1, 0, 0, 1),
                  y=rnorm(5),
                  z=letters[1:5])

df2 <- data.frame(ID = c(1, 7, 3, 6, 8),
                  a = c('z', 'b', 'k', 'd', 'l'),
                  b = c(1, 2, 3, 0, 4),
                  c =rnorm(5),
                  d =letters[2:6]) 

left_join(df1, df2, by = "ID")
right_join(df1, df2, by = "ID")

  # inner join
merge(df1, df2, by = "ID")
merge(df1, df2, by.x ="ID", by.y = "ID") # df1의 ID와 df2의 id 모두 일치되는 것만
  # left_join
merge(df1, df2, by ="ID", all.x = TRUE) # id 일치로 찾되 df1은 모두 반영
  # right_join
merge(df1, df2, by ="ID", all.y = TRUE) # id 일치로 찾되 df2은 모두 반영
  # full_join
merge(df1, df2, by ="ID", all = TRUE) # id 일치로 찾되 df1, df2 모두 반영
  # cross_join
merge(df1, df2, by = NULL) # 일치 없이 있는 데이터 모두 반영


