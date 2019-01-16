library(tidyverse)
load(here::here('taipeiHotel','data.rda'))


TA <- TA %>% select(-url, -img)
TA %>% count(hotel) %>% anti_join(performance)
TA %>% count(hotel) %>% anti_join(hualien)

performance <- bind_rows(mutate(performance, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          mutate(taichung, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          mutate(tauhsiumiao, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          mutate(other, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          mutate(kaohsiung, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          mutate(scenic, `Average Room Rate`=as.numeric(`Average Room Rate`)),
          hualien)
names(performance) <- gsub(' ', '', names(performance)) %>% gsub('\\.', '', .) %>% gsub('&', '', .)
performance <- as_tibble(performance)
performance$Month <- performance$Month %>% lubridate::ymd(truncated = 1)
toDel <- performance %>% count(hotel, location) %>% anti_join(TA)
performance <- performance %>% filter(!hotel %in% toDel$hotel) %>% select(-TotalRevenue, -Total)
performance <- performance %>% filter(location!='ScenicArea')
performance <- performance %>% filter(!(hotel == "EvergreenResortHotelJiaosi" & location == 'ScenicArea'))

TA <- TA %>% rename(BusinessService = `Business service (e.g., internet access)`, 
              SleepQuality = `Sleep Quality`,
              CheckIn=`Check in / front desk`) %>% rowid_to_column('reviewId') %>% mutate(reviewId = stringr::str_pad(reviewId, 8, pad = '0'))

stayDate <- TA %>% select(hotel, stayedDate)
hotel <- distinct(performance, hotel, location)

review <- TA %>% select(hotel, reviewId, title, userName, userLoc, userLiks, ratingDate, helpfulVotes, text, mobile, totalScore, Value, Location, Rooms, Cleanliness, Service, BusinessService, SleepQuality, CheckIn, stayedDate)
review <- review %>% rename(userLikes = userLiks)
reviewResponse <- TA %>% select(hotel, userName, title, response_body, ratingDate, reviewId)

con <- dplyr::src_mysql(
  host = "ba-isdsclass-programdev.lsu.edu",
  port = 3306,
  user = "dario",
  password = "darionomemory",
  dbname = "online_reviewsisds3105")
library(dbplyr)
colnames <- tbl(con, 'review') %>% collect() %>% names


make_script <- function(table_name, path) {
  paste("BULK INSERT", table_name,
"FROM", path,
"WITH(FORMAT = 'CSV', FIRSTROW = 1,FIELDTERMINATOR = ',',  ROWTERMINATOR = '\n', TABLOCK)")
}

script <- make_script('review', here::here('taipeiHotel/review.csv'))

copy_to(con, hotel, "hotel",
        temporary = FALSE, 
        overwrite = T)
      #  indexes = list(
      #    c("year", "month", "day"), 
      #    "carrier", 
      #    "tailnum",
      #    "dest"

tbl(con, 'review')

db_drop_table(con, 'review', force = F)





dbplyr::build_sql(script)
tbl(con, 'review')

map2(.x = as.list(colnames), .y = review, ~ build_sql(paste0("INSERT INTO online_reviewsisds3105.review (",.x, ") VALUES (", .y,")")))

paste0("INSERT INTO online_reviewsisds3105.review (",.x, ") VALUES (", .y,")"))


write_csv(review, here::here('taipeiHotel/', 'review.csv'))
write_csv(hotel, here::here('taipeiHotel/', 'hotel.csv'))
write_csv(performance, here::here('taipeiHotel/', 'performance.csv'))
