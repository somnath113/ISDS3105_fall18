library(rvest)
library(tidyverse)

urls <- paste0('https://www.usclimatedata.com/climate/baton-rouge/louisiana/united-states/usla0033/', c(2017:2018), '/') %>% 
  map(paste0, c(1:12)) %>% unlist()
scraper <- function(url) {
  message(url)
  read_html(url) %>% 
    html_node('#history_data') %>% 
    html_node('.daily_climate_table') %>% 
    html_table()
}

scraper <- possibly(scraper, 'NA')

climateDt <- map(.x = urls, scraper)
clDt <- climateDt %>% map(~ mutate_all(.x, funs(as.character))) %>% bind_rows()
clDt <- clDt %>% mutate(Day = lubridate::dmy(Day)) %>% as_tibble()

clDt <- clDt %>% mutate_if(funs(!lubridate::is.Date(.)), funs(as.numeric))


clDt <- clDt %>%  rename(TempHigh =  `High(°F)`, TempLow = `Low(°F)`, Precip = `Precip.(inch)`)
write_rds(clDt, here::here('lectures', 'lesson15_regression', 'data', 'temperatures.rds'))



