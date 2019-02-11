Assignment 2
================
Somnath

The goal of this practice is to improve your understanding of vectors and how to manipulate them. The data we use are the prices of the [2017 Big Mac Index](http://www.economist.com/content/big-mac-index).

For each question, please create a new chunck with your reponse. Use narratives to comment the output whenever the question requires to do so.

1.  Edit the code below to assign country names to the vector `countries` and prices to the vector `prices`. Hide the code below when you knit (check the Rmarkdown cheatsheet to find the appropriate chunk option to hide code).

2.  Use `typeof()` to report the types of both vectors.

``` r
typeof(countries)
```

    ## [1] "character"

``` r
typeof(prices)
```

    ## [1] "double"

1.  Use `names()` to name the `prices` using `countries`. Show the first 5 values of the named vector of prices.

``` r
names(prices) = countries
prices[1:5]
```

    ## Argentina Australia    Brazil   Britain    Canada 
    ##  4.125534  4.527955  5.101568  4.111432  4.655697

1.  Use `round()` to round the prices to the 3rd decimal. Overwrite `prices` with the rounded prices.

``` r
prices = round(prices,3)
prices
```

    ##      Argentina      Australia         Brazil        Britain         Canada 
    ##          4.126          4.528          5.102          4.111          4.656 
    ##          Chile          China       Colombia     Costa Rica Czech Republic 
    ##          3.844          2.917          3.244          4.000          3.281 
    ##        Denmark          Egypt      Euro area      Hong Kong        Hungary 
    ##          4.606          1.754          4.465          2.458          3.209 
    ##          India      Indonesia         Israel          Japan       Malaysia 
    ##          2.757          2.403          4.773          3.361          2.003 
    ##         Mexico    New Zealand         Norway       Pakistan           Peru 
    ##          2.754          4.432          5.914          3.566          3.229 
    ##    Philippines         Poland         Russia   Saudi Arabia      Singapore 
    ##          2.649          2.723          2.278          3.200          4.065 
    ##   South Africa    South Korea      Sri Lanka         Sweden    Switzerland 
    ##          2.261          3.844          3.773          5.819          6.742 
    ##         Taiwan       Thailand         Turkey            UAE        Ukraine 
    ##          2.264          3.496          3.006          3.812          1.698 
    ##  United States        Uruguay      Venezuela        Vietnam        Austria 
    ##          5.300          4.529          4.056          2.639          3.883 
    ##        Belgium        Estonia        Finland         France        Germany 
    ##          4.625          3.597          5.207          4.682          4.454 
    ##         Greece        Ireland          Italy    Netherlands       Portugal 
    ##          3.826          4.648          4.796          4.122          3.711 
    ##          Spain 
    ##          4.339

1.  Use name indexing to report the prices for Canada, United States, Mexico

``` r
prices['Canada']
```

    ## Canada 
    ##  4.656

``` r
prices['United States'] 
```

    ## United States 
    ##           5.3

``` r
prices['Mexico']
```

    ## Mexico 
    ##  2.754

``` r
prices[c('Canada', 'United States', 'Mexico')]
```

    ##        Canada United States        Mexico 
    ##         4.656         5.300         2.754

1.  Use inline code and the function `length()` to display the following sentence:

"The are x observations in the Big-Mac Index"

``` r
paste("There are ", length(prices) ," observation in the Big-Mac Index")
```

    ## [1] "There are  56  observation in the Big-Mac Index"

1.  Convert the prices from Dollar to Euro (1 Dollar = .83 Euro). In the narrative, comment about the property which allows you to combine a vector of length 1 (the exchange rate) with a vector of length 56 (the prices).

-   Could you use the vector `rep(.83, 28)` to do the same?
-   Could you use the vector `rep(.83, 112)` to do the same?
-   Would `rep(.83, 45)` also work? Why?

``` r
pricesEuro1 = round(prices*.83,3) #vectorization in R.
pricesEuro2 = round(prices*rep(rep(.83,28),2),3)
pricesEuro3 = round(prices*(rep(.83,112)[1:56]),3)
pricesEuro4 = round(prices*c(rep(.83,45),rep(.83,11)),3)
```

1.  In your narrative, mention that we are going to drop the 46th element. Use inline code to report the country that will drop.

``` r
paste("we are going to drop the 46th element", names(prices[46]))
```

    ## [1] "we are going to drop the 46th element Belgium"

1.  Overwrite the vector of prices with a new vector without observation 46. Use `length()` to show that you have one observation less.

``` r
pricesRemoved = prices[-46]
length(pricesRemoved)
```

    ## [1] 55

1.  Knit, commit and push to your GitHub repo `assignment`. Then submit the link to the *assignment folder* on Moodle.
