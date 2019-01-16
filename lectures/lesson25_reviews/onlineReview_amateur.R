library(tidyverse)

# Read the file `dataset.RDA` using readRDS
dt <- dt %>% mutate_at(vars(totalScore:`Business service (e.g., internet access)`), as.double)
dt <- readRDS('onlineReviews_analysis/dataset.RDA')

# Adjust the datatypes as needed. Use mutate_at to apply the same function to multiple columns
dt <- dt %>% mutate(ratingDate = lubridate::mdy( .. )) %>% 
  mutate_at( ... , as.double)

# Write a function to plot a chart of rating frequencies for a single hotel. Each plot should be created with a title.
# Add an error message if the hotel name does not match any of the hotels in the dataset

ratingsHist <- function(df, name) {
  if (!( ...  %in% unique(dt$hotel))) stop('You need to pick a hotel within those avaialble in the dataset')
  ggplot(filter( ... , hotel == ... )) +
    geom_bar(aes(x = ... )) +
    ggtitle( ... )
}

#if the functions is correct, the below code should run:
ratingsHist(dt, 'W Taipei')

# Use iteration to create a plot for 5 hotels. Save them into a folder called `figures`.

plots <- purrr::map(.x = unique(dt$hotel)[1:5], ~ ... )

# create a path for your files using paste0() and .y
purrr::map2(.x = plots, .y = unique(dt$hotel)[1:5], ~ ggsave(... , .x))

#' Researchers claim that over time the rating distribution changes from approximately "normal" 
#' to a J-shaped distribution (very few 3s but a lot of extremly positive ratings, and some very negative ratings).
#' Pick a hotel with a large number of observations and show whether your data support this claim.
#' For instance, visualize how the distribution changes over time (years)

dt %>% count(hotel, sort = T)

#pick a random hotel name
dtCosmos <- dt %>% filter(hotel == 'Cosmos Hotel Taipei')

library(lubridate)
dtCosmos %>% mutate(ratingDate = mdy(ratingDate)) %>% 
  ggplot() +
  geom_bar(aes(x =  totalScore)) +
  facet_wrap(~ year(ratingDate))


#' Other researchers argues that most recent reviews are more positive because of the pervasiveness of mobile phones.
#' Is the average score of reviews from mobile higher than for others? 

dtCosmos %>% 
  group_by(mobile) %>% 
  summarise(avg = mean(totalScore))

#' Show the trend of the cumulative mean by each new review. Use `cumsum` to calculate the cumulative mean of the scores. 

dtCosmos %>% 
  arrange(ratingDate) %>% 
  mutate(dummy = 1, totReviews  = cumsum(dummy), sum = cumsum(totalScore)) %>% 
  mutate(avg = sum/totReviews) %>% 
  ggplot() + 
     geom_line(aes(x = totReviews , y =  avg ))


#' Use facetting to plot the score distributions for each attribute from Value to Service

dtCosmos %>% gather('attributeName', 'rating', Value:Service) %>% 
  #select(attributeName, rating)
  ggplot() +
  geom_bar(aes(x = rating)) +
  facet_wrap(~ attributeName)


#' Other researchers argues that most recent reviews are more positive because of the pervasiveness of mobile phones.
#' Is the average score of reviews from mobile higher than for others? 

dt %>% 
  group_by( ... ) %>% 
  summarise(avgScore = .....)


#' Are the reviews with more helpful votes the ones that are more positive? Discretize the number of helpful
#' votes, and show the distributions for each level of the (discretized) number of helpful votes

#' Use case_when to create three lels of variable `helpfulness`

dt %>% 
  mutate(helpfulness = case_when(
    is.na(helpfulVotes) ~ "Unhelpful",
    between(helpfulVotes,  1 , 5 )  ~  'medium',
    T ~  'very helpful'
    )) -> dt

ggplot(dt) +
  geom_bar(aes(x = totalScore)) +
  facet_wrap( ~ helpfulness, scales = 'free_y')






