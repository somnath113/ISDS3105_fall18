#' ---
#' title: "Lesson 4"
#' author: ""
#' output: github_document
#' ---
  
#' To create a data frame, use the function `data.frame`:
  
iphoneSales <- data.frame(
  time = c("Sep 2014", "Sep 2015", "Sep 2016", "Dec 2016", "Sep 2017", "Dec 2017", "Jun 2018"), 
  iPhone4S = c(9, NA, NA, NA, NA, NA, NA), 
  iPhone5C = c(15.5, 5, NA, NA, NA, NA, NA), 
  iPhone5S = c(30, 19, NA, NA, NA, NA, NA), 
  iPhoneSE = c(NA, NA, 9.5, 6, 11, 7, 8), 
  iPhone6 = c(33, 33, 5, NA, NA, NA, NA), 
  iPhone6Plus = c(12.5, 19, 7, NA, NA, NA, NA), 
  iPhone6S = c(NA, 16, 19, 11, 10, 6, 8), 
  iPhone6SPlus = c(NA, 8, 12.5, 10, 4.5, 2, 3), 
  iPhone7 = c(NA, NA, 31, 40, 28.5, 13, 16), 
  iPhone7Plus = c(NA, NA, 16, 32.1, 29.5, 11, 11), 
  iPhone8 = c(NA, NA, NA, NA, 6, 24, 13), 
  iPhone8Plus = c(NA, NA, NA, NA, 10.5, 17, 24), 
  iPhoneX = c(NA, NA, NA, NA, NA, 20.1, 17))

#source: https://www.statista.com/statistics/804398/us-iphone-sales-by-model/


#' Data frame
#' Note how "time" is a factor and not a character. 
#' Read about [creating factors](http://r4ds.had.co.nz/factors.html#creating-factors)
                                                                                 
#' Dataframes are a special case of a list, where each element is a vector of the 
#' same length but possibly different type. For instance:
str(iphoneSales)
class(iphoneSales)
typeof(iphoneSales)

#' Indexing dataframes
#' Indexing works similarly to vectors, but note the difference between _extracting_ and _selecting_:

#selecting
iphoneSales['iPhone4S']
iphoneSales[2]

#extracting
iphoneSales[['iPhone4S']]
iphoneSales[['iPhone4S']][1]
iphoneSales[,2]
iphoneSales$iPhone4S



#' `tidyverse` is best suited for using rectangular data structures called `tibbles`
#'  instead of data frames. To convert a `data.frame` into a `tibble`:
#' 
library(tidyverse)
as_tibble(iphoneSales)
class(as_tibble(iphoneSales))
typeof(as_tibble(iphoneSales))

#' Indexing tibbles
#' Because tibbles are also dataframes, indexing works as in `data.frame`. 

#' Why tibbles are so special
#' Tibbles allow to have column-list elements while dataframes allow only column-vectors:
                                                                                   
iphoneSales_tibble <- tibble(year = c(2017, 2018), 
                            iphones = list(
                            c(iphone7 = 13, iphone7plus = 11), 
                            c(iphone7 = 16, iphone7plus = 11))
                            )
iphoneSales_tibble
                                                                                 
iphoneSales_df <- data.frame(year = c(2017, 2018), 
                             iphones = list(list(iphone7 = 13, iphone7plus = 11), 
                                            list(iphone7 = 16, iphone7plus = 11)))
iphoneSales_df

#' Exercise: from iphoneSales_tibble extract the *vector* with the amounts of 
#' iphone7/7plus sold in 2017
                                                                                 

#' The pipe operator
#' The `%>%` (pipe) operator makes writing code using tidyverse a lot easier. 
#' The pipe enables to chain functions rather than nesting them. Piping makes 
#' easier for humans for read the code rather than nested code. For instance:
#' 
round(mean(c(1:10, NA), na.rm = T), 0)

#' You can "pipe" the above functions using `%>%` (shortcut: shift+cmd/ctrl+I), 
#' which passes the output that preceeds `%>%` to the first argument of the 
#' subsequent function (or alternatively anywhere you place a `.`). For instance:
                                                                                   
c(1:10, NA) %>% 
  mean(na.rm = T) %>% 
  round(0)
                                                                                   
#' We can rewrite the previous code using the pronoun `.`:

c(1:10, NA) %>% 
  mean(x = . , na.rm = T) %>% 
  round(x = ., digits = 0)

#' You need the `.` when you do not want to pass the code to the first argument:

c('hello', 'hi', 'bye', 'ciao') %>% 
gsub(pattern = 'ciao', replacement = 'hello', x = .)

#' Exercise: `$` is a function too. Can you pipe `iphoneSales` to `$` to extract the vector `iPhoneX`? 
#' Then, calculate the mean removing NAs

