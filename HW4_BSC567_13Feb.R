### Homework 4 - Week 5 ###
#Due: Fri. Feb. 13 @ 11:59 pm

#Instructions: 
  #1. compare geom_violin() with a faceted geom_histogram() using price and cut as continuous (y), and categorical (x), respectively
  #2. Visualize dist. of carat partitioned by price on x-axis
  #3. Install lvplot; use geom_lv() to show dist. of price VS cut. 
    # What do you learn? How do you interpret plots? Add impressions using annotations

library(ggplot2)
library(tidyverse)

ggplot(data= diamonds) + 
  geom_point(mapping= aes(x= carat, y= price)) #First checking xy scatterplot to see relationship

### Homework 4 - Week 5 ###
#Due: Fri. Feb. 13 @ 11:59 pm
#Instructions: 
    #1. compare geom_violin() with a faceted geom_histogram() using price and cut as continuous (y), and categorical (x), respectively
    #2. Visualize dist. of carat partitioned by price on x-axis
    #3. Install lvplot; use geom_lv() to show dist. of price VS cut. 
        # What do you learn? How do you interpret plots? Add impressions using annotations

library(ggplot2)
library(tidyverse)

#1. compare geom_violin() with a faceted geom_histogram() using price and cut as continuous (y), and categorical (x), respectively
    # With just violin plot
ggplot(diamonds, aes(x = cut, y = price, fill = cut)) +
  geom_violin() +
  labs(title = "Violin Plot of diamond price by cut", x = "Cut Quality", y = "Price (USD)")

    # Adding histogram facet
ggplot(diamonds, aes(x = price)) +
  geom_histogram(binwidth = 500, color = "salmon4", fill = "wheat3") +
  facet_wrap(~ cut, scales = "free_y", nrow = 5) +
  labs(title = "Diamond price by cut", x = "Price (USD)", y = "Frequency") +
  theme_minimal()
#Interpretation: Many diamonds are on the less expensive side, regardless of cut quality. This suggests there may be another factor impacting price aside from cut quality

#2. Visualize dist. of carat partitioned by price on x-axis
ggplot(data= diamonds) + 
  geom_point(mapping= aes(x= price, y= carat)) #may never want to do this because switching dependent and independent variables
#Interpretation: As carat increases, so does price; positive relationship

#3. Install lvplot; use geom_lv() to show dist. of price VS cut. 
    # What do you learn? How do you interpret plots? Add impressions using annotations

#install lvplot
library(lvplot)

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_lv()
# Interpretation: there are many fair diamonds ar a low price compared to fewer diamonds in the premium and ideal categories, which are more expensive. 

#I learned that there are many ways to display the same data, and that lvplot uses 
    # different set of statistics to create plots and visualize the data

###### End code ######