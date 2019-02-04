

Lesson 3
=======
autosize: true

In R everything is an object
=======

 - To create an object, assign its content to an object name using `<-` (the assignment operator)

```r
myVector <- c(1, 5, 3)
```
 
 - Objects that allow to perform actions on other objects are called functions. They are "containers" with instructions about what to do with other objects (e.g., `mean()`, `sum()`)

```r
mean(myVector)
[1] 3
```
 
 - All functions have documentation files that can be accessed using `?` (e.g., `?mean()`)

Cont'd
====== 

 - A function may require a minimum set of arguments to run successfully (e.g., `mean()` requires an argument `x`)

```r
mean()
Error in mean.default(): argument "x" is missing, with no default
```

 - Some functions require to pass specific object of a specific type (e.g., `sum()` expects a vector)

```r
sum('hello')
Error in sum("hello"): invalid 'type' (character) of argument
```


Naming  rules for R objects
=======
 - Names must start with a letter
 

```r
1object <- 1
Error: <text>:1:2: unexpected symbol
1: 1object
     ^
```
 
 - Names can contain letters, digits, _ and . (e.g., object, object1, object_1, myObject, myobject, my_object)
 - Using spaces and other symbols in objects/elements names is highly discouraged, but you can do it with ` ` ` (backtick)
 

```r
`1object` <- 1
```
 

Data structures
=======
 - Vectors (e.g., `letters`) and matrices (e.g., `matrix(letters, ncol = 2)`)
 - Lists and dataframes (e.g., `iris`)
 - Tibbles (because we use the tidyverse)
 - And many others we won't look at (array, methods, etc.)
 
Atomic Vectors
=======
 - A 1D collection of homogeneous elements
 - The ultimate constitutive element of any data structure
 - Vectors' types are for example: double, integer, logical, character

To create a vector use the `c()` function:


```r
c(1, 2, 3, 4, 5)
[1] 1 2 3 4 5
#or alternatively
c(1:5)
[1] 1 2 3 4 5
```



Two ways to declare the type of a vector:
=======
 - Letting R coercing to the most flexible type based on your input 


```r
typeof(c(1L, 6L, 3L))
[1] "integer"
typeof(c("A", "character", "vector"))
[1] "character"
typeof(c(T, TRUE, FALSE))
[1] "logical"
```
 
 - Coercing using functions: `as.character()`, `as.numeric()`, etc.
 

```r
as.integer(c(1,5,7))
[1] 1 5 7
as.integer(str(c(1L,5L,7L)))
 int [1:3] 1 5 7
integer(0)
as.integer(c('2','a'))
[1]  2 NA
```
 
Question
====
What happens if you coherce to a "wrong" type? E.g.: `as.integer(c('2','a'))`


```r
as.integer(c('2','a'))
[1]  2 NA
```


Why we care about types
======= 
 - What are the types of the below vectors?
 - Is `sort()` arranging the number as you expect? Why? 
 - Are all the below vectors atomic (test it using `is.atomic()`)?


```r
sort(c("1", "2", "100", "5", "4"))
[1] "1"   "100" "2"   "4"   "5"  
sort(as.factor(c("1", "2", "100", "5", "4")))
[1] 1   100 2   4   5  
Levels: 1 100 2 4 5
sort(as.double(c("1", "2", "100", "5", "4")))
[1]   1   2   4   5 100
```


Vector indexing
=======
You can extract elements of a vector using numeric indexing `myVector[2]` or element(s) name(s) (e.g., `myVector['name']`). Indexing starts at `[1]` (unlike other programming languages that sart at `0`).

Consider the following named vector:


```r
menu <- c(pizza = '$8', lasagne = '$7.50', pasta = '$7')
```


Vector indexing
===

To extract the 1st and 3rd elements:


```r
menu[c(1, 3)]
pizza pasta 
 "$8"  "$7" 
```

To drop the 2nd and 3rd elements:


```r
menu[-c(2:3)]
pizza 
 "$8" 
```


Exercise
===

Use `sum()` and the vector `menu` to calculate the cost of the DDSLab research lunch at Gino's


```r
menu <- c(pizza = 8, lasagne = 7.50, pasta = 7)
receipt <- c(Dario = 'lasagne', Som = 'pizza', Sun = 'pasta', Jo = 'pizza', Gabe = 'pasta', Biagio = 'pasta')
```



Recursive Vectors - lists
======= 

A list is a 1D collection of heterogeneous elements. Heterogeneitiy refers to both in terms of data structure and type:


```r
myList <- list(1:3, "a", c(TRUE, FALSE, TRUE), list(letters, c(2, 6)))
typeof(myList)
[1] "list"
str(myList, max.level = 1)
List of 4
 $ : int [1:3] 1 2 3
 $ : chr "a"
 $ : logi [1:3] TRUE FALSE TRUE
 $ :List of 2
```


Recursive Vectors - lists
======= 

Most likely, we will never manipulate list objects. However, many functions return lists.  For example, the output of fitting a linear model `lm()` is a list:


```r
fit <- lm(mpg ~ wt, data = mtcars)
str(fit, max.level = 0) #change max.level to view elements in the list
List of 12
 - attr(*, "class")= chr "lm"
```


For the next time
=======

Complete `assignment01`
