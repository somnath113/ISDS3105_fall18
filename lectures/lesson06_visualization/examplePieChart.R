ggplot() +
  geom_col(data =  twitter_users, aes(x = '', y = millions, fill = factor(Year)), width =1) +
  coord_polar('y', 0)+
  scale_fill_discrete(name = 'Year') +
  ggtitle('A plot of twitter users')
