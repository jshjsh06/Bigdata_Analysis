#복습

# 벡터
a <- c("hi", "bye", "jay")
a
a[1]
a[1:2]
a[c(1,2)]
a[c(1:2)]
a[-1]
a[-2]
a[-1:-2]
a["hi"]
a[c("hi")]

#리스트
b <- list(no=100, name="jay", empData= c(100, 200))
b$no
b$name
b$empData
class(b$empData)

c <- list(a=list(val = c(1,2,3)),b=list(val=c(1,2,3,4)))
c
c$a
c$a$val
c[[1]]
c[[1]][1]
c[[1]][[1]]

#매트릭
d <-matrix(c(1:9), nrow=3, byrow=T,dimnames = list(c('item1','item2','item3'),c("sort1","sort2","sort3")))
d
d[1]
d[1,1]
d[2,1]
d[,1]
d[1,]
d[1:2, 2:3]
d[-1,]
d[c(1,3),]
d[c(1,3), c(2,3)]
d["item1",] # "," 위치 확인할 것
d[,"sort2"] # "," 위치 확인할 것
dim(d)


# 행렬
array(1:12, dim =c(3,4))
array(1:12, dim =c(3,4,2))

# Data Frame
e <-data.frame(c(1,2,3,4), c(2,3,4,5))
e
f <-data.frame(col1=c(1,2,3,4), col2=c(2,3,4,5))
f
g <-data.frame(empNo=c('10', '20', '30'), empName=c('이순신','홍길동','권율'), empAddress=c('서울','뉴욕','런던'))
g
str(g)
g$empNo
g$empName
g$empAddress
g$empNo[1]
g[,1]
g[1,]
g[c(1,2),c(2,3)]
g[,c('empName','empAddress')]
colnames(g)<-c("NO","NA", "ADD") # 이름 바꾸
rownames(g)<-c("a","b","c")
g

names(b) <- c("hi","name", "empData")
b
names(b)

# List or Factor in Data Frame 
h<-data.frame(list(c(1:3),c(2:4),c(3:5)))
h
colnames(h)<-c('col1','col2','col3')
h
h$col4<-c(4:6)
h
i <- data.frame(factor(c('m','f','m'), levels=c('m','f')))
i
str(i)
h[,-c("col4")]
