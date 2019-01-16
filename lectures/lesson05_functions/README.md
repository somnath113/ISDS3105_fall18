Lesson 2: Writing functions
================

Resources
---------

[Chapter 19](http://r4ds.had.co.nz/functions.html). If you are interested in learning more about functional programming, the [Advanced R](http://adv-r.had.co.nz/) book explains more in depth how [functional programming](http://adv-r.had.co.nz/Functions.html) in R works.

Why do we need functions?
=========================

Functions are tools for automating common tasks. Defining what is "common" is subjective, but if you find yourself copy-pasting the same code multiple times that is usually a red flag and you might want to write a function. Not only that saves you a lot of typing, but it also keeps the instructions for the task you want to perform in one snippet of code, avoiding duplications. That makes easier to fix bugs and maintain the code for that task, since you need to adjust your code only once (in the body of the function being called). This approach is arguably more efficient than fixing duplications of your code throughout your script.

There are three constitutive elements of each function: function name, attribute, and body.

1.  **Name**. Naming is important because - as with any object in R - it allows to call an object/function. When naming custom function, try to pick a name that is descriptive of what that function does, ideally a verb (e.g., `filter()`, `mutate()`). If you have similar functions performing similar tasks, use consistent naming (e.g., `convert_toDollar`, `convert_toEuro` or `convertToDollar`, `convertToEuro`).

2.  **Arguments**: Arguments control *how* you can call the function (using what parameters). There are some naming conventions for attributes that you should preferably stick to (e.g., `x, y, z` for vectors, or `df` for dataframes). You can set as many attributes as you prefer, and assign default values when you find it appropriate.

3.  **Body**: It contains the instructions on how to manipulate the objects.

To create a function named `showValue` taking a single argument `x`:

``` r
showValue <- function(x) { return(x) }
showValue(x = 'high')
```

    ## [1] "high"

``` r
showValue(x = 5)
```

    ## [1] 5

To use a more concise notation we can:

-   skip the curly brackets when the body is inlined to the arguments' specification
-   skip `return` if we want to return the value in the last line of code

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

Lexical scoping
===============

R searches objects by name in the global environment when we create one:

``` r
x <- 'hello'
x
```

    ## [1] "hello"

When creating a function, R first searches the variables in the function body between those passed to the function arguments:

``` r
x <- 10
showValue <- function(x) x
showValue(x = 5)
```

    ## [1] 5

Arguments can have default values. For instance:

``` r
showValue <- function(x = 5, y = 10) c(x, y)
showValue(x = 7)
```

    ## [1]  7 10

If an object is not defined inside the function, R will look for it one level up, untill it reachers the global enviroment:

``` r
y <- 10
showValue <- function(x) c(x, y)
showValue(x = 5)
```

    ## [1]  5 10

If you have two nested functions, R goes two levels up:

``` r
#this function is to convert a dollar amount in euros and auds

euro_ex <- .86    #defined in the global enviroment - 2 levels up
aud_ex <- 1.37    #defined in the global enviroment - 2 levels up

showValue <- function(dollars) {      
  x <- dollars
  conv_toEuro <- function() paste(x*euro_ex, 'Euros')
  conv_toEAud <- function() paste(x*aud_ex, 'Auds')
  c(conv_toEuro(), conv_toEAud())
}

showValue(18)
```

    ## [1] "15.48 Euros" "24.66 Auds"

Similarly, assigment operations within a function will affect only the current enviroment (inside the function) and not the global environment:

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

To create objects in the global enviroment from inside a use `<<-`:

``` r
assignValue <- function(x) {
  new_x <<- x
  paste('I created', x,'in the global env!')
  }
assignValue(9)
```

    ## [1] "I created 9 in the global env!"

The `...` argument
------------------

Sometimes a function does not have a predetermined number of attributes. For instance, the function `c()` is designed to concatenate an unlimited number of elements. This is possible using the argument `...`, which means that any objects you pass to the position of `...` are treated as arguments. Many base R function actually use the `...` argument definition (e.g., `sum()`, `mean()`, etc.) but in different ways:

``` r
#sum(..., na.rm = FALSE)
sum(c(1, 2), c(1, 4))
```

    ## [1] 8

``` r
sum(c(1, 2, 1, 4))
```

    ## [1] 8

A frequent case where you need to write function using `...`, is when you need to pass multiple objects into a function that allows `...`:

``` r
lowerNames <- function(..., pad = "; ") {
  
  tolower(paste(..., sep = pad))
  
}

#do you see why it doesn't separate using `; `?
lowerNames(c("College of Business"), c("College of Engineering"), pad = ' | ')
```

    ## [1] "college of business | college of engineering"

Be careful when using `...` instead of named attributes because it makes harder to ensure that you are not passing wrong/mispelled arguments' names. For instance, the below would give you a result in spite of misspelling `na.rm = TRUE`

``` r
x <- c(1, 2)
sum(x, na.mr = TRUE)
```

    ## [1] 4

That is because `na.mr` (which instead should be `na.rm`) does not match to any arguments defined in `sum()` and is treated as an element that is being passed to `...`

``` r
sum(c(1, 2, NA), TRUE)
```

    ## [1] NA

``` r
#while instead we wanted
sum(c(1, 2, NA), na.rm = TRUE)
```

    ## [1] 3

Conditional Execution
---------------------

Using `if(condition) { }` you can conditionally execute a snippet of code. For instance, we can test whether you installed the library `tidyverse` and install it if not:

``` r
if(!require(tidyverse)) {install.packages('tidyverse')}
```

Each if-statement evaluates to a `TRUE` or `FALSE`, thus be carefull when you are testing vectors: Only the first element will be used.

``` r
lang_avail <- c('english', 'italian')
lang_greeting <- 'italian'
if(lang_avail %in% lang_greeting) { 'ciao' }
```

    ## Warning in if (lang_avail %in% lang_greeting) {: the condition has length >
    ## 1 and only the first element will be used

If-statements are useful to trigger error messages. For instance, you can trigger an error message when you passed a non-numeric value to `showNumeric()`

``` r
showNumeric <- function(x) {
  
  if (!is.double(x)) stop('`x` is not double')
  
  x
  
}
showNumeric('hello')
```

    ## Error in showNumeric("hello"): `x` is not double

The `call. = FALSE` drops the function call from the error message. Make sure your error messages are informative, because they will make debugging a lot easier later. Also, you want to code good error handlers early on: It is unlikely that you will go back to writing error with the same enthusiasm than you had when writing a function for the first time.

You can also combine multiple if-statements to conditionally run different snippets of code depending on the input variable:

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
showType(c('hi', 'k'))
```

    ## Error: `x` has to be a vector of length = 1

Exercise 1
----------

Turn the followings into functions, making sure that your function retrieves an error if `x` is not numeric.

-   `mean(x, na.rm = T)`

-   `x / sum(x, na.rm = TRUE)`

-   `sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)`

For the pros: Use `BRRR::skrrrahh(34)` to listen DJ Khaled yelling "They don't wanna see us win!" when `x` is not numeric. The package is available on GitHub only:

``` r
if(!require(devtools)) {install.packages('devtools')}
devtools::install_github("brooke-watson/BRRR")
```

Exercise 2
----------

Write a function `yearlySalary` to convert any values &lt;8000 to NA. You can use indexing or a function such as `ifelse()`. Then, output each value as a dollar amount using `scales::dollar()`. For example, the `c(100, 0, NA, 2000, 8000)` should be returned as `c("$NA", "$NA", "$NA", "$NA", "$8000")`.
