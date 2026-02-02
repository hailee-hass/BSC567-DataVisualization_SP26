#Handout 6 - 28 Jan
## Still working in dplyr, but looking at the 'mutate()' function
library(dplyr)
names(flights)
#original flights dataset 336776 obs of 19 var

flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"),
                      distance,
                      air_time) #336776 obs of 7 variables (i.e., removed everything except y/m/d, delays, distance, and air time)

flights_sml

mutate(flights_sml,
       gaine= arr_delay - dep_delay, 
       speed= distance / air_time * 60) #adds gaine and speed columns to the end of the dataframe

mutate(flights_sml, 
       gain= arr_delay - dep_delay, 
       hours= air_time / 60, 
       gain_per_hour = gain/ hours) #using recently created columns in the same line of code in which you create them

transmute(flights, 
          gain= arr_delay - dep_delay,
          hours= air_time/ 60, 
          gain_per_hour = gain / hours) #create a small tibble; only 3 var

transmute(flights, 
          dep_time, 
          hour= dep_time %/% 100, 
          minute= dep_time %% 100) #time is in 24 hour, so if we divide by 100 as in line 31 we get a decimal to help determine hours.minutes

summarize(flights, delay= mean(dep_delay, na.rm= TRUE)) 
#collapses the data into a single row, but if you look at the code what does it actually tell you?
#the mean departure delay time with NAs removed!

by_day <-  group_by(flights, year, month, day) #just added a note on the tibble how the data is grouped; we have added internal structure

summarize(by_day, delay= mean(dep_delay, na.rm= TRUE)) #grouped by year and month, but day is still included

#### THE PIPE %>% ####
by_dest <-  group_by(flights, dest) #same dataframe, just grouped diff
by_dest #can only see how you grouped it if you call it here, not if you click on the data in the environment tab 

delay <- summarize(by_dest, 
                   count= n(), 
                   dist= mean(distance, na.rm= TRUE), 
                   delay= mean (arr_delay, na.rm= TRUE))
delay #105 obs of 4 var

delay <- filter(delay, count >20, dest!="HNL")
#delay dataframe now has 96  obs of 4 variables bc we have only included delays occuring more than 20 times at every dest EXCEPT HNL!

delay #96  obs of 4 var

### Plotting the data ###
library(ggplot2)

ggplot(data= delay, mapping= aes(x=dist, y= delay)) +
  geom_point(aes(size= count), alpha= 1/3) +
  geom_smooth(se= FALSE)

##########################
#doing this stuff faster and cleaner with the pipe
#honestly seems worse to use the pipe because it would be harder to back track if you made a mistake?
delays <- flights %>%
  group_by(dest) %>%
  summarize(count= n(), 
            dist= mean(distance, na.rm= TRUE), 
            delay= mean(arr_delay, na.rm = TRUE)
            ) %>% filter(count >20, dest!="HNL")

### Using older version of the pipe that is base R |>

#this is what happens if you DON'T use na.rm.. contagious NAs = BAD BAD BAD
flights %>%
  group_by(year, month, day) %>%
  summarize(mean= mean(dep_delay))

#Try this instead
flights %>%
  group_by(year, month, day) %>%
  summarize(mean= mean(dep_delay, na.rm= TRUE)) # GOOD GOOD GOOD
#NAs represent cancelled flights, so let's handle it

not_canceled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay)) #327346 obs of 19 var; removing NAs

not_canceled %>%
  group_by(year, month, day) %>%
  summarize(mean= mean(dep_delay)) #grouping by y/m/d

#Checking the NA values
delays <-  not_canceled %>%
  group_by(tailnum) %>%
  summarize(
    delay= mean(arr_delay)) #4037 obs of 2 var

ggplot(data= delays, mapping= aes(x= delay)) +
  geom_freqpoly(binwidth= 10) #the longest delays are less than 100 minutes

delays <-  not_canceled %>% 
  group_by(tailnum) %>%
  summarize(
    delay= mean(arr_delay, na.rm= TRUE), 
    n=n()
  ) #sorting by tail number in alphabetical order

delays #view the new grouping/orgnaization of this tibble

ggplot(data= delays, mapping = aes(x=n, y=delay)) +
  geom_point(alpha= 1/10)

not_canceled %>%
  group_by(year, month, day) %>%
  summarise(
    avg_delay = mean(arr_delay), 
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )#avg delay time when greater than 0 for all non-canceled flights

not_canceled %>%  group_by(dest) %>%
  summarise(distance_sd = sd(distance)) %>%
  arrange(desc(distance_sd)) #SD distance in descending order for non-canceled flights

not_canceled %>% group_by(year, month, day) %>%
  summarise(
    first= min(dep_time), 
    last=max(dep_time)
  ) #early to latest flights departure times sorted by y/m/m

not_canceled %>%
  group_by(dest) %>%
  summarise(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers)) #unique airlines (AKA carriers) in descending alphabetical order

not_canceled %>%
  count(dest) #num of flights going to each destination that weren't canceled

not_canceled %>%
  count(tailnum, wt= distance) #the distance each unique tailnum traveled

not_canceled %>% 
  group_by(year, month, day) %>%
  summarise(n_early = sum(dep_time <500)) #number of flights that left early in the morning, not departed early

not_canceled %>%
  group_by(year, month, day) %>%
  summarise(hour_prop = mean(arr_delay>60)) #all arrival delays greater than 1 hour organized by y/m/d


#Grouping multiple variables to progressively collapse a dataframe
daily <- group_by(flights, year, month, day)
(per_day <- summarise(daily, flights=n())) #number of daily flights
  
(per_month <-  summarise(per_day, flights= sum(flights))) #number of monthly flights
  
(per_year <- summarise(per_month,flights= sum(flights)))  #total flights in 2013
  

#Remove a grouping... must be careful with this when calculating aggregate values!
daily %>% 
  ungroup() %>% summarise(flights= n())

#Using the grouping functions with others in dplyr
popular_dests <-  flights %>%
  group_by(dest) %>%
  filter(n()>500) #destinations with >500 visits in 2013

popular_dests

popular_dests %>%
  filter(arr_delay >0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay) #provides a proportional delay, but proportional to what?

###### End code ######