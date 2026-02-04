#Handout 8 - 4 Feb 2026
#Exploratory data analysis, cont.

#Load libraries
library(tidyverse)
library(ggplot2)

ggplot(data= mpg, mapping= aes(x= class, y= hwy)) + geom_boxplot() #class being ordered alph. by default

#let's make it by value instead
ggplot(data= mpg) + 
  geom_boxplot(
    mapping=aes(
      x= reorder(class, hwy, FUN= median), 
      y= hwy)) #this is much easier to read

ggplot(data= mpg) + 
  geom_boxplot(
    mapping=aes(
      x= reorder(class, cty, FUN= median), 
      y= cty)) #trying by city

ggplot(data= mpg) + 
  geom_boxplot(
    mapping=aes(
      x= reorder(class, hwy, FUN= median), 
      y= hwy)) + coord_flip() #flipping coordinates

#Relationships between two CATEGORICAL variables with geom_count
ggplot(data = diamonds) + 
  geom_count(mapping = aes(x=cut, y=color)) 

diamonds %>% 
  count(color, cut) %>%
  ggplot(mapping= aes(x=color, y= cut)) + 
  geom_tile(mapping= aes(fill= n)) #creates a tile/heat map thing

#Relationships between two CONTINUOUS variables
ggplot(data= diamonds) + 
  geom_point(mapping= aes(x= carat, y= price))

ggplot(data= diamonds) + 
  geom_point(mapping= aes(x= carat, y= price), 
             alpha= 1/100)

ggplot(data= diamonds) +
  geom_bin2d(mapping = aes(x= carat, y= price))

library(hexbin)

ggplot(data= diamonds) + 
  geom_hex(mapping= aes(x= carat, y= price))

ggplot(diamonds, mapping = aes(x= carat, y= price)) + 
  geom_boxplot(mapping = aes(group= 
                               cut_width(carat, 0.25)))

ggplot(diamonds, mapping = aes(x= carat, y= price)) + 
  geom_boxplot(mapping = aes(group= 
                               cut_width(carat, 0.1)), varwidth = TRUE)

ggplot(data = diamonds, mapping = aes(x= carat, y= price)) +
  geom_boxplot(mapping= aes(group=
                              cut_number(carat, 20)))

## Eruptions data ##
ggplot(data= faithful) +
  geom_point(mapping = aes(x= eruptions, y= waiting))

names(faithful)

### Modeling ###
mod <- lm(log(price) ~ log(carat), data = diamonds)

library(modelr)

diamonds2 <-  diamonds %>% 
  add_residuals(mod) %>%
  mutate(resid= exp(resid))

ggplot(data= diamonds2) + 
  geom_point(mapping = aes(x= carat, y= resid))

ggplot(data= diamonds2) + 
  geom_boxplot(mapping= aes(x=cut, y=resid))

### Short an long form coding with ggplot ###
#long form
ggplot(data= faithful, mapping= aes(x= eruptions)) +
  geom_freqpoly(binwidth= 0.25)

#short form
ggplot(faithful, aes(eruptions)) +
  geom_freqpoly(binwidth= 0.25)

### Short form code with the pipe ###
diamonds %>% count(cut, clarity) %>%
  ggplot(aes(clarity, cut, fill= n)) +
  geom_tile()

########## End code ##########