# Handout 5 - 26 Jan
# Class was cancelled, making up outside of class

seq(1, 10) # returns a sequence of numbers 1-10
y <- seq(1, 10, length.out = 5) #length.out function provides a specified number of outputs from the 1-10 sequence
y

library(tidyverse)
#install nycflights13
library(nycflights13)

view(flights) 
  #Opens a new frame/tab
  #This is a tibble; works better in tidyverse

flights <- flights #336,776 obs of 19 var

names(flights)
str(flights) #use glimpse for tibbles instead
glimpse(flights)
  #dbl = real numbers; doubles
  #int= integers
  #chr= character vectors (strings)
  #fctr= factors (categorical variables)
  #dttm= date-times
  #lgl= logical(TRUE/FALSE)
  #date= dates

filter(flights, month== 1, day== 1) #this action doesn't save a new dataframe
(jan1 <- filter(flights, month== 1, day== 1)) #this one does, bc a name is assigned
  #to save AND see it, wrap the whole thing in parentheses as above

filter(flights, month== 11 | month== 12)

nov_dec <- filter(flights, month %in% c(11, 12))

#Boolean operator glossary [for now]
  # | = "or"
  # == = equal
  # ! = not equal
  # >, >=, <=

filter(flights, !(arr_delay > 120 | dep_delay > 120)) #excluding anything not equal to specified values
filter(flights, arr_delay <= 120, dep_delay <= 120) #including anything equal or lesser than specified values

#### practicing with NAs ####
z <-  NA
is.na(z)

#IMPORTANT: filter() only includes TRUE values; if you want to include NAs, you have to be explicit
df <- tibble(x= c(1, NA, 3))
filter(df, is.na(x)|x>1)

arrange(flights, sched_dep_time, sched_arr_time)
arrange(flights, desc(arr_delay))

ymd <- select(flights, year, month, day) #select data by year, month, day; new data frame with ONLY those 3 var
yd <- select(flights, year:day) #select data based on year and day; appears to be same as line 57?; new dataframe with ONLY those 3 var
negyd <- select(flights, -(year:day)) #removes year. month, day from the larger data frame

?select

### Trying to use some more select functions (starts_with, num_range, etc.) but having trouble
num_range(flights, month== 3|4)

rename(flights, tail_num = tailnum) #tail_num is old name
select(flights, time_hour, air_time, everything())
  #everything() moves the entire column to the beginning of the dataframe... would have been veyr useful in my MS coding!

#group_by and tibble are verbs we will cover later

######### End code ######### 
