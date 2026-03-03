#HW5 due Feb 27 @ 11:59 pm
#Instructions:
  # Compute the # of TB cases for each country, year, and sex in the tidy "who" tibble
  # Make an informative visualization using the data
  # AKA you don't need to add all the countries, just the ones that make sense

library(tidyverse)

#Original who data set is untidy. Below code makes it tidy by:
    #fixing and/or removing redundant columns
    #separating columns so each variable has it's own column

who <- who %>%
  pivot_longer(
    cols= new_sp_m014:newrel_f65, 
    names_to= "key", 
    values_to = "cases", 
    values_drop_na = TRUE) %>%
  mutate(
    key= stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep=1)

#creating a narrower data set
who2 <- who %>%
  select(country, sex, cases, year) 
who2

#Counting number of countries using count() and unique()
unique(who2$country) #219 countries; need to get rid of some as irrelevant

who2 %>% count(year) #data spans 34 years from 1980-2013

unique(who2$sex) #m, f; seems redundant, but wanted to double check

who3 <- who2 %>%
  filter(cases >10) #filtered out ~30k observations with fewer than 10 cases

who3 %>% count(country, wt= cases) #182 countries with >10 cases
who3 %>% count(year, wt= cases) #14 year span from 1999 to 2012; shows number of cases in countries with >10 cases

who4 <- who3 %>%
  filter(cases> 10000) #way better, down to 761 obs of 4 var
who4 %>% count(country, wt=cases) #15 countries
who4 %>% count(year, wt= cases) 

#cases by year would be a cool plot, or cases by country

'tb_by_country <- 
  who3 %>%
  group_by(country) %>%
  summarise(cases= mean(cases, na.rm= TRUE))
tb_by_country' #mean cases by country; does not account for sex or year :/

## Creating a figure
ggplot(who4, aes(year, cases)) +
  geom_point(aes(color= country)) + 
  facet_wrap(vars(sex)) + theme_bw() #all countries >10k cases on one plot

ggplot(who4, aes(sex, cases)) +
  geom_point() +
  facet_wrap(vars(country)) + 
  theme_bw() #divided by country
  
'ggplot(who4, aes(year, cases)) +
  geom_point(aes(color= country))' #too busy and does not account for m/f

#AI Statement: I did not use any form of AI to complete this assignment. If I had it would probably be correct
###### End code ######