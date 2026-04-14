#Handout 19 - March 23, 2026
# Graphics in ggplot2

library(dplyr)
library(ggplot2)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour= class)) +
  geom_smooth(se= FALSE) +
  labs(
    x= "Engine displacement (L)",
    y= "Highway fuel economy (mpg)",
    colour= "Car type"
  )

df <- tibble(
  x= runif(10), 
  y= runif(10)
)

ggplot(df, aes(x, y)) + 
  geom_point() + 
  labs(
    x= quote(sum(x[i]^2, i== 1, n)),
    y= quote(alpha + beta +frac(delta, theta))
  )

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy))== 1)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour= class)) +
  geom_text(aes(label= model), data= best_in_class) #text overlaps, not great visually

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour= class)) +
  geom_label(aes(label= model), data= best_in_class, 
            nudge_y= 2, alpha= 0.5) #makes titles have a black box around them

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour= class)) +
  geom_text(aes(label= model), data= best_in_class, 
             nudge_y= 2, alpha= 0.5) #makes titles transparent

library(ggrepel)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour= class)) +
  geom_point(aes(size= 3, shape= 1, data= best_in_class) + 
               ggrepel::geom_label_repel(aes(label= model), data= best_in_class))

class_avg <-  mpg %>% group_by(class) %>%
  summarise(
    displ = median(displ), 
    hwy= median(hwy)
  )

ggplot(mpg, aes(displ, hwy, colour= class)) +
  ggrepel::geom_label_repel(aes(label= class),
                            data= class_avg, 
                            size= 6, 
                            label.size = 0, 
                            segment.color= NA) +
  geom_point() + theme(legend.position = "none")

# Adding/Removing various lines to see what they do 
ggplot(mpg, aes(displ, hwy, colour= class)) +
  ggrepel::geom_label_repel(aes(label= class),
                            data= class_avg, 
                            size= 3, 
                            label.size = 10, #this doesn't change anything?
                            segment.color= NA) +
  geom_point() + theme(legend.position = "none") #definitely want to remove legend

ggplot(mpg, aes(displ, hwy, colour= class)) +
  ggrepel::geom_label_repel(aes(label= class),
                            data= class_avg, 
                            size= 6, 
                            label.size = 0, 
                            segment.color= NA) +
  geom_point() +
  theme(legend.position = "none")

#overriding some defaults
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  scale_y_continuous(breaks= seq(15, 40, by= 5))

presidential %>% 
  mutate(id= 33 + row_number()) %>% 
  ggplot(aes(start, id)) +
  geom_point() +
  geom_segment(aes(xend= end, yend= id)) + #id= presidential number
  scale_x_date(NULL, breaks= presidential$start, 
               date_labels = "'%y")

#Having difficulty changing the color by party: + scale_color_manual(values= c("Republican" = "red", "Democratic"= "blue"))

#Changing legend position! 
base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour= class))

base + theme(legend.position = "left")
base + theme(legend.position = "right") #default
base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
base + theme(legend.position = "none") #suppress completely

#Changing number of rows in a legend using guides
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour= class)) + 
  geom_smooth(se= FALSE) +
  theme(legend.position = "bottom") +
  guides(colour= guide_legend(nrow= 1, override.aes = list(size=4)))

ggplot(diamonds, aes(carat, price)) +
  geom_bin2d()

ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d()

ggplot(diamonds, aes(carat, price)) + 
  geom_bin2d() +
  scale_x_log10() +
  scale_y_log10() #would not say that carat is logged but rather the axis

###### End Code ######