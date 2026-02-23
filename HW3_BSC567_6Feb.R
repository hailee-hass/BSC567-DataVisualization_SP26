### Homework 3 ###
#Due: Fri. Feb. 6 @ 11:59 pm
#Instructions: 
    #1. Using mutate(), compare air_time with arr_time - dep_time. 
        #What do you expect? What do you see? How would you fix it?
        #Describe the code using ## notations. Do not have to think of everything or actually fix it

    #2. Write my own command using the pipe, incorporating some of the dplyr functions learned in handout 6
        #Must include summarize() and end with and integrated call to ggplot (i.e., linked with the pipe) to create a fig 

#Load libraries
library(tidyverse) #dplyr is integrated in this package
library(ggplot2)
library(nycflights13)

names(flights)
glimpse(flights) #use this for tibbles instead of str

### Comparing air_time with (arr_time - dep_delay)
    ## I expect that arrival times will be later as departure delays increase
mutate(flights,
       airt= air_time, 
       totaltime= arr_time - dep_time, 
       difftime= airt - totaltime)

hw3 <- transmute(flights,
          airt= air_time, 
          totaltime= arr_time - dep_time, 
          groundtime= abs((airt - totaltime)/60), 
          na.rm= TRUE) #creating a smaller tibble with var of interest. 336776 obs of 4 var. Added na.rm column?

## arr_time - dep_time= total duration
## air_time= time in air    
## subtracting air_time from totaltime= ground time

# NEED TO REMOVE NAs

summarize(hw3, delay= mean(groundtime, na.rm= TRUE)) #mean groundtime with NAs removed= 2.67 hours


## Originally I see negative numbers (which is the time) in 24 hour format.
    # I then changed the time to hour/min format and asked the code to return the absolute value
    # I tried to create a plot using this data but got the following error:
      #Error in grid.Call.graphics(C_upviewport, as.integer(n)) : 
      #cannot pop the top-level viewport ('grid' and 'graphics' output mixed?)
      #In addition: Warning message:
      #  Removed 9430 rows containing missing values or values outside the scale range (`geom_point()`). 
    #Removed NAs from new tibble using summarize() line 38

flights %>%
  mutate(
    dep_mins = (dep_time %/% 100) * 60 + (dep_time %% 100), #mutate to hours, min
    arr_mins = (arr_time %/% 100) * 60 + (arr_time %% 100),
    elapsed_time = arr_mins - dep_mins #total elapsed time
  ) %>%
  transmute(
    air_time,
    elapsed_time,
    diff = elapsed_time - air_time
  ) %>%
  filter(!is.na(diff)) %>% #saying different than NA (i.e., anything that's not an NA)
  summarize(
    avg_diff = mean(diff),
    median_diff = median(diff),
    sd_diff = sd(diff)
  ) %>%
  ggplot(aes(x = avg_diff, y = median_diff)) +
  geom_point(size = 4) + theme_classic()+
  labs(
    title = "Difference between clock air time",
    x = "Average Difference (min)",
    y = "Median Difference (min)"
  )

# HW3 part 2
flight_times %>%
  filter(!is.na(diff)) %>%
  summarize(
    avg_diff = mean(diff),
    median_diff = median(diff)
  ) %>%
  ggplot(aes(x = avg_diff, y = median_diff)) +
  geom_point(size = 4) + theme_classic() +
  labs(
    title = "Difference between clock and air time",
    x = "Average Difference (min)",
    y = "Median Difference (min)"
  )

# I don't love the way this plot looks and would try to re-plot this with more data points because this doesn't really tell me anything very important
# I would like to plot the diff between air time and elapsed trip time to see if longer trips spend more time in the air flying or on the ground


#### Extra code that didn't really work ####

'ground <- summarize(flights, 
                   count= n(), 
                   airt= air_time, 
                   totaltime= arr_time - dep_time, 
                   groundtime= abs((airt - totaltime)/60), 
                   na.rm= TRUE)' #This didn't work... Hmmm

'ggplot(data = hw3, mapping= aes(x= groundtime, y= totaltime)) +
  geom_point()' #need to remove NAs from data

'groundtime <- flights %>%
  group_by(groundtime) %>%
  summarize(count= n(), 
            airt= mean(air_time, na.rm = TRUE), 
            totaltime= mean(arr_time - dep_time, na.rm= TRUE),
  ) %>% filter(count >0)'
########## End code for HW3 ##########