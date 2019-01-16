library(tidyverse)

# Read the file `dataset.RDA` using readRDS

dt <- readRDS('onlineReviews_analysis/dataset.RDA')

# Adjust the datatypes as needed. Use mutate_at to apply the same function to multiple columns


# Write a function to plot a chart of rating frequencies for a single hotel. Each plot should be created with a title.
# Add an error message if the hotel name does not match any of the hotels in the dataset

ratingsHist <- function( ... ) {
  if ( .. ) stop( )
  
  
}


# Use iteration to create a plot for 5 hotels using `ratingsHist()`. Save them into a folder called `figures`.


#' Researchers claim that over time the rating distribution changes from approximately "normal" 
#' to a J-shaped distribution (very few 3s but a lot of extremly positive ratings, and some very negative ratings).
#' Pick a hotel with a large number of observations and show whether your data support this claim.
#' For instance, visualize how the distribution changes over time (years)



#' Other researchers argues that most recent reviews are more positive because of the pervasiveness of mobile phones.
#' Is the average score of reviews from mobile higher than for others? 


#' Show the trend of the cumulative mean by each new review. Use `cumsum` to calculate the cumulative mean of the scores. 


#' Use facetting to plot the score distributions for each attribute from Value to Service




#' Are the reviews with more helpful votes the ones that are more positive? Discretize the number of helpful
#' votes, and show the distributions for each level of the (discretized) unmber of helpful votes






