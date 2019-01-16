Iterations over multiple arguments
================

``` r
library(tidyverse)
library(fivethirtyeight)
```

The example below shows how to iterate a call to ggplot() over multiple
arguments. In particular, we want to iterate over different datasets and
different names to create multiple charts of a subset of data. We will
use the same logic when knitting parametrized reports in RMarkdown, so
understanding how `map()` works can really help you to scale up things.

``` r
#Consider the dataset
bad_driversSouth <- bad_drivers %>% 
                      mutate(
                        isSouth = case_when(
                          state %in% c('Louisiana', 'Alabama', 'Mississippi', 'Georgia', 'South Carolina') ~ 'South',
                          T ~ 'Other'),
                        state = tolower(state))

bad_driversNested <- bad_driversSouth %>% group_by(isSouth) %>% nest()
mapData <- as_tibble(map_data("state"))
## 
## Attaching package: 'maps'
## The following object is masked from 'package:purrr':
## 
##     map

bad_driversNested <- bad_driversNested %>% mutate(stateShape = purrr::map(.x = data, ~ inner_join(.x, mapData, by = c('state' = 'region'))))
```

``` r
#function to draw the chart
drawMap <- function(data, title) {
                   ggplot(data = data) +
                      geom_polygon(aes(x = long, y = lat, group = group, fill = insurance_premiums), color = "white") + 
                      coord_fixed(1.3) +
                      labs(title = paste('Insurance Preiums for ', title)) +
    scale_fill_gradient(labels = scales::dollar_format())
}

bad_driversNested <- bad_driversNested %>% 
  mutate(stateMap = pmap(list(data = .$stateShape, title = .$isSouth), .f = drawMap))
# OR: mutate(stateMap = map2(.x = .$stateShape, .y = .$isSouth, drawMap)) 
```

## Invoking different functions

With `map` can iterate one function over multiple elements. For
iterating multiple function over one parameters We want to plot the
correlation between insurance\_premiums and losses

``` r
#calculate variance, correlation, covariance
invoke_map(list(var, cor, cov), list(list(x = bad_drivers$insurance_premiums, y = bad_drivers$perc_alcohol)))
## [[1]]
## [1] -15.96835
## 
## [[2]]
## [1] -0.01745071
## 
## [[3]]
## [1] -15.96835

#calculate mean and median for one variable
invoke_map(list(avg = mean, IIQ = median), x = bad_drivers$insurance_premiums)
## $avg
## [1] 886.9576
## 
## $IIQ
## [1] 858.97
invoke_map_df(list(avg = mean, IIQ = median), x = bad_drivers$insurance_premiums)
## # A tibble: 1 x 2
##     avg   IIQ
##   <dbl> <dbl>
## 1  887.  859.
```

Although for tasks like the above is easier to use variations of the
dplyr verbs we already familiarized
with:

``` r
bad_drivers %>% summarise(mean = mean(num_drivers), median = median(num_drivers))
## # A tibble: 1 x 2
##    mean median
##   <dbl>  <dbl>
## 1  15.8   15.6
bad_drivers %>% summarise_at(vars(num_drivers), .funs = funs(mean, median))
## # A tibble: 1 x 2
##    mean median
##   <dbl>  <dbl>
## 1  15.8   15.6

bad_drivers %>% mutate_if(is.integer, .funs = funs(paste0(., '%')))
## # A tibble: 51 x 8
##    state num_drivers perc_speeding perc_alcohol perc_not_distra…
##    <chr>       <dbl> <chr>         <chr>        <chr>           
##  1 Alab…        18.8 39%           30%          96%             
##  2 Alas…        18.1 41%           25%          90%             
##  3 Ariz…        18.6 35%           28%          84%             
##  4 Arka…        22.4 18%           26%          94%             
##  5 Cali…        12   35%           28%          91%             
##  6 Colo…        13.6 37%           28%          79%             
##  7 Conn…        10.8 46%           36%          87%             
##  8 Dela…        16.2 38%           30%          87%             
##  9 Dist…         5.9 34%           27%          100%            
## 10 Flor…        17.9 21%           29%          92%             
## # ... with 41 more rows, and 3 more variables: perc_no_previous <chr>,
## #   insurance_premiums <dbl>, losses <dbl>
bad_drivers %>% mutate_at(vars(starts_with('perc')), .funs = funs(paste0(., '%')))
## # A tibble: 51 x 8
##    state num_drivers perc_speeding perc_alcohol perc_not_distra…
##    <chr>       <dbl> <chr>         <chr>        <chr>           
##  1 Alab…        18.8 39%           30%          96%             
##  2 Alas…        18.1 41%           25%          90%             
##  3 Ariz…        18.6 35%           28%          84%             
##  4 Arka…        22.4 18%           26%          94%             
##  5 Cali…        12   35%           28%          91%             
##  6 Colo…        13.6 37%           28%          79%             
##  7 Conn…        10.8 46%           36%          87%             
##  8 Dela…        16.2 38%           30%          87%             
##  9 Dist…         5.9 34%           27%          100%            
## 10 Flor…        17.9 21%           29%          92%             
## # ... with 41 more rows, and 3 more variables: perc_no_previous <chr>,
## #   insurance_premiums <dbl>, losses <dbl>
```

## Exercise

``` r
hotels <- read_csv(here::here('data','taipeiHotel', 'hotel.csv'))
## Parsed with column specification:
## cols(
##   hotel = col_character(),
##   location = col_character()
## )
performance <- read_csv(here::here('data','taipeiHotel', 'performance.csv'))
## Parsed with column specification:
## cols(
##   hotel = col_character(),
##   NoofRooms = col_integer(),
##   NoofRoomsOccupied = col_integer(),
##   OccupancyRate = col_double(),
##   AverageRoomRate = col_double(),
##   RoomRevenue = col_double(),
##   FBRevenue = col_double(),
##   RoomDep = col_integer(),
##   FBDep = col_integer(),
##   AdmDep = col_integer(),
##   OtherDep = col_integer(),
##   Month = col_date(format = ""),
##   location = col_character()
## )
## Warning in rbind(names(probs), probs_f): number of columns of result is not
## a multiple of vector length (arg 1)
## Warning: 8 parsing failures.
## row # A tibble: 5 x 5 col     row col        expected       actual file                              expected   <int> <chr>      <chr>          <chr>  <chr>                             actual 1  1352 NoofRooms… no trailing c… e3     '/Users/Dario/Desktop/LSU/ISDS31… file 2  1984 NoofRooms… no trailing c… e3     '/Users/Dario/Desktop/LSU/ISDS31… row 3  4001 NoofRooms… no trailing c… e4     '/Users/Dario/Desktop/LSU/ISDS31… col 4  4156 NoofRooms… no trailing c… e3     '/Users/Dario/Desktop/LSU/ISDS31… expected 5  4172 NoofRooms… no trailing c… e3     '/Users/Dario/Desktop/LSU/ISDS31…
## ... ................. ... .......................................................................... ........ .......................................................................... ...... .......................................................................... .... .......................................................................... ... .......................................................................... ... .......................................................................... ........ ..........................................................................
## See problems(...) for more details.
```

Create an ggplot function to draw a linechart of the `AverageRoomRate`
over time (`Month`) and save it into a folder ‘timeLines’. Use iteration
to create a separate chart of each hotel and save it. Make sure each
chart is titled and saved meaningfully.

``` r
#' HINTS:
#' start off simple: create a function that takes 1 dataset and a title/filename and plots/saves 1 plot for 1 hotel
#' check ?ggsave() to learn how to save ggplot files. Use `here()` if you need to specify a filepath. Ideally,
#' you want to combine hotel names with file extensions (e.g., png, jpeg) to create meaningful file names. Then, you 
#' want to save each file into ISDS3105_fall/lectures/lesson13_purrr_2/timeLines.
#' You could use `dir.create()` to create the `timeLines` directory - perhaps conditionally using `dir.exists()`
#' if the folder does not exists yet.
```
