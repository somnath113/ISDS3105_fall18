lesson 15: Regression
================

# Introduction

In this lesson we will use a general linear model (glm) and in
particular linear regression to investigate the relationship between
heat and the daily number of crimes in Baton Rouge.

``` r
#' Retrieve our data from:
#' US-Climate Data
#source(here::here('lectures', 'lesson15_regression', 'scraperForTemperature.R'))
dt_temp <- read_rds(here::here('lectures', 'lesson15_regression', 'data', 'temperatures.rds'))
#' RSocrata-BR Open Data
#' source(here::here('lectures', 'lesson15_regression', 'callAPI.R'))
dt_crimes <- read_rds(here::here('lectures', 'lesson15_regression', 'data', 'crimes.rds'))
#merge the two dataset
dt_crimes <- dt_crimes %>% left_join(dt_temp, by = c('offense_date' = 'Day'))
```

# Fitting a linear model

A linear model has three elements:

  - random component, which consists of the response variable y and its
    probability distribution
  - linear predictor, or explanatory variable for y (can be continous or
    categorical)
  - link function, which connects the random component to the linear
    predictor (e.g., an identity function for a linear model)

<!-- end list -->

``` r
ggplot(data = dt_crimes, aes(x = TempHigh, y = n)) +
  geom_point() +
  #geom_smooth(method = "glm", method.args = list(family = 'gaussian'), aes(color = "gaussian"), se = F) +
  geom_smooth(method = "glm", method.args = list(family = 'poisson'), aes(color = "poisson"), se = T) +
  scale_x_continuous(name = 'Max Temp.(F)') +
  ggtitle('Count of crimes and daily Temperature') 
## Warning: Removed 1 rows containing non-finite values (stat_smooth).
## Warning: Removed 1 rows containing missing values (geom_point).
```

![](README_files/figure-gfm/visualizing%20a%20lm-1.png)<!-- -->

`se` is for displaying confidence intervals (95% by default). The
interpretation of confidence intervals it *not* a probability of being
right. Check [this animation](http://rpsychologist.com/d3/CI/) for a
brief explanation. It is a range of plausible values for the population
paremeter being estimated along with the estimation
procedure.

``` r
fit <- glm(n ~ TempHigh, family = poisson(link = 'log'), data = dt_crimes)
exp(fit$coefficients) #since the link function is a log, we need the inverse => exp 
## (Intercept)    TempHigh 
##    93.32419     1.00472
summary(fit)
## 
## Call:
## glm(formula = n ~ TempHigh, family = poisson(link = "log"), data = dt_crimes)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -5.4106  -1.4302  -0.1093   1.2644   7.9861  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)    
## (Intercept) 4.5360794  0.0324241  139.90   <2e-16 ***
## TempHigh    0.0047089  0.0003981   11.83   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for poisson family taken to be 1)
## 
##     Null deviance: 1530.4  on 364  degrees of freedom
## Residual deviance: 1387.2  on 363  degrees of freedom
##   (1 observation deleted due to missingness)
## AIC: 3850.6
## 
## Number of Fisher Scoring iterations: 4
#summary(glm(n ~ TempHigh,  data = dt_crimes))
```

Here is a quick-and-dirty way to think about setting `family` with
respect to the response variable:

  - `family = gaussian(link = "identity")` for continous variables
  - `family = poisson(link = 'log')` for continous variables
  - `family = binomial(link = 'logit')` for fitting a logistic
    regression to predict binary variables (yes/no)

## What can I a glm use the model for?

  - *Explanation*: you can write statements such as:

There is a significant positive association between heat and crimes. In
particular, for a 1 unite increase in the predictor (TempHigh), there is
a 1.00472 increase in the count of crimes.

  - *Prediction*: suppose you have a dataset of values to predict:

<!-- end list -->

``` r
toPredict <- data_frame(TempHigh = c(80, 100))
```

To calculate prediction confidence intervals
use:

``` r
pi <- predict(fit, type = 'response', newdata = toPredict, se.fit = T)[1:2] #95% prediction interval = -1.96*se< y-hat < + 1.96*se
data_frame(fitted = pi$fit, lower = (pi$fit - 1.96*pi$se.fit), upper = (pi$fit + 1.96*pi$se.fit))
## # A tibble: 2 x 3
##   fitted lower upper
##    <dbl> <dbl> <dbl>
## 1   136.  135.  137.
## 2   149.  147.  152.
```

Note that the interpretation of prediction intervals is not
straighforward. In brief: a 95% prediction interval means that if we
used this method to predict an interval on many different datasets on
which the model fits, 95% of the time the interval would contain the
predicted value.

# Model fit

Checking the model fit means assessing how good our model is in
reflecting our actual outcome variable. That means analyzing the
residuals looking for patterns that suggest misfit. What follows are
some visual tools to analyze residuals. This list if *very far* from
being complete and exhaustive. However, it shold give you an idea of
looking only at significance can be very misleading when interpreting
the results of a regression model.

``` r
dt_res <- fortify(fit)
ggplot(dt_res, aes(sample = .fitted))+
  stat_qq() + 
  stat_qq_line() +
  ggtitle('Normal QQ-plot')
```

![](README_files/figure-gfm/analysis%20of%20the%20residual-1.png)<!-- -->

``` r
ggplot(dt_res, aes(x = .fitted, y = .stdresid))+
  geom_point() + 
  geom_hline(yintercept = 0, linetype = 2) +
  ggtitle('Standardized Residuals vs. Fitted')
```

![](README_files/figure-gfm/analysis%20of%20the%20residual-2.png)<!-- -->

``` r
ggplot(dt_res, aes(x = .hat, y = .cooksd))+
  geom_point() + 
  stat_smooth(method="loess", na.rm=TRUE) +
  ggtitle("Cook's dist vs Leverage")
```

![](README_files/figure-gfm/analysis%20of%20the%20residual-3.png)<!-- -->

How to remedy for poor fit?

  - Adding more predictors (but there is a tradeoff with
    interpretability)
  - Transform the predictors (e.g., `glm(y ~ x^2, data)` instead of
    `glm(y ~ x, data)`)
  - Use different glm, maybe the relationship is non-linear (but that’s
    is beyond our scope for this class)

What does it mean when we add another predictor? Suppose we add
precipitations
too

``` r
fit2 <- glm(n ~ TempHigh + Precip, family = poisson(link = 'log'), data = dt_crimes)
```

``` r
# This won't render in Markdown (need html):
# library(plotly)
# plot_ly(data = dt_crimes, z = ~n, x = ~TempHigh, y = ~Precip,opacity = 0.5) %>%
#  add_markers( marker = list(size = 2)) %>%
#  #add_surface(z  = matrix(dt_crimes$n), type = 'surface') %>%
#  layout(scene = list(xaxis = list(title = 'Tempearature'),
#                     yaxis = list(title = 'Precipitations'),
#                     zaxis = list(title = 'crimes')))
#' Create a shareable link to your chart:
#' Set up API credentials: https://plot.ly/r/getting-started
#' chart_link = api_create(..., filename="scatter3d-basic")
```

### Exercise

  - Using `fit`, calculate a prediction interval for the number of
    crimes for a day with a max temperature of 84 and no rain, and
    another day with max temperature 84 and 2 inches of rain.

  - Plot the residuals for fit2 and analyze them. Select 1-2
    observations the particularly misbehave and think about possible
    causes (e.g. gameday? mardi-gras?)

## References

  - Agresti, Alan. *Foundations of linear and generalized linear
    models*. John Wiley & Sons, 2015. (An introduction to GLMs and has a
    lot of examples in R:)

  - Agresti, Alan. *An introduction to categorical data analysis*.
    Wiley, 2018. (Available online
    [here](https://mregresion.files.wordpress.com/2012/08/agresti-introduction-to-categorical-data.pdf))
