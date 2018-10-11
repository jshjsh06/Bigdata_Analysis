# 상관분석
# Correlation Analysis
install.packages("corrplot")
install.packages("RColorBrewer")
library(corrplot)
library(RColorBrewer)
  # corrplot과 RColorBrewer를 사용한 상관관계 보기
data3 <- cor(mtcars) # cor은 상관관계를 보여주는 함
data3
corrplot(data3, type="upper", order="hclust", col=brewer.pal(n=8, name="RdYlBu"))

  # 라이브러리를 사용한 상관관계 보기
source("rquery_cormat.r") # packages를 사용하지 않고, 라이브러리를 직접 다운받아서, 불러와서 사용해보자.
data4 <- mtcars[, c(1,3,4,5,6,7)]
require("corrplot") # 이 라이브러리를 사용하겠다고 명시해주는 것
rquery.cormat(data4)


# 분산 분석 - 일원분산 분
# 두개 이상의 그룹의 평균을 비교
# ANOVA 테스트 가설
  ## Null Hypthesis => 다른 그룹의 평균과 같음.
  ## Alternative hypothesis => 하나 이상의 표본이 다른 평균과 동일하지 않음
PlantGrowth
str(PlantGrowth)
names(PlantGrowth)
levels(PlantGrowth$group)
data4 <- PlantGrowth
library(magrittr)
library(dplyr)
data4 %>% group_by(group) %>% summarize(count = n(), mean = mean(weight, na.rm=T), sd = sd(weight, na.rm = T))

library(ggpubr)
ggboxplot(data4, x="group", y="weight", color="group", palette = c("#00AFBB", "#E7B800", "#FC4E07"))
ggline(data4, x="group", y="weight", color="group", palette = c("#00AFBB", "#E7B800", "#FC4E07"))
ggline(data4, x="group", y="weight", add = c("mean_se", "jitter"))
boxplot(weight ~ group, data = data4)

data5 <- aov(weight ~ group, data = data4)
data5
summary.aov(data5) # * 이 많을 수록 연관이 많다는 것이다.
