2nd Assignment
================

In this assigment you will look at May 2017 list of graduates to investigate the gender composition of Colleges at LSU. Please respond to each question, then hide to code for the **whole** document. Questions are typed as commented code in your code chuncks, so that they won't display when you need. Thus, you wan't to make sure that you use narratives appropriately to make your report understandable. Delete this paragraph too before you submit!

``` r
#1.     Run the code below to read the dataset `may2017graduates.RDA` into the object dt. Make sure both object are in the same directory: if you get an error, you are probably passing the wrong path
dt <- readRDS('may2017graduates.RDA')
```

``` r
#2. Create an header called 'Introduction' and use some narrative to mention what this dataset is about (e.g. "This is a dataset about May 2017 graduates..."). Use and appropriate function to write some INLINE CODE to report how many records you have (e.g., nrow(), length()). 
```

``` r
#3 You want to repot the College names in the dataset, but you have only college "codes". First, use the below vectors to build a named vector, then use indexing to create a vector of college "full" names (e.g. "Humanities & Social Sciences"). Then, add the vector with "full" names as a column to dt. Finally, combine the functions unique() and sort() to report the unique college names from the new column.
college <- c("Graduate School", "Humanities & Social Sciences", "Business", "Agriculture", "Human Sciences and Education", "Art & Design", "Science", "Engineering", "Coast & Environment", "Music & Dramatic Arts", "Law", "Mass Communication", "Veterinary", "Coastal & Environmental Studies")
collegeabb <-  c("GRAD", "HSS", "BADM", "AGRI", "HSE", "ADSN", "SCI", "ENGR", "CCE", "MDA", "L", "MCOM", "VETM", "SCE")
```

``` r
#4. Create a header called 'Analysis'. Use table() to count how many males/females graduated from LSU this commencement.
```

``` r
#5. Report the percent of males/females. You can either divide the total by the output of table() from question three, or use prop.table(). If you use ?prop.table(), make sure you are passing the appropriate object to prop.table(x = )
```

``` r
#6. The rest of the analysis will focus on the College of business only, called "BADM". Subset the dataset accordingly, and save the output to a new object (name it as you prefer, but do not overwrite dt)
```

``` r
#7. Use your narrative to mention that "Our analysis focuses on the college of x, which includes y observations". Make sure that both x and y are created dinamically using inline code. Use table() to report the count of females/males for the dataset that you created in #6
```

``` r
#8. You want to test if the proportion of females/males within the college is statistically significantly different.
#Use prop.test(). Make sure you check the documentation and you pass:
#      to x, the count of either males, or females only    -----   to count males and females use table() and indexing, or subset and count using nrow()/length()
#      to n, the total count of students in the college of business
#      to p, the proportion of males vs. females under the hypothesis that there is not difference (.50 --> 50%)

#9. Save the output from 8 to an object

#10. Use inline code to write your conclusion on whether to accept/reject the null hypothesis, and with what p-value. To report the p-value, make sure you extract the appropriate element from the output of prop.test(), and round the p-value to the 3rd decimal using round().

#11. Use inline code to write the following sentence dynamically: 
#    "Since p = X, we conclude that the proportion of males and females in Y Z different from 50%."
#     Where X is the p-value extracted from the object you created in 9
#           Y is the college name
#           Z is an ifelse() statement that takes the value 'is not' when X>0.05, and 'is' when X<=0.05
```

``` r
#12. knit to pdf and submit ***BOTH*** the .Rmd and the pdf to the moodle online dropbox
```
