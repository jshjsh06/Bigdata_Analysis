'''
www.koreabaseball.com
=> example_kbo2015_player.csv

1. 2015 KBO 야구 데이터 분석하기
- 홈런과 다른 변수간의 상관계수를 살펴보시오.
- 회귀모델을 구하고 p-value값을 확인하시오.
- 잔차(residuals)관련 그래프를 출력하시오. 
residual = 모델로부터 구한 예측 값과 실제 값의 차이를 나타내는 값
'''
df <- read.csv("example_kbo2015_player.csv", stringsAsFactors = F, na = "-")
df
str(df)
df$AO <- as.numeric(df$AO)
df$GO.AO <- as.numeric(df$GO.AO)
df$BB.K <- as.numeric(df$BB.K)
df$P.PA <- as.numeric(df$P.PA)
df$ISOP <- as.numeric(df$ISOP)
# 홈런과 다른 변수간의 상관계수를 확인(정렬)
Cors <- cor(df$HR, df[,5:length(df)], use = "pairwise")
Cors
Cors <- Cors[, order(Cors)]
Cors

# 홈런과 뜬공 변수에서 값이 0인 관측치
df$HR[df$HR == 0] <- NA # 안해도 상관이 없음. 그러나 0이 좀 의미가 없다고 생각해서 NA로 바꿈.

# 회귀모델을 구함
lm_data <- lm(HR ~ AO, data=df)
lm_data
# y = -0.5244 + 0.1541x
summary(lm_data)

par(mfrow=c(2,2))
plot(lm_data)


'''

1. diamonds데이터로 캐럿에 따른 가격을 예측하시오.
- 회귀 모델을 구하고, 검증하시오.
- 10캐럿, 20캐럿값은?

'''
diamonds

d <- lm(diamonds$price ~ diamonds$carat, data=diamonds) # diamonds 데이터로 회귀모델을 구한다.
summary(d) # summary로 요약된 자료를 살펴보자.

d2 <- data.frame(carat=c(10,20)) # 10캐럿괴 20캐럿을 추출하여 데이터프레임으로 만들자.
predict(d, newdata = d2) # 회귀모델 d에 10, 20캐럿 자료를 newdata로 적용시켜보자.




