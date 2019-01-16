devtools::install_github("r-lib/rlang")
devtools::install_github("r-lib/lobstr")
library(rlang)
library(lobstr)
y <- x * 10
z <- expr(y <- x * 10) #captures the intent of the code
x <- 4
eval(z)
y

lobstr::ast(f(x, "y", 1))
lobstr::ast(!!z)
View(z)

`>`(1, 2)
ast(`<-`(j, 1))
ast(j <- 1)
