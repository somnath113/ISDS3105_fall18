Assingment 3
================
Mon Feb 11 15:34:26 2019

For this assignment we are using a dataset from the website
[Fivethirtyeight](http://fivethirtyeight.com/). All these datasets are
available on their [GitHub
page](https://github.com/fivethirtyeight/data/) and in the
`fivethirtyeight` package. The final sumbission will be an RMarkdown
report.

1.  Install and load the `fivethirtyeight` library. For this assigment
    we are using the dataset `bad_drivers`.
2.  In the narrative, add a brief description (`?bad_drivers` for a
    description of the dataset) using *inline code* to show the variable
    names.
3.  Plot a dot chart of premiums by losses. Map the count of drivers to
    the size of the dots.
4.  Test what values from `state` are equal to “Louisiana” and assign
    the output to a new variable called \`Louisiana’ (logical)
5.  Map the variable “Louisiana” to `color`. That way, the dot referring
    to Louisiana should have a different color.
6.  In your narrative, use inline code to report the average insurance
    premium and count of losses in US, and the premium and losses in
    Louisiana. Do not type those values manually, but extract them from
    the dataset using inline code.
7.  Report in a tabular format the 5 states with the highest premiums
    (include only state and insurance\_premiums)
8.  Reshape the dataset gathering together perc\_speeding,
    perc\_alcohol, perc\_not\_distracted in one variable, paired with
    their pecentages. Name this variable “ViolationType” and the
    variable for the value pairs “perc”.
9.  Use facetting (DO NOT use 3 distinct calls to `ggplot()`) to plot 3
    dot plots for the correlation between:

<!-- end list -->

  - insurance\_premiums and perc\_alcohol
  - insurance\_premiums and perc\_speeding
  - insurance\_premiums and perc\_not\_distracted

<!-- end list -->

10. Mute the code for both charts and add a title to both. Knit to html.
