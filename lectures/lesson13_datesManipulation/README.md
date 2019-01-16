lesson 10: Manipulating Dates
================

``` r
library(tidyverse)
```

## Introduction

To have the right class associated to date/time data is crucial to
manipulate them effectively. Dates often come as strings, but R will not
make any assumption about your intention to create a date until you
specify so. For instance, suppose we want to calculate the distance
between two dates:

``` r
myDate <- c("2018-03-19", "2018-03-20")
diff(myDate)   #does not work:
## Error in r[i1] - r[-length(r):-(length(r) - lag + 1L)]: non-numeric argument to binary operator
class(myDate)  #myDate is a character vector
## [1] "character"
```

In base R, you can use the function `as.Date` to coerce `myDate` to an
object of class `Date`:

``` r
myDate <- as.Date(myDate)
str(myDate)
##  Date[1:2], format: "2018-03-19" "2018-03-20"
diff(myDate)
## Time difference of 1 days
```

Dates R essentially numbers indicating the days from a certain origin
(default to `1970-01-01`):

``` r
typeof(myDate) 
## [1] "double"
as.double(as.Date('1970-01-01'))
## [1] 0
```

However, `as.Data` is not very flexible in recognizing dates when their
format differs from `yyyy-mm-dd`. For instance:

``` r
as.Date('1918-11-04')
## [1] "1918-11-04"
as.Date('1918/11/04')
## [1] "1918-11-04"
as.Date('19181104')
## Error in charToDate(x): character string is not in a standard unambiguous format
```

You can still specify the formatting rules in `as.Date`to parse the
character string. Check `?strptime` for the conversion specifications:

``` r
#processing is via strptime
as.Date('19181104', format = '%Y%m%d')
## [1] "1918-11-04"
```

Still, slightly different formats can make the conversion from character
to dates challenging:

``` r
as.Date(c('1918-11-04', '1918/11/04'), format = '%Y-%m-%d')
## [1] "1918-11-04" NA
```

## Manipulating date/time with lubridate

The package `lubridate` can “guess” better than base R function dates
formatting (see the book-chapter [Dates and
Times](http://r4ds.had.co.nz/dates-and-times.html)).

``` r
library(lubridate)
today()
## [1] "2018-10-09"
now()
## [1] "2018-10-09 14:54:43 CDT"
wday(now(), label = T, abbr = F)
## [1] Tuesday
## 7 Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < ... < Saturday
```

Sorting the specifications for y=year, m=month, d=day, you can loosely
specify a date format that is more tolerant towards little differences
in the string character. Note how that makes easier to handle different
formatting within the same vector (including incomplete
dates):

``` r
someDates <-  ymd(c('1918-11-04', '1918/11/04', '19181104', '191811'), truncated = 1)
dym('191811')
## [1] "2018-11-19"
```

Not how class and type are the same as using `as.Date` in base R:

``` r
class(someDates)
## [1] "Date"
typeof(someDates)
## [1] "double"
```

After coercing to date, to extract single components from each date
object:

``` r
day(ymd(myDate))
## [1] 19 20
week(ymd(myDate)) 
## [1] 12 12
month(ymd(myDate)) 
## [1] 3 3
year(ymd(myDate)) 
## [1] 2018 2018
```

If you need to add time to a date, sort the letters h = hours, m =
minutes, s = seconds to create date-time specifications:

``` r
datime <- ymd_hms(c('2014-01-31 23:12:31', '2014-01-31 11:12:31 pm'))
hour(datime)
## [1] 23 23
minute(datime)
## [1] 12 12
second(datime)
## [1] 31 31
```

## Mid-term throwback exercise

1.  Calculate the day of the week with the most crimes

<!-- end list -->

``` r
load(here::here('data', 'dataset.RData'))
dt <- left_join(dt, lkt)
```

1.  Use `case_when` to refactor `offensetime_discrete` using the
    following labels:

<!-- end list -->

``` 
   - >=10.00 pm but <= 5.00 am ----> night
   - >5.00 am but <= 10.30 am ----> morning
   - >10.30 am but < 2.00 pm -----> day
   - >=2.00 am but < 5.30 pm -----> afternoon
   - anything else ---> evening
```

1.  Plot the density of crimes facetting by year. Make sure each facet
    goes from Jan to Dec of that year only, and the x-axis shows one
    label for each month

<!-- end list -->

``` r
#substitute ... with the appropriate code
ggplot(...) +
  geom_density(aes(x = ...)) +
  facet_wrap(~ ..., scales = ... , ncol = 1) +
  scale_x_date(name = ... , date_breaks = ..., date_labels = ...) #?strptime() for the list of specifications
## Error in eval(expr, envir, enclos): '...' used in an incorrect context
```

## Exercise

Using a dataset of terrorism casualties in Europe, plot a line chart of
victims by year in France and Italy. Transform years in dates so that
you can format x-axis labels as two digits numbers (e.g., ’80, ’90) (use
\`date\_labels).

``` r
dt <- read_csv(file = 'https://raw.githubusercontent.com/fivethirtyeight/data/master/terrorism/eu_terrorism_fatalities_by_country.csv')
```
