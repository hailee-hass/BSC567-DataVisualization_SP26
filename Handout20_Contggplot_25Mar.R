#Handout 20 - March 25, 2026
# Continuing graphics in ggplot2

library(tidyverse)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= drv)) +
  scale_colour_brewer(palette = "Set2")

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= drv, shape= drv)) +
  scale_color_brewer(palette = "Set1")

presidential %>%
  mutate(id= 33 + row_number()) %>%
  ggplot(aes(start, id, colour= party)) +
  geom_point() +
  geom_segment(aes(xend= end, yend= id)) +
  scale_colour_manual(values= c(Republican= "red", Democratic= "blue")) #in Handout 19 I added quotes around the party names and that's why it didn't work

#Changing colors for continuous data
library(viridis)
 df <-  tibble(
   x= rnorm(10000), 
   y= rnorm(10000))

 ggplot(df, aes(x, y)) + 
   geom_hex() +
   coord_fixed()

 
 ggplot(df, aes(x, y)) + 
   geom_hex() +
   viridis::scale_fill_viridis() + #gives more contrast in the colors
   coord_fixed()
 
 #Zooming in on a section of plot
 ggplot(mpg, mapping= aes(displ, hwy)) + 
   geom_point(aes(color= class)) +
   geom_smooth() +
   coord_cartesian(xlim= c(5, 7), ylim= c(10, 30))

 mpg %>%
   filter(displ >= 5, displ <= 7, hwy >= 10, hwy <= 30) %>%
   ggplot(aes(displ, hwy)) + 
   geom_point(aes(color= class)) +
   geom_smooth() #filtering out data based on engine displacement and highway mileage
 
 suv <- mpg %>% filter(class== "suv") #62 obs of 11 var
compact <-  mpg %>% filter(class== "compact") #47 obs of 11 var

ggplot(suv, aes(displ, hwy, colour= drv)) +
  geom_point()

ggplot(compact, aes(displ, hwy, colour= drv)) + 
  geom_point() #this and the plot on line 55 are difficult to compare due to scale differences 

x_scale <- scale_x_continuous(limits= range(mpg$displ))
y_scale <- scale_y_continuous(limits= range(mpg$hwy))
col_scale <- scale_color_discrete(limits= unique(mpg$drv))
unique(mpg$drv)

ggplot(suv, aes(displ, hwy, color= drv)) +
  geom_point() +
  x_scale +
  y_scale +
  col_scale

ggplot(compact, aes(displ, hwy, color= drv)) +
  geom_point() +
  x_scale +
  y_scale +
  col_scale

df <- tibble(
  trt= factor(c(1, 1, 2, 2)), 
  resp= c(1, 5, 3, 4), 
  group= factor(c(1, 2, 1, 2)), 
  upper= c(1.1, 5.3, 3.3, 4.2), 
  lower= c(0.8, 4.6, 2.4, 3.6)
)

p <- ggplot(df, aes(trt, resp, color= group))
p + geom_linerange(aes(ymin= lower, ymax= upper)) #adding error bar

p + geom_pointrange(aes(ymin= lower, ymax= upper)) #adding points in the error bars

p + geom_crossbar(aes(ymin= lower, ymax= upper), width = 0.2) #box plot; fatten widens the bar and box but is depreciated

p + geom_line(aes(group= group)) + 
  geom_errorbar(aes(ymin= lower, ymax= upper), width= 0.2)

p <- ggplot(df, aes(trt, resp, fill= group))
p + geom_col(position = "dodge") + 
  geom_errorbar(aes(ymin= lower, ymax= upper), position= "dodge", width= 0.25) #don't like that error bar is not in the middle

dodge_size <- position_dodge(width= 0.9)
p + geom_col(position= dodge_size) +
  geom_errorbar(aes(ymin= lower, ymax= upper), position= dodge_size, width= 0.25) #this put the error bars in the middle and made the widths the same

# Calculating position of error bars based on whatever measure of variance I decide to use (SD, SE, 95% CI, etc.)
Iris_summary <-  iris %>%
  group_by(Species) %>%
  summarise(mean_PL= mean(Petal.Length), 
            sd_PL= sd(Petal.Length), 
            n_PL= n(), 
            SE_PL= sd(Petal.Length)/sqrt(n()))
IrisPlot <- ggplot(Iris_summary, aes(Species, mean_PL)) + 
  geom_col() +
  geom_errorbar(aes(ymin= mean_PL - sd_PL, ymax= mean_PL + sd_PL), width= 0.2)

IrisPlot + labs(y= "Petal length (cm) +- SD", x= "Species") + theme_classic()

###### End code ###### 