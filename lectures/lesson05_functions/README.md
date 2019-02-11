Lesson 5: Writing functions
================

\#\#Resources

  - For this course: [Chapter 19](http://r4ds.had.co.nz/functions.html).
  - To know more about functional programmin in R: [“Advanced R” -
    functional programming](http://adv-r.had.co.nz/Functions.html)

\#Using functions to automate tasks

Functions are tools for automating common tasks. What do we mean by
“common”? That is subjective. Copy-pasting the same code multiple
times is usually a sign that a task is “common”. Perhaps you should
recode it into a function. Functions make you type less, but they also
keep the instructions for tasks in the same place, thus avoiding
duplications. That makes easier to fix bugs and maintain the code, since
you will need to adjust your code only in the function’s body.

Each function has three constitutive elements: function name, attribute,
and body.

1.  **Name**. The name is what you use to call an object/function. Try
    name a function after what it does, ideally using verbs (e.g.,
    `filter()`, `mutate()`). If you have similar functions performing
    similar tasks, use consistent naming (e.g., `convert_toDollar`,
    `convert_toEuro` or `convertToDollar`, `convertToEuro`).

2.  **Arguments**: Arguments control *how* you call the function (using
    what parameters). Preferably, comply with naming conventions such as
    using `x, y, z` for vectors, or `df` for dataframes. You can set as
    many attributes as you prefer, and assign them default values.

3.  **Body**. The body contains the instructions on how to manipulate
    the objects.

To create a function named `showValue` which takes the argument `x`:

``` r
showValue <- function(x) { return(x) }
showValue
```

    ## function(x) { return(x) }

To pass values to the argument `x`:

``` r
showValue(x = 'high')
```

    ## [1] "high"

``` r
showValue(x = 5)
```

    ## [1] 5

Arguments can have default values. For instance:

``` r
showValue <- function(x = 5, y = 10) c(x, y)
showValue(x = 7)
```

    ## [1]  7 10

To use a more concise notation we can:

  - skip the curly brackets when the body is inlined to the arguments’
    specification
  - skip `return` to return the value in the last line of code

<!-- end list -->

``` r
showValue <- function(x) x
showValue(x = 5)
```

    ## [1] 5

``` r
funSum <- function(x, y) x + y
funSum(2, 5)
```

    ## [1] 7

``` r
funSum(c(2, 5), 5)
```

    ## [1]  7 10

\#Lexical scoping

When we create an object, R searches it by name in the global
environment:

``` r
x <- 'hello'
x
```

    ## [1] "hello"

However, functions will do search for their attributes in the global
environment. Instead, R searches the variables in the function body.

``` r
x <- 10
showValue <- function(x) x
```

It will find only objects that you passed as function arguments:

``` r
showValue(x = 5)
```

    ## [1] 5

If an object is not listed as an argument, R will look for it one level
up, until it reachers the global enviroment:

``` r
y <- 10
showValue <- function(x) c(x, y)
showValue(x = 5)
```

    ## [1]  5 10

Do you think `showValue(y = 5)` would work too?

If you have two nested functions, R goes two levels up:

``` r
#this function is to convert a dollar amount in euros and auds
euro_ex <- .86    #euro exchange rate is defined in the global enviroment - 2 levels up than conv_toEuro()
aud_ex <- 1.37    # aud exchange rate in defined in the global enviroment - 2 levels up than conv_toEAud()

showValue <- function(dollars) {      
  x <- dollars
  conv_toEuro <- function() paste(x*euro_ex, 'Euros')
  conv_toEAud <- function() paste(x*aud_ex, 'Auds')
  c(conv_toEuro(), conv_toEAud())
}

showValue(18)
```

    ## [1] "15.48 Euros" "24.66 Auds"

Similarly, assigment operations within a function will affect only the
current enviroment (inside the function) and not the global environment:

``` r
assignValue <- function() {
  x <- 5
  x
  }
assignValue()
```

    ## [1] 5

``` r
x   #do you see why this is not 5?
```

    ## [1] 10

To create objects in the global enviroment from inside a function use
`<<-`:

``` r
assignValue <- function(x) {
  new_x <<- x
  paste('I created', x,'in the global env!')
  }
assignValue(9)
```

    ## [1] "I created 9 in the global env!"

## The `...` argument

Sometimes you don’t know how many attributes you want to pass. For
instance, the function `c()` is designed to concatenate an unlimited
number of elements. Unlimited arguments are possibile using `...`, which
means that any objects you pass to the position of `...` will become an
argument. Many base R function actually use the `...` argument
definition (e.g., `sum()`, `mean()`, etc.) but in different ways:

``` r
#sum(..., na.rm = FALSE)
sum(c(1, 2), c(1, 4))
```

    ## [1] 8

``` r
sum(c(1, 2, 1, 4))
```

    ## [1] 8

For instance, you may need to write function using `...` when you need
to pass multiple objects into a function that allows `...`:

``` r
lowerNames <- function(..., pad = "; ") {
  
  tolower(paste(..., sep = pad))
  
}

lowerNames(c("College of Business"), c("College of Engineering"))
```

    ## [1] "college of business; college of engineering"

Use named attributes when you can instead of `...`: it makes easier to
ensure that you are not passing wrong/mispelled arguments’ names. For
instance, note how the below code doesn’t trigger an error in spite of
misspelling `na.rm = TRUE`

``` r
x <- c(1, 2)
sum(x, na.mr = TRUE)
```

    ## [1] 4

`na.mr` (which instead should be `na.rm`) does not match to any
arguments defined in `sum()` and is treated as an element that is being
passed to `...`

## Conditional Execution

Use `if(condition) { }` to conditionally execute a snippet of code. For
instance, you can test whether the library `tidyverse` is installed, and
install it if it is not:

``` r
if(!require(tidyverse)) { install.packages('tidyverse') }
```

    ## Warning: package 'stringr' was built under R version 3.5.2

Each if-statement evaluates to a `TRUE` or `FALSE`, thus be carefull
when you are testing vectors: only the first element will be used\!

``` r
lang_avail <- c('english', 'italian')
lang_greeting <- 'italian'
if(lang_avail %in% lang_greeting) { 'ciao' } 
```

    ## Warning in if (lang_avail %in% lang_greeting) {: the condition has length >
    ## 1 and only the first element will be used

``` r
#do you see why no 'ciao' is returned although lang_greeting is in lang_avail?
```

If-statements are useful to trigger error messages. For instance, you
can trigger an error message if you pass a non-numeric value to
`showNumeric()`

``` r
showNumeric <- function(x) {
  
  if (!is.double(x)) stop('`x` is not double')
  
  x
  
}
showNumeric('hello')
```

    ## Error in showNumeric("hello"): `x` is not double

The `call. = FALSE` drops the function call from the error message. Make
sure error messages are informative, since they will make debugging a
lot easier later. Also, you want to code good error handlers early on:
it is unlikely that you will go back to writing error with the same
enthusiasm that you had when writing a function for the first time.

You can also combine multiple if-statements to conditionally run
different snippets of code depending on the input variable:

``` r
#A function to tell you the type of a 1 element object
showType <- function(x) {
  
 if (length(x) > 1) stop('`x` has to be a vector of length = 1', call. = F)
  
    if (is.numeric(x)) {
      
      x <-  'Is numeric!'
      
    } else if(is.logical(x)) {
      
      x <- 'Is logical!'
      
    } else {
      
      x <-  'Is something else'
      
    }
  x
}
showType('hi')
```

    ## [1] "Is something else"

``` r
showType(5)
```

    ## [1] "Is numeric!"

``` r
showType(c('hi', 'k'))
```

    ## Error: `x` has to be a vector of length = 1

\#\#Exercise 1

Turn the followings into functions, making sure that your function
retrieves an error if `x` is not numeric.

  - `mean(x, na.rm = T)`

  - `x / sum(x, na.rm = TRUE)`

  - `sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)`

For the pros: Use `BRRR::skrrrahh(34)` to listen DJ Khaled yelling “They
don’t wanna see us win\!” when `x` is not numeric. The package is
available on GitHub only:

``` r
# install devtools - a package to install packages directly from GitHub
# install BRRR from GitHub
devtools::install_github("brooke-watson/BRRR")
```

\#\#Exercise 2

Write a function `yearlySalary` to convert any values \<8000 to NA. You
can use indexing or a function such as `ifelse()`. Then, output each
value as a dollar amount using `scales::dollar()` or `paste()`. For
example, the `c(100, 0, NA, 2000, 8000)` should be returned as `c("$NA",
"$NA", "$NA", "$NA", "$8000")`.
