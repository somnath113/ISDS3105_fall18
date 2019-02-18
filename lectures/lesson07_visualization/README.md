lesson 7: Data Visualization
================

\#Statistical transformation

Functions such as `geom_point` and `geom_col` use by default an
`identity` transformation, mapping the variables *as is*. Alternatively,
we can draw the same charts as a function of their statistical
transformation, adjusting the `geom` attribute:

``` r
ggplot() +
  stat_identity(aes(x = Year, y = millions), color = '#4169E1', data =  twitter_users, geom = 'point')

ggplot() +
  stat_identity(aes(x = Year, y = millions), fill = '#4169E1', data =  twitter_users, geom = 'col')
```

However, sometimes you need to transform values before plotting. For
instance, check the difference between `freqCasualties` (the one we used
with `geom_col`) and `selfiesCasualties`. How are the two datasets
different? What do you map to `y` for each of them?

``` r
#' We want to replicate the below chart using geom_bar instead 
#' of geom_col and the dataaset `selfiesCasualties`
ggplot(data = freqCasualties, aes(x = class, y = n, fill = gender)) + 
  geom_col()

#1. Replicate the above using selfiesCasualties and geom_bar() instead of geom_col. 

ggplot(data = selfiesCasualties) +
  geom_bar(...)


#2. Note that geom_col() is just a wrapper for geom_bar(stat = 'identity') 
#' Change the default stat to 'identity' and 
#' replicate the above chart with geom_bar and the dataset `freqCausalties`

ggplot(data = freqCausalties) +
  geom_bar(...)


#3. Read the documentation to learn how to plot proportions 
#' instead of counts with `geom_bar`

ggplot(data = selfiesCasualties) +
  geom_bar(aes( ... ), position = 'dodge')
```

To plot a barchart for `selfiesCasualties`, you need to map y to the
frequencies for all `class`/`gender` combinations. For a dataset where
**each row is an observation** (intead of a grouping level) use
`geom_*(stat = 'count')` to count rows. `geom_*(stat = 'count')` is
default in `geom_bar()`. You can think of `geom_col` as a special
instance of `geom_bar(... , stat='identity')`

## Exercise

For this exercise, we use a dataset of LSU graduates in May
2017.

``` r
#Load the csv from your local or github. If you use github you need the link to the "raw" file
dt <- read_csv('https://raw.githubusercontent.com/DarioBoh/ISDS3105_fall18/master/data/graduates_2017may.csv')
#1. Inspect it using glimpse()
glimpse(dt)

#2. Plot a barchart of the counts of graduates by college. Map the bar-fill to gender.
```

Read the documentation for `computed variables` in `?geom_bar`. Make
sure you understand the difference between shows `..propr..` and
`..count..`; plot the proportions (not the counts) of the students in
each college. You may need to adjust `aes(group = ...)`

``` r
#' 3.
```

Add to the code for question 3 `group = Sex` and switch between
`position = 'dodge'`/`position = 'fill'` to plot the distribution of
genders across schools. How do you interpret each bar?

``` r
#' 4
```

\#Faceting

Facets allow to replicate a plot splitting data by a categorical
variable. For instance, when you have a variable to control for, use
facets to create a grid of charts of your dataset, where each chart is a
level of the variable that you are faceting for. For instance, suppose
you want to understand whether a gender bias exists controlling for race
in each college:

``` r
ggplot(data =dt) +
 geom_bar(aes(x = College, fill = Sex)) +       #plot a count of students in each
  facet_wrap(~ Ethnicity, scales = 'free')
```

``` r
#repeat the previous but facetting by College and mapping ethnicity to x
# add title and caption: labs(title = "New plot title", subtitle = "A subtitle", caption = 'data from www.lsu.edu')
```

\#Changing scales

You can change the defaults of the aesthetics using `scale_attrName_*`
functions (e.g., colors). For instance, suppose we want to change the
color palette for categorical variables. First, note that ggplot has two
attributes that we intuitively may call “color”, yet represent two
different visual properties of a geom: `color` and `fill`. Some geoms
such as `geom_bar` have both, while others such a `geom_line` have only
`color`. Here we want to change the `fill` color in a barchart, thus we
want to change `scale_fill_*`. Moreover, because we are setting colors
manually, we select `scale_fill_manual` from the `scale_fill_*` family.

To pick colors, you can sue rgb, hex or \[color
names\]((<http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf>)

``` r
ggplot(data = dt) +
  geom_bar(aes(College, fill = Sex)) +
  scale_fill_manual(values  =  ... )
#  OR (ALTERNATIVELY) change the colors usig :     
#' scale_fill_brewer(type = ..., palette = ...)
#' scale_fill_brewer(palette = "Greens", name = 'Gender')

#' Add the below to:
#' - rotate axis labels 
#' - delete background
#' Note that you can save theme() to an object to "create a template"
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        panel.background = element_blank()
        )
```

ggplot2 uses default names for the scales of the mapped variables. You
can change those defaults by changing the values in
`scale_[aes]_[type]`:

``` r
ggplot(data = dt) +
  geom_bar(aes(College, fill = Sex))  +
  scale_x_discrete(name = 'College Abbreviations') 

#use the below function to change the legend title into "gender" the legend values into 'Male' and 'Female'
#  scale_fill_discrete(name = ... , labels =  ... ) 
#move the legend to the bottom. To find out how to do that, check the documentation for theme(legend.position)
```
