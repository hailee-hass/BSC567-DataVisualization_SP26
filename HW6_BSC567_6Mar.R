#HW6 due March 6 @ 11:59 pm
#Instructions:
    #1. Filter flights to only those flights on planes that have flown at least 100 flights
        #Will need to filter(), group_by(), and semi_join()
        #Watch for planes with no tail number

library(tidyverse)
library(nycflights13)

flights <- flights

unique(flights$tailnum) #seeing how many unique tailnum

#need to turn implicit NA to explicit NS for tailnum
tnflights <- flights %>%
  filter(!is.na(tailnum)) #flights with tail numbers

unique((tnflights$tailnum))

freqflights <- tnflights %>% 
  group_by(tailnum) %>%
  summarise(n=n()) %>%
  filter(n> 100)

filtered_flights <- tnflights %>%
  semi_join(freqflights, by= "tailnum") 

#AI STATEMENT: I didn't use any form of AI to complete this homework. 
###### End flights HW ######
#Part 3 of HW6

#Data: I plan to use my own data from a research project on IFAT forms

#Wrangle: This data needs some tidying if I remember correctly
    # Perhaps NAs removed, some mutate() and filter() work. 

#Plot types:
geom_bar()
geom_violin()
geom_point()
geom_boxplot()
heatmap()

#I plan to tidy my data first, perform some exploratory data analysis, and then make some plots. 
#I will be adding more data to this data set soon. 

###### End code ######