# Handout 4 - 21 Jan 2026

library(tidyverse)
ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy)) +
  facet_wrap(~class, nrow= 2) #creates a nice multi-graph visual showing highway mileage by displacement for each category of vehicle

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy)) +
  facet_grid(drv~class) #multi graph by drive train (4WD, Front, Rear)

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy)) +
  facet_grid(.~class) #column view; aesthetically pleasing

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy)) +
  facet_wrap(~ drv, nrow= 3) #row view, don't like as much but good

ggplot(data = mpg) +
  geom_point(mapping = aes(x= displ, y= hwy)) +
  facet_grid(drv ~.) #feels harder to compare data points as opposed to the code above. 

### Using different internal data set to try geom_smooth
ggplot(data = mpg) +
  geom_point(mapping= aes(x= displ, y= hwy))

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x= displ, y= hwy))
#provides a smooth line with CIs (?) rather than individual data points

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x= displ, y= hwy, linetype= drv))
#provides an individual line type for each drive

ggplot(data = mpg) +
  geom_smooth(mapping= aes(x= displ, y= hwy, group= drv)) 
#no legend when comparing to above graph

ggplot(data = mpg) +
  geom_point(mapping= aes(x= displ, y= hwy)) +
  geom_smooth(mapping = aes(x= displ, y= hwy))
#combines point and smooth. Good for showing trend and individual data points

#Avoiding duplication and applying various geoms to all of the data; AKA "global mapping"
ggplot(data = mpg, mapping= aes(x= displ, y= hwy)) +
  geom_smooth() +
  geom_point()
#Same graph as line 40 but shorter code

ggplot(data = mpg, mapping= aes(x= displ, y= hwy)) +
  geom_smooth() +
  geom_point(mapping= aes(color=class))

ggplot(data = mpg, mapping= aes(x= displ, y= hwy)) +
  geom_smooth(data= filter(mpg, class== "subcompact"), se= FALSE) +
  geom_point(mapping= aes(color=class))

### Diamonds Data set
diamonds= diamonds
str(diamonds)
names(diamonds)

ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut))

ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut, y= 
                          after_stat(prop), group=1))

ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut, fill= cut)) #Add colors to visually define cut

ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut, fill= clarity)) #stacked bar
    
ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut, fill= clarity), position= "fill") #way worse, don't like

ggplot(data= diamonds) +
  geom_bar(mapping= aes(x= cut, fill= clarity), position= "dodge") #shows a better distribution of clarity in various cut types

#Adjusting previous scatterplots to avoid overplotting (AKA overlapping data points that only show 1 point even though there may be a higher density existing at the same point)
ggplot(data=mpg) +
  geom_point(mapping= aes(x= displ, y= hwy), 
             position= "jitter") #jitter adds a small amount of random noise to the data 

#Flipping plot axes
ggplot(data= mpg, mapping=aes(x= class, y= hwy)) + 
  geom_boxplot()

ggplot(data= mpg, mapping= aes(x=class, y=hwy)) +
  geom_boxplot() +
  coord_flip()

