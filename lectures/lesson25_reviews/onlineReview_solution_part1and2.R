library(tidyverse)

# Read the file `dataset.RDA` using readRDS
dt <- readRDS(here::here('onlineReviews_analysis/dataset.RDA'))

# Adjust the datatypes as needed. Use mutate_at to apply the same function to multiple columns
dt <- dt %>% mutate(ratingDate = lubridate::mdy(ratingDate)) %>% 
  mutate_at(vars(helpfulVotes, totalScore:Service), as.double)

# Write a function called to plot a chart of rating frequencies for a single hotel. Add a title to each plot with the hotel name.
# Add an error message if the hotel name does not match any of the hotels in the dataset

ratingsHist <- function(df, name) {
  if (!(name %in% unique(df$hotel))) stop('You need to pick a hotel within those avaialble in the dataset')
  ggplot(filter(df, hotel == name)) +
    geom_bar(aes(x = totalScore)) +
    ggtitle(name)
}

ratingsHist(dt, 'W Taipei')

# Use iteration to create a plot (using ratingHist) for 5 hotels. Save all of them separately into a folder called `figures`.
plots <- purrr::map(.x = unique(dt$hotel)[1:5], ~ ratingsHist(dt, .x))
purrr::map2(.x = plots, .y = unique(dt$hotel)[1:5], 
            ~ ggsave(filename = paste0('figures/', .y, '.png'), plot = .x))

#' Researchers claim that over time the rating distribution changes from approximately "normal" 
#' to a J-shaped distribution (read Hu et al. 2009).
#' Do the data support this claim? Start by plotting a hotel with a largen number of reviews to visualize how the distribution changes over time. 
#' Then repeat on multiple hotels to assess whether your finding is generalizable 

dtCosmos <- dt %>% filter(hotel == 'Cosmos Hotel Taipei')

dtCosmos %>% 
  ggplot() +
  geom_bar(aes(x = totalScore)) +
  facet_wrap(~ lubridate::year(ratingDate))

#' Other researchers argues that most recent reviews are more positive because of the pervasiveness of mobile phones.
#' Is the average score of reviews from mobile higher than for others? 

dtCosmos %>% 
  group_by(mobile) %>% 
  summarise(avg = mean(totalScore, na.rm = T))

#' Show the trend of the cumulative mean. Use `cumsum` to calculate the cumulative mean of the scores. 

dtCosmos %>% 
  arrange(ratingDate) %>% 
  mutate(dummy = 1, totReviews  = cumsum(dummy), sum = cumsum(totalScore)) %>% 
  select(totReviews, sum) %>% 
  mutate(avg = sum/totReviews) %>% 
  ggplot() + 
  geom_line(aes(x = totReviews, y = avg))


#' Use facetting to plot the score distributions for each attribute from Value to Service

dtCosmos %>% gather('attribute', 'value', Value:Service) %>% 
  filter(!is.na(value)) %>% 
  ggplot() +
  geom_bar(aes(x = value)) +
  facet_wrap(~ attribute)
