#데이터합치기
# cbind,rbind
# 사용자
# userid, username, location
# user1, 홍길동, 서울
# user2, 이순신, 서울
# user3, 강감찬, 용산

# 로그데이터
# timestamp, userid, logType,etc
# 2018000000, user1, pc
# 2018000001, user2, pc
# 2018000002, user1, mobile
# 2018000003, user1, pc

library(ggplot2)

g <- ggplot(data=iris, aes(x=iris$Sepal.Length, color=iris$Species)) 
g2 <- g + geom_histogram(fill="white", bins = 10)
g2

g3 <- ggplot(data=iris, aes(x=iris$Sepal.Length, color=iris$Species))
g4 <- g3 + geom_density() 
g4

g5 <- ggplot(data=mpg, aes(x=class))
g6 <- g5 + geom_bar() 
g6

g5 <- ggplot(data=mpg, aes(x=class))
g6 <- g5 + geom_bar() + coord_flip() 
g6

g7 <- ggplot(data=mpg, aes(x=class))
g8 <- g7 + geom_bar()
#g8 + xlab("x axis") + ylab("y axis") + ggtitle("Main")
#xlab,ylab,ggtile
g8 + labs(title="title",x="x axis", y="y axis")
g8 + geom_text(stat="count", aes(label=..count..), vjust=-0.25)


'''
* dplyr패키지를 사용하여 처리하시오.(example_population_f.csv)
1. 충청도만 데이터를 구성하고(충청북도, 충청남도), 시별 그래프를 출력하시오.(x=City, y=Population), (ggplot)
2. 위의 그래프를 오름차순으로 정렬하시오.(reorder함수), (ggplot)
2. 남자비율이 높고 1인가구가 많은 도시를 필터링하고 그래프로 출력하시오. (ggplot)

'''
#문제1
library(magrittr)
library(dplyr)
df <- read.csv("example_population_f.csv")
View(df)
df2 <- df %>% filter(Provinces == "충청북도" | Provinces == "충청남도")
df2
ggplot(data=df2, aes(x=City, y=Population)) + geom_bar(stat = 'identity') # ★★

#문제2
ggplot(data=df2, aes(x=reorder(City, -Population), y=Population)) + geom_bar(stat = 'identity') # ★★


df3 <- df %>% arrange(desc(SexRatio), PersInHou) %>% head(1)
df3
ggplot(data=df3, aes(x=PersInHou, y=SexRatio)) + geom_bar()



'''
1. 경기도 데이터중 남녀 비율을 확인하고, 그래프로 출력하시오.(ggplot)
2. 서울시 데이터중 남녀 비율을 확인하고, 그래프로 출력하시오.(ggplot) 
'''
df3 <- read.csv("example_population_f.csv")
colnames(df3)
df3 <- df3[,-1]
df3 <- mutate(df3, checkTF = ifelse(SexRatio < 1, "여자비율높음", ifelse(SexRatio > 1, "남자비율높음", "남여비율같음")))
df3$checkTF <- factor(df3$checkTF)
str(df3)
#ordered를 통해 각 값이 크기비교가 가능해진다.
df3$checkTF <- ordered(df3$checkTF, c("여자비율높음", "남자비율높음", "남여비율같음"))
df3$checkTF
df3

df4 <- df3 %>% filter(Provinces == "경기도")
ggplot(df4, aes(x=City, y=SexRatio)) + geom_bar(stat = 'identity')

df5 <- df3 %>% filter(Provinces == "서울특별시")


'''
* dplyr 사용하여 처리하시오.(example_population_f.csv)
1. 도별 남녀 비율을 구하고, 그래프로 출력하시오.(ggplot)
'''
# 단순 생각 내 답
df6 <- df %>% group_by(Provinces) %>% summarize(avgSex = mean(SexRatio))
df6
ggplot(df6, aes(x=Provinces, y=avgSex)) + geom_bar(stat = "identity", fill = "skyblue")

                                                
# 강사님 답 melt
library(dplyr)
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
library(reshape2)

df <- read.csv("example_population_f.csv")
group <- group_by(df, Provinces)
group

df2 <- summarise(group, SumPopulation=sum(Population), Male=sum(Male),Female=sum(Female))
df2

# provinces와 sumpopulation을 기준으로 male, female를 나누는 것임
'''
df2는
                male female
provinces, 100   40   50

df3는

provinces, 100 male 40
provinces, 100 female 50

이런식으로 기준에 대해서 좀 더 상세하게 볼 수 있도록 열을 행으로 전환했다고 생각하면 됨
'''
df3 <- melt(df2, id.vars = c("Provinces", "SumPopulation")) 
df3

colnames(df3)[3] <- "Sex"
df3
colnames(df3)[4] <- "Population"
df3

df4 <- mutate(df3, Ratio = Population/SumPopulation)
df4
df4$Ratio <- round(df4$Ratio, 3)
df4

g <- ggplot(df4, aes(x=Provinces, y=Ratio, fill=Sex)) + geom_bar(stat="identity") + coord_cartesian(ylim = c(0.45, 0.55)) + theme_wsj()
g
g2 <- geom_text(aes(y=Ratio, label=Ratio))
g2
g + g2

df4 <- mutate(df4, Position=ifelse(Sex=="Male", 0.475, 0.525))
df4

g3 <- ggplot(df4, aes(x=Provinces, y=Ratio, fill=Sex)) + geom_bar(stat="identity") + coord_cartesian(ylim = c(0.45, 0.55)) + theme_wsj()
g3
g4 <- geom_text(aes(y=Ratio, label=Ratio))
g4
g3 + g4
