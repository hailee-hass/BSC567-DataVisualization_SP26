# Handout 23 - 6 April 2026
# Intro to maps

devtools::install_github("kjhealy/socviz")

library(socviz)
library(tidyverse)
election

election %>% select(state, total_vote, r_points, pct_trump, party, census) %>%
  sample_n(5)

p0 <- ggplot(data= subset(election, st %nin% "DC"), 
             mapping= aes(x= r_points, y= reorder(state, r_points), 
                          color= party))
p0 #fig with no points by has axes; overlapped

p1 <- p0 + geom_vline(xintercept = 0, color= "grey30") + 
  geom_point(size= 2)
p1 #added data points and a separator line at 0
party_colors <- c("#2E74C0", "#CB454A")

p2 <- p1 + scale_color_manual(values= party_colors)
p2 #changed colors

p3 <- p2 + scale_x_continuous(breaks = c(-30, -20, -10, 0, 10, 20, 30, 40), 
                              labels= c("30\n (Clinton)", "20", "10", "0", "10", 
                                        "20", "30", "40\n (Trump)"))
p3 #changed x-axis labels

p3 + facet_wrap(~ census, ncol= 1, scales = "free_y") +
  guides(color= FALSE) + labs(x= "Point Margin", y= "") +
  theme(axis.text= element_text(size= 8)) #separates into regions

# Making a map
us_states <-  map_data("state") #15537 obs of 6 var; many because they are the edges of polygon for the map

p <- ggplot(data= us_states, mapping= aes(x= long, y= lat, group= group, fill= region))
p #blank plot with axes for lat/long

p + geom_polygon(color= "grey90", size= 0.1) + guides(fill= FALSE) + theme_light()

# More about maps
library(mapproj)

p + geom_polygon(color= "grey90", size= 0.1) + 
  coord_map(projection= "albers", lat0= 39 ,lat1= 45) + 
  guides(fill= FALSE) #changed axis angles

election$region <- tolower(election$state) #tolower is changing characters to vectors (?)
us_states_elec <- left_join(us_states, election)

head(us_states_elec)
glimpse(us_states_elec)

p <- ggplot(data= us_states_elec, aes(x= long, y= lat, 
                                      group= group, fill= party))

p + geom_polygon(color= "grey90", size= 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)

library(ggthemes)
p0 <- ggplot(data = us_states_elec, mapping = aes(x = long,
                                                  y = lat, group = group, fill = party))

p1 <- p0 + geom_polygon(color = "grey90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p1

p2 <- p1 + scale_fill_manual(values = party_colors) +
  labs(title = "Election Results 2016", fill = NULL)
p2
p2 + theme_map()

p0 <- ggplot(data = us_states_elec, mapping = aes(x = long,
                                                 y = lat, group = group, fill = pct_trump))
p1 <- p0 + geom_polygon(color = "grey90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)

p1 + labs(title = "Trump vote") + theme_map() + labs(fill =
                                                       "Percent")
#% of people in each state that voted for Trump
p2 <- p1 + scale_fill_gradient(low = "white", high =
                                 "#CB454A") + labs(title = "Trump vote")
p2 + theme_map() + labs(fill = "Percent") #changing color

p0 <- ggplot(data = us_states_elec, mapping = aes(x = long,
                                                    y = lat, group = group, fill = d_points))
p1 <- p0 + geom_polygon(color = "grey90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p2 <- p1 + scale_fill_gradient2() + labs(title = "Winning
margin")
p2 + theme_map() + labs(fill = "Percent") #a bt too light... 

p3 <- p1 + scale_fill_gradient2(low = "red", mid =
                                  scales::muted("purple"), high = "blue", breaks = c(-25, 0,
                                                                                     25, 50, 75)) +
  labs(title = "Winning margin")
p3 #added a  mid-point color for "purple" states
p3 + theme_map() + labs(fill = "Percent") #removing background and axis to make it prettier

#Removing DC and seeing effect on centering the gradient a bit better
p0 <- ggplot(data = subset(us_states_elec, region %nin%
                             "district of columbia"), aes(x = long, y = lat, group =
                                                            group, fill = d_points))

p1 <- p0 + geom_polygon(color = "grey90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p1
p2 <- p1 + scale_fill_gradient2(low = "red", mid =
                                  scales::muted("purple"), high = "blue", breaks = c(-25, 0,
                                                                                     25, 50, 75)) +
  labs(title = "Winning margin")
p2
p2 + theme_map() + labs(fill = "Percent") #DC has a decent impact on the gradient here, especially in the west

#Plotting county-level data
county_map %>% sample_n(5)
nrow(county_map) #191382 rows

county_data %>%
  select(id, name, state, pop_dens) %>%
  sample_n(5)

county_full <- left_join(county_map, county_data, by= "id") #join data

p <- ggplot(data = county_full, mapping = aes(x = long, y =
                                                lat, fill = pop_dens, group = group))

p1 <- p + geom_polygon(color = "gray90", size = 0.05) +
  coord_equal()
p1 #super cool pop density by county for all of US

p2 <- p1 + scale_fill_brewer(palette = "Blues", labels =
                               c("0-10", "10-50", "50-100", "100-500", "500-1,000",
                                 "1,000-5,000", ">5,000"))
p2 #change colors
p2 + labs(fill = "Population per\nsquare mile") +
  theme_map() + guides(fill = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom")
#move legend and bin population density

###### End Code ######