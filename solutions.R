options(warn = -1)


tbl(con, 'hotel') %>% distinct(hotelType)
tbl(con, 'hotel') %>% arrange(desc(hotelRooms)) %>% 

tbl(con, 'hotel') %>% left_join(tbl(con, 'review')) %>% count

tbl(con, 'hotel') %>% inner_join(tbl(con, 'review'), by = c('hotelId')) %>% 
  group_by(hotelId, hotelName) %>% summarise(tot = n()) -> hh
count(ungroup(hh))
arrange(hh, tot)
hh1 <- left_join(tbl(con, 'hotel'), hh, by = c('hotelId', 'hotelName')) %>% select(hotelId, hotelName, tot)
hh1 %>% mutate(tot = if_else(is.na(tot), 0, tot))
