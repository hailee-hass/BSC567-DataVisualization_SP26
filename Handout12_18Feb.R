#Handout 12 - 18 Feb 2026
#tidyr continued

library(tidyverse)

table5 %>%
  unite(new, century, year) #automatically separates column by underscore

table5 %>%
  unite(new, century, year, sep= "") #no separation with underscore

tibble(x= c("a, b, c", "d,e,f", "h,i,j")) %>%
  separate(x, c("one", "two", "three"))

tibble(x= c("a, b, c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"), fill= "right") #using fill()

stocks <- tibble(
  year= c(2015, 2015, 2015, 2015, 2016, 2016, 2016), 
  qtr= c(1, 2, 3, 4, 2, 3, 4), 
  return= c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
) #7 obs of 3 var

stocks %>%
  pivot_wider(names_from= year, values_from = return)

stocks

stocks %>%
  pivot_wider(names_from = year, values_from = return) %>%
  pivot_longer(
    cols= c('2015', '2016'), 
    names_to= "year", 
    values_to = "return", 
    values_drop_na = TRUE) #drop NAs

stocks %>%
  complete(year, qtr) #view complete dataframe

treatment <- tribble(
  ~person, ~treatment, ~response, 
  "John Smith", 1, 7,
  NA, 2, 10, 
  NA, 3, 9,
  "Emma Brown", 1, 4
)

treatment

treatment %>% fill(person) #carries forward last value.. could be BAD

#______________________________________#
tidyr::who
#very untidy dataset, need to fix that
#redundant columns, NAs, etc...

who1 <- who %>%
  pivot_longer(
    cols= new_sp_m014:newrel_f65, #selecting a range of columns to name "key"
    names_to= "key", 
    values_to = "cases", 
    values_drop_na = TRUE
  )

who1 #viewing

who1 %>% count(key) #counting number of observations of "key"= 56

who2 <- who1 %>%
  mutate(key= stringr::str_replace(key, "newrel", "new_rel"))

who2

who2 %>% count(key) #still 56 

who3 <- who2 %>%
  separate(key, c("new", "type", "sexage"), sep= "_")

who3

who4 <- who3 %>%
  select(-new, -iso2, -iso3)

who4

who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep=1)

who5

### Rather than doing all of that individual steps, you can use a single pip
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

###### End code ######