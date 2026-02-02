#Handout 7 - 2 Feb 2026
#Exploratory data analysis using ggplot2 and dplyr; using skills we have gained in the previous handouts

#Load libraries
library(tidyverse)
library(ggplot2)

#Exploratory Data Analysis seeks to look at the following questions
  #1. What type of variation exists WITHIN my variables?
  #2. What type of variation exists BETWEEN my variables?

#Dealing with variation WITHIN variables first
  #Start with visualizing the data; this will change depending on type of variables (categorical, continuous)
  #Categorical= factors or characters = BAR CHARTS

ggplot(data= diamonds) + 
  geom_bar(mapping= aes(x=cut)) #height of bars= count of diamonds

diamonds %>% count(cut) #categorical

ggplot(data=diamonds) + 
  geom_histogram(mapping = aes(x=carat), binwidth= 0.5) #continuous variable= carat

diamonds %>% 
  count(cut_width(carat, 0.5)) #we don't have a negative carat when the tibble is returned, it's the bin the data is being placed in
#cut_width determine the bin sizes 

smaller <-  diamonds %>%
  filter(carat <3)

ggplot(data= smaller, mapping= aes(x= carat)) + geom_histogram(binwidth = 0.1)

#overlaying more than one distribution using freq_poly
ggplot(data= smaller, mapping = aes(x= carat, color= cut)) +
  geom_freqpoly(binwidth= 0.1) #I like this graph

ggplot(data= diamonds) + 
  geom_histogram(mapping= aes(x = y), binwidth = 0.5) #scale is off when binwidth is too high. Skews the way we visualize the data!
    #the space in this graph wasn't empty, but the bins for the rare values were nearly invisible
    #y is one of the aspects of the diamonds dataset; ?diamonds will help with this

glimpse(diamonds)
names(diamonds)
summary(diamonds)

ggplot(data = diamonds) + 
  geom_histogram(mapping= aes(x=y), binwidth= 0.5) + 
  coord_cartesian(ylim=c(0, 50))

#Extracting outlier variables
unusual <-  diamonds %>%
  filter(y<3 | y>20) %>%
  arrange(y)

unusual #clearly some incorrect data here (x, y, z cannot be 0!)

#Dealing with these types of data 
diamonds2 <- diamonds %>%
  filter(between(y, 3, 20))

diamonds2 <-  diamonds %>%
  mutate(y= ifelse(y<3 | y>20, NA, y)) #replaced all improbable values with NA opposed to removing them and removing valuable data

ggplot(data= diamonds2, mapping= aes(x=x, y=y)) +
  geom_point() #odd diamond... 0 length (x)??? No. 

ggplot(data = diamonds, mapping= aes(x= price)) + 
  geom_freqpoly(mapping= aes(color= cut), 
                binwidth= 500)
ggplot(data = diamonds) + geom_bar(mapping= aes(x=cut)) #still not a great representation of the data, let's look at the density

ggplot(data= diamonds, 
       mapping = aes(x= price, y= after_stat(density))
       ) + geom_freqpoly(mapping = aes(color= cut), binwidth= 500)

ggplot(data= diamonds, mapping=aes(x=cut, y= price)) + 
  geom_boxplot()

?geom_boxplot

########## End code ##########