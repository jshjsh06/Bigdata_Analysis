# 주사위를 네번 던져서 나오는 숫자의 합X에 대한 확률
library(prob)
  # 한번 돌렸을 때
s <- rolldie(1) # 6
str(s)
table(s)
X.freq <- table(s)
X.freq
length(X.freq)
X.freq <- X.freq / length(X.freq)
X.freq
plot(X.freq, type="h")

  # 4번 돌렸을 때
s2 <- rolldie(4)
X2 <- apply(s2, 1, sum)
X2
X2.freq <- table(X2)
X2.freq
length(X2.freq)
X2.freq <- X2.freq / length(X2.freq)
plot(X2.freq, type="h")

  # apply에 대한 이해 
temp <- matrix(c(1,2,3,4,7,9), nrow = 2)
temp
apply(temp, 1, sum)

#########################################################################################################

# 이산확률변수 -> 이산확률분포
# 50개의 제품 중 8개가 불량품이 있는 상자로부터 10개의 제품을 랜덤 샘플링
# 발견되는 불량 개수 X의 확률분포
npop <- 50
nsampl <- 10
ndef <- 8
choose(npop, nsampl) # npop개 원소로 이루어진 집합에서 추출 가능한 nsample개의 
#원소로 이루어진 부분집합의 수를 계산하는 함수
# 조합임
d <- choose(npop,nsampl) # 50 C 10 => 50개 중 10개를 뽑는 경우의 수
freq <- choose(ndef, 0:nsampl) * # 8 C 0, 8 C 1, 8 C 2, ... , 8 C 10
  choose(npop-ndef, nsampl - (0:nsampl)) # 42 C 10, 42 C 9, 42 C 8, ..., 42 C 0
  # 즉, 불량품 8개중에 1개 뽑고 * 정상품 42개중에 10개 뽑는 수, 불량품 8개 중 1개 뽑고 * 정상품 42개 중 9개 뽑는 수 ... 
fx <- freq / d
plot(0:10, fx, type="h")

#########################################################################################################

# 8명의 신사가 각각의 모자을 들고 모였다.
# 갑자기 정전이 되어 아무 모자이나 들고 자기 집으롣 돌아갔다.
# 자기 자신의 모자를 들고 간 신사의 수를 x라할 때, 확률변수 x의 확률은
# 8모자, 8신사
hats <- LETTERS[1:8]
hats
urnsamples(1:10, size = 1) # 참고
urnsamples(1:10, size = 2) # 참
s <- urnsamples(hats, size = 8, ordered = T) # 8개의 모자가 8개의 신사에게 가져가질 수 있는 모든 경우의 수
# 즉 8! 이다.
8*7*6*5*4*3*2*1

tail(s)
dim(s)
str(s)
rowN <- nrow(s) # 행의 총 갯수이자 8!의 개수
rowN
checkFunc <- function(x) {
  sum(x == hats) # s의 첫번째 행이 hats와 같은지. hats는 A, B, C,..., H 이다.
  # 만약에 같다면 그 같은 수를 합해서 반환한다. True, true, false..false..fasel.. 이면 리턴값은 2
}
x <- apply(s, 1, checkFunc)
head(x,5)
s[1,] == hats
s[2,] == hats
s[3,] == hats
s[4,] == hats
s[5,] == hats

x.freq <- table(x)
x.freq
x.prob <- round(x.freq/rowN, 6)
x.prob
sum(x.prob)
plot(x.prob, type="h")


#########################################################################################################

# 주사위 세개를 던지는 시행에서 
# 짝수의 개수?
library(prob)
S <- rolldie(3)
rowN <- nrow(S)
S
rowN
checkFunc <- function(x) sum(1-x%%2)
Y <- apply(S, 1, checkFunc)
table(Y)

#########################################################################################################


# 주사위를 두번 던지는 시행에서 눈의 최대치를 X라고 하고, 눈의 최소치를 Y라고 할 때
# Z = XY의 기댓값을 구하시오
s1 <- rolldie(2)
str(s1)
head(s1)
x1 <- apply(s1, 1, max)
x1
table(x1)
x2 <- apply(s1, 1, min)
x2
table(x2)

x1
x2
table(x1, x2) # 이게 좀 헷갈리는데 x1과 x2를 같이 보면은 (x1= 1, x2 = 1) 인 갯수는 1개이고,
# (x1 = 2, x2 = 1)인 갯수는 2개인 것이다. 반면 (x1 = 1이고, x2 = 6)인 경우는 하나도 없음을 찾을 수 있다.
# 아무튼 이렇게하면.. XY값. 즉 곱연산이 됨.
# x1의 최대치와 x2의 최소치가 곱연산을 하면 "동시에 그 사건이 이루어지는 것"이 됨.
# table(x1, x2)를 보면 동시에 사건이 이루어지는 경우를 표로 잘 나와있는 것임
temp <- table(x1, x2) / nrow(s1)
sum(table(x1, x2) / nrow(s1))
temp
XY <- (1:6 %o% 1:6)
XY
(as.vector(XY) %*% as.vector(temp))[1,1]

# table(a,b)의 이해를 위한 참고
a <- c(1:5)
b <- c(3:7)
a
b
table(a, b)

#########################################################################################################
# 동전의 앞 뒷면 확률
# coins
s3 <- tosscoin(4)
s3
nrow(s3)
# 앞면 뒷면 갯수를 세는 함수
countH <- function(x) sum(x=="H")
countF <- function(x) sum(x=="T")
# 확률 변수 생성
x3 <- apply(s3, 1, countH)
y3 <- apply(s3, 1, countF)
v3 <- y3 - x3 # 별 의미가 없음. 그냥 두 값에 대한 차이값을 의미하는 것임. 0이 되면 앞 뒷면이 같게 나왔다는 것임.
              # 그냥 이런 변수도 있다는 것을 생각하면 됨.
w3 <- abs(v3)
x3
y3
v3
w3
par(mfrow = c(2,3)) # 여러 그림을 한 그림에 넣을 수 있는 행열을 생성하는 것임
plot(x3, y3, type = "l") # H, T
plot(x3, y3, type = "l") ; abline(lm(y3~x3), col=2) # abline은 직선을 긋는 것
plot(x3, v3, type = "l") # H, V

#########################################################################################################
# 주사위 4개 던졌을 때 평균, 중앙값을 구하시오
# mean, median 함수
# list <- 합, 평균, 최대치, 최소치(4개항목)
# rolldie(4)
library(prob)
S5 <- rolldie(4)
N5 <- nrow(S5)
X5_sum <- apply(S5, 1, sum)
#round(table(X5_sum)/N5,6)
X5_mean <- apply(S5, 1, mean)
#round(table(X5_mean)/N5,6)
X5_max <- apply(S5, 1, max)
X5_min <- apply(S5, 1, min)
X5_list <- list()
X5_list[[1]] <- X5_sum
X5_list[[2]] <- X5_mean
X5_list[[3]] <- X5_max
X5_list[[4]] <- X5_min
X5_list

