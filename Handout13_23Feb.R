#Handout 13 - 23 Feb
#data wrangling with dplyr

library(tidyverse)
library(nycflights13)

airlines
airports
planes  
weather
flights 

planes %>%
  count(tailnum) %>%
  filter(n>1) #two variables with this name, not unique

weather %>% 
  count(year, month, day, hour, origin) %>%
  filter(n>1) 

flights %>% 
  count(time_hour, flight) %>% 
  filter(n>1)

flights %>% 
  count(time_hour, tailnum) %>% 
  filter(n>1)

flights %>%
  mutate(rownum = row_number())

flights2 <- flights %>%
  select(year, time_hour, origin, dest, tailnum, carrier) #creating a narrower dataset

flights2

flights2 %>%
  left_join(airlines)

flights2 %>%
  left_join(weather %>% select(origin, time_hour, temp, wind_speed)) #temp and wind speed when plane departed

flights2 %>% left_join(planes %>% select(tailnum, type, engines, seats)) #size of plane that was flying

x <- tribble(
  ~key, ~val_x, 
  1, "x1",
  2, "x2", 
  3, "x3")

y <- tribble(
  ~key, ~val_y, 
  1, "y1",
  2, "y2", 
  3, "y3")

x %>% 
  inner_join(y)

x <- tribble(
  ~key, ~val_x, 
  1, "x1",
  2, "x2", 
  2, "x3", 
  1, "x4")

y <- tribble(
  ~key, ~val_y, 
  1, "y1",
  2, "y2")

left_join(x, y)

x <- tribble(
  ~key, ~val_x, 
  1, "x1",
  2, "x2", 
  2, "x3", 
  3, "x4")

y <- tribble(
  ~key, ~val_y, 
  1, "y1",
  2, "y2", 
  2, "y3", 
  3, "y4")

left_join(x, y)
