Interactive Dashboards with Flexdashboard
================

`flexdashboard` is a package that leverages RMarkdown syntax for
building
[dashboards](https://rmarkdown.rstudio.com/flexdashboard/examples.html).
You can combine flexdashboard with the [shiny
package](https://shiny.rstudio.com/) to add interactivity to your web
app, and or use CSS or JavaScript to change the page aesthetics. This
makes relatively easy to deploy dashboards with little knowledge of
webprogramming.

Dashboards are often used for exploratory analysis or monitoring, but
they can be quite effective tools for telling *your* data-driven story.
For example, the using [story-board
menus](https://beta.rstudioconnect.com/jjallaire/htmlwidgets-showcase-storyboard/htmlwidgets-showcase-storyboard.html)
is a very valid alternative to powerpoint presentations.

To start with `flexdashboard`, follow these
[instructions](https://rmarkdown.rstudio.com/flexdashboard/). To install
`flexdashboard` and `shiny`

``` r
install.packages("flexdashboard")
install.packages("shiny")
```

Our goal is to create a dashboard to analyse data about the victims of
terrorism using the dataset available on the GitHub page of
`fivethirtyeight`:

``` r
dt <- read_csv(file = 'https://raw.githubusercontent.com/fivethirtyeight/data/master/terrorism/eu_terrorism_fatalities_by_country.csv')
```

The final output is to build this
[webapp](https://dario.shinyapps.io/terrorismApp_3/) to display data of
terrosism casualties in Europe:

1.  Filling the dashboard tempalte with static barcharts `terrosimApp_1`
2.  Adding interactivity to the barcharts to allow selection of the
    state to plot `terrorismApp_2`.
3.  Adding a botton to rescale the vertical axes of the interactive
    charts.
