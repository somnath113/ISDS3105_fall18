library(RSocrata)
library(tidyverse)
source(here::here('lectures', 'lesson11_openData','tokenSocrata.R'))

apiURL <- "https://data.brla.gov/resource/5rji-ddnu.csv?$where=offense_date between '2017-01-10' and '2018-01-10'"
dt <- as_tibble(read.socrata(apiURL, app_token = token[['app']]))

dt <- dt %>% count(offense_date) %>% 
  mutate(offense_date = lubridate::as_date(offense_date))
write_rds(dt, here::here('lectures', 'lesson15_regression', 'data', 'crimes.rds'))
