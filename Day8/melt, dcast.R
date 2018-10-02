# melt
library(reshape2)
df <- read.csv("example_data5.csv")
df
melt(df, id.vars = c("id", "time"))
melt(df, id.vars = c("id"))

# dcast(data, formula(기준), value)
df2 <- read.csv("example_data3.csv")
df2
dcast(df2, Year+SemiYear ~ Product, value.var = "Income")
  # year과 semiyear을 기준으로(키로 설정하여) Product 내용을 상세하게 보여준다. 상세하게 보여줄 값은 Income이 된다.
dcast(df2, Year+SemiYear ~ Income, value.var = "Product")

dcast(df2, Year ~ Product, value.var = "Income")
dcast(df2, Year ~ Income, value.var = "Product")

dcast(df2, Year~Product, fun.aggregate = sum, value.var = "Income")


# melt 예제
df3 <- read.csv("example_data4.csv")
df3

melt(df3, id.vars = c("ID"), na.rm = TRUE)

x <-colnames(df3[-1])
x
melt(df3, id.vars = c("ID"),
     measure.vars = x,
     variable.name = "Species",
     value.name =  "Sepal.Length",
     na.rm = TRUE
)


y <-colnames(df3[-1:-2])
y
melt(df3, id.vars = c("ID"),
     measure.vars = y,
     variable.name = "Species",
     value.name =  "Sepal.Length",
     na.rm = TRUE
     )
