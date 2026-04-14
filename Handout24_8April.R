#Handout 24 - 8 April 2026
# Intro to maps, part 2
# Must run the code from Handout 23 first, as "county_data" is from there. 

library(tidyverse)
library(ggthemes)
library(socviz)

#From handout 23 
#Plotting county-level data
county_map %>% sample_n(5)
nrow(county_map) #191382 rows

county_data %>%
  select(id, name, state, pop_dens) %>%
  sample_n(5)

county_full <- left_join(county_map, county_data, by= "id") #join data

gun_p <- ggplot(data= county_full, mapping= aes(x= long, y= lat, fill= su_gun6, group= group))

gun_p1 <- gun_p + geom_polygon(color= "grey30", linewidth= 0.05) + coord_equal()

orange_pal <- RColorBrewer::brewer.pal(n=6, name= "Oranges")
gun_p2 <- gun_p1 + scale_fill_manual(values= orange_pal)
gun_p2 + labs(title= "Gun-related Suicides, 1999-2015", fill= "Rate per 100,000 pop.") + 
  theme_map() + theme(legend.position = "bottom")

orange_rev <- rev(orange_pal)
pop_p <- ggplot(data = county_full, mapping = aes(x = long,
                                                  y = lat, fill = pop_dens6, group = group))
pop_p1 <- pop_p + geom_polygon(color = "grey30", size =
                                 0.05) + coord_equal()
pop_p2 <- pop_p1 + scale_fill_manual(values = orange_rev)
pop_p2 + labs(title = "Reverse-coded Population Density",
              fill = "People per square mile") +
  theme_map() + theme(legend.position = "bottom")

us_states <- map_data("state")
opiates$region <- tolower(opiates$state)
opiates_map <- left_join(us_states, opiates)

library(viridis)
p0 <- ggplot(data = subset(opiates_map, year > 1999),
             mapping = aes(x = long, y = lat, group = group, fill =
                             adjusted))
p1 <- p0 + geom_polygon(color = "gray90", size = 0.05) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)
p2 <- p1 + scale_fill_viridis_c(option = "plasma")
p2 + theme_map() + facet_wrap(~ year, ncol = 3) +
  theme(legend.position = "bottom", strip.background =
          element_blank()) +
  labs(fill = "Death rate per 100,000 population", title =
         "Opiate Related Deaths by State, 2000-2014")

#Are maps really the best way to show the data?
p <- ggplot(data= opiates, mapping= aes(x= year, y= adjusted, group= state))
p + geom_line(color= "grey70") #Leo says "ugo"

p0 <- ggplot(data = drop_na(opiates, division_name),
             mapping = aes(x = year, y = adjusted))
p1 <- p0 + geom_line(color = "gray70", mapping = aes(group
                                                     = state))
p2 <- p1 + geom_smooth(mapping = aes(group =
                                       division_name), se = FALSE)

library(ggrepel)
p3 <- p2 + geom_text_repel(data = subset(opiates, year
                                         ==max(year) & abbr !="DC"),
                           mapping = aes(x = year, y = adjusted, label = abbr),
                           size = 1.8, segment.color = NA, nudge_x = 30) +
  coord_cartesian(c(min(opiates$year),
                    max(opiates$year)))
p3 + labs(x = "", y = "Rate per 100,000 Population", title
          = "State-Level Opiate Death Rates by Census Division, 1999-
2014") +
  facet_wrap(~ reorder(division_name, -adjusted, na.rm =
                         TRUE), nrow = 3) + theme_classic() #this is better? to look at? IDK I like the map more
# I like the maps better, these plots just show an increase in opiate deaths by year but it's difficult to tell which state is which
#The negative before adjusted rearranged the plots in the panel

library(sf)
library(ozmaps)
oz_states <-  ozmaps::ozmap_states
oz_states

ggplot(oz_states) +
  geom_sf() +
  coord_sf()

oz_states <- ozmaps::ozmap_states %>% filter(NAME != "Other
Territories")

library(rmapshaper)
oz_votes <- rmapshaper::ms_simplify(ozmaps::abs_ced)

ggplot() +
  geom_sf(data = oz_states, mapping = aes(fill = NAME),
          show.legend = FALSE) +
  geom_sf(data = oz_votes, fill = NA) +
  coord_sf()

sydney_map <- ozmaps::abs_ced %>% filter(NAME %in% c(
  "Sydney", "Wentworth", "Warringah", "Kingsford Smith",
  "Grayndler", "Lowe",
  "North Sydney", "Barton", "Bradfield", "Banks",
  "Blaxland", "Reid",
  "Watson", "Fowler", "Werriwa", "Prospect", "Parramatta",
  "Bennelong",
  "Mackellar", "Greenway", "Mitchell", "Chifley", "McMahon"
))

ggplot(sydney_map) +
  geom_sf(aes(fill = NAME), show.legend = FALSE) +
  coord_sf(xlim = c(150.97, 151.3), ylim = c(-33.98, -
                                               33.79)) +
  geom_sf_label(aes(label = NAME), label.padding = unit(1,
                                                        "mm"))

oz_capitals <- tibble::tribble(
  ~city, ~lat, ~lon,
  "Sydney", -33.8688, 151.2093,
  "Melbourne", -37.8136, 144.9631,
  "Brisbane", -27.4698, 153.0251,
  "Adelaide", -34.9285, 138.6007,
  "Perth", -31.9505, 115.8605,
  "Hobart", -42.8821, 147.3272,
  "Canberra", -35.2809, 149.1300,
  "Darwin", -12.4634, 130.8456,
)

ggplot() +
  geom_sf(data = oz_votes) +
  geom_sf(data = oz_states, colour = "black", fill = NA) +
  geom_point(data = oz_capitals, mapping = aes(x = lon, y =
                                                 lat), color = "red") +
  coord_sf()

###### End Code ######