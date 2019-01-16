Data visualization
================

Data Visualization
==================

Base R offers comes with native plotting functions for data visualization, such as `plot()`, `barplot()`, `pie()`, etc. but we will not cover them. Instead, we focus on another graphic library called [ggplot2](http://ggplot2.org/), which is part of the tidyverse package suite. Despite plotting functions in base R came chronologically before ggplot2 (and are still widely used), [ggplot2](http://ggplot2.org/) ([cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)) is probably the most popular package for dataviz. Its rapid success is due both to the attractive design of its plots and to a more consistent syntax. Also, there are a number of [extensions](http://www.ggplot2-exts.org/) developed within the ggplot2 framework that make easier to add themes or create more sophisticated charts.

ggplot2
=======

References
----------

Check [Chapter 3](http://r4ds.had.co.nz/data-visualisation.html) on dataviz in ggplot2.

Installing ggplot2
------------------

Because you already installed the tidyverse, calling `library(tidyverse)` loads `ggplot2` as well. From now on, we will be using functions that are not part of base R, thus make sure you load `library(tidyverse)` every time you start a new R session. Also, make sure you have a `library(tidyverse)` call before you use any ggplot2 function in your RMarkdown (the knitting runs in a new environment). If you get error messages saying that R `could not find function ...`, you probably have not loaded the package correctly.

``` r
library(tidyverse)
if (!require(here)) {install.packages('here')}
load(here::here('data', 'dataset.RData'))
```

Using ggplot2
-------------

To look meaningful, each ggplot2 statement requires at least a dataset, a set of aesthetics that the variables are mapped to, and the geometrical shape to visualize the aesthetics into.

For instance, to plot a chart of million of twitter users per year:

``` r
ggplot() +
  geom_col(data =  twitter_users, aes(x = Year, y = millions)) +
  ggtitle('A plot of twitter users')
```

<img src="README_files/figure-markdown_github/unnamed-chunk-2-1.png" alt="Millions of Twitter users" width="80%" />
<p class="caption">
Millions of Twitter users
</p>

ggplot2 builds on an underlying grammar, which entails seven fundamental elements:

| Element     | Visual attribute                      |
|-------------|---------------------------------------|
| data        | dataset with the variables of interst |
| aesthetics  | x-axis, y-axis, color, fill, alpha    |
| geometries  | bars, dots, lines                     |
| facets      | coloumns, rows                        |
| statistics  | bins, smooth, count                   |
| coordinates | polar, cartesian                      |
| themes      | non-data ink                          |

The [concept of *mapping*](http://r4ds.had.co.nz/data-visualisation.html#aesthetic-mappings) is fundamental when learning ggplot2; although it might not be very intuitive at first, once you grasp it mapping several variables to the same plot becomes quite straightforward. *To map* means to assign a variable to an *aesthetic*, namely to a visual property such' height, fill color, border color, etc. In the previous example, we mapped only to x-y coordinates; but you can call `?geom_col()` and scroll down in the help pane to the paragraph *Aesthetics* for a complete list of the attributes available. For instance, try to map Year to the fill too:

``` r
ggplot() +
  geom_col(data =  twitter_users, aes(x = Year, y = millions, ------ ))
```

From `freqCasualties`, plot a barchart of the count of casualties by class and gender (each bar refers to a class)

``` r
#what do we want to map to x and y? how do we map the third variable?
```

Some times, you want to manually **set** a value for a certain aesthetic, rather than **mapping** a variable to it - in that case the aesthetic is not really interpretable, since it constitutes a non-data ink element. For instance, note the difference between the charts below:

``` r
ggplot() +
  geom_line(data =  twitter_users, aes(x = Year, y = millions, color ='blue' )) 
```

![](README_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
ggplot() +
geom_line(data =  twitter_users, aes(x = Year, y = millions), color ='blue') 
```

![](README_files/figure-markdown_github/unnamed-chunk-5-2.png)

To change color, you can use either [color names](http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf) (e.g., 'red'), hex codes (e.g., `#ff0000`) or rgb (e.g. `rgb(255, 0, 0)`).

So far, we specified aesthetics and datasets inside a specific geom. However, if we want to pass the same dataset and aesthetics to multiple `geom_`, we can pass them once to the `ggplot()` function and let the `geom_` inheriting them from the `ggplot()` statement.

``` r
#Use the dataset twitter_users
#Use the set of aesthetics: aes(x = Year, y = millions )
#combine together geom_line() and geom_point() 
```

``` r
#use twitter_users to plot a linechart of twitter users over time
#use sn_users to overlay a linechart of FB users over time
```

### Exercise:

-   use `beerDt` to create a linechart of beer consumption (in gallons of ethanol) in US from 1903.
-   add a layer of points using `geom_point`

Suppose that you now want to flag (e.g., use a different color) the observation for consumption in your birthyear. We can do it in two steps:

    1. Create a new variable called 'myBirthYear' that takes value 'My birthyear' for your birth year, and NA for everything else. You could use `ifelse()` or conditional indexing/assignment
    2. Map `myBirthYear` to the fill of `geom_point` to flag your birth year
    3. Use ggtitle to add a title to the chart
