#function for the ggplot chart
timeLine <- function(data, title) {
  ggplot(data) +
    geom_line(aes(x = Month, y = AverageRoomRate)) +
    ggtitle(title)
}


#using split
pp <- performance %>% 
  split(.$hotel) 

pp <- pp[1:2] #subset to avoid long processing

pmap(list(data = pp, title = names(pp)), timeLine)


#using nest
pp <- performance %>% group_by(hotel) %>% nest()
pmap(list(data = pp$data, title = pp$hotel), timeLine)


ggplot(filter(performance, hotel == 'AmbassadorHotelTaipei')) +
  geom_line(aes(x = Month, y = AverageRoomRate)) +
  ggtitle(title)



pp <- performance %>% group_by(hotel) %>% nest()
pmap(list(data = pp$data, title = pp$hotel), timeLine)