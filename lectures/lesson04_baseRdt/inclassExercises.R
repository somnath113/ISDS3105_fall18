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

#' extract the first two elements of column "IPhone6s"

#' subset iphoneSales to a dataframe with only time, iPhone5C, IPhoneX

#' keep only the rows where the sales for iPhoneSE are higher than 7 AND are not NA (AND = &, OR = |, NOT = !)

#' Use %in% to keep only the rows for c("Sep 2014", "Sep 2015", "Sep 2018")

#' calculate the mean() of the IPhone7 sold 

#' use inline code to print the mean of the iphone sold in Jun 2018
