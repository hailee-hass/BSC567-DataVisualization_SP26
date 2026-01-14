# Handout 3 -  BSC567
# 14 Jan 2026
library(tidyverse)
mpg #view mpg, an internal dataset
names(mpg)
str(mpg)
plot(mpg) #again, not very helpful as there's multiple variables
mean(mpg$displ) #3.471795
mpg <- mpg #234 rows, 11 columns

view(mpg$drv) #drv is a character and the type of drive train

#Plot the data
ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy))

ggplot(data= mpg) #gives you a blank plot because there is no "mapping" function

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= cyl, y= hwy))

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy, color= class)) #changing the color of the data points based on vehicle class

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy, size= class, color= class)) #changing the size AND color based on vehicle class
#but how do I add an outline to each data point? Or change the color?

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy, alpha= class))

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy, shape= class))

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "blue")

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "lightcyan3")

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "palegreen4")

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "mistyrose")

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "black", shape= 0)

vignette("ggplot2-specs")
##################################3
view(mtcars)
mtcars <- mtcars
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point()

# Add aesthetic mappings
p + geom_point(aes(colour = factor(cyl)))
p + geom_point(aes(shape = factor(cyl)))
# A "bubblechart":
p + geom_point(aes(size = qsec))
######################################

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy, color= displ <5))

ggplot(data= mpg) + 
  geom_point(mapping= aes(x= displ, y= hwy), color= "blue")

#Learned how to...
# install packages
# call packages
# use aesthetic functions in ggplot

starwars #another built in dataframe
