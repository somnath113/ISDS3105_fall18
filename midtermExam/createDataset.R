library(tidyverse)
library(lubridate)
library(chron)
dt <- read_csv('midtermExam/Baton_Rouge_Crime_Incidents.csv')
names(dt) <- names(dt) %>% tolower() %>% gsub(' ','', .)
select(dt, filenumber, offensedate, offensetime, crime, committed, zip,  district, zone, subzone) %>% 
  mutate_all(tolower) -> dt
dt %>% filter(nchar(offensetime)==4) %>% 
  mutate(offensedate = mdy(offensedate)) %>% 
  filter(between(offensedate, ymd('2015-01-01'), ymd('2017-12-31'))) %>% 
  mutate(offensetime = paste0(str_sub(offensetime,1,2), ':', str_sub(offensetime,3,4), ':00')) -> dt1
dt1 <- filter(dt1, !is.na(offensetime))
# dt1 %>% mutate(daytime = cut(times(offensetime), breaks = times(c('04:30:00', '12:00:00', '17:00:00', 
#                            '22:00:00', '04:29:59')), labels = c('id', 'morning', 'afternoon', 'evening')))


dt1$offensetime_discrete <- cut(times(dt1$offensetime), breaks = times(c('22:00:00', '04:30:00', '12:00:00', '17:00:00', 
                                                                         '04:29:59')), labels = c('night', 'morning', 'afternoon', 'evening'))
dt1$offensetime_discrete[is.na(dt1$offensetime_discrete)] <- 'night'
dt <- dt1

lkt <- data_frame(crime = unique(dt$crime), crimeId = 1:15)
dt$crimeId <- match(dt$crime, lkt$crime)
dt$crime <- NULL
dt <- dt %>% mutate(week = week(offensedate))
dt <- dt %>% mutate(year = as.integer(year(offensedate)), month = as.integer(month(offensedate)), day = as.integer(day(offensedate)))
#dt <- dt %>% mutate_at(vars(year, week, month, day), factor)
dt <- dt %>% mutate(zip = case_when(nchar(zip) == 5 ~ zip, T ~ as.character(NA))) 
dt$year[70900] <- NA
max(dt$year)
save(list = c('lkt', 'dt'), file = 'midtermExam/dataset.RData')
load('midtermExam/dataset.RData')













