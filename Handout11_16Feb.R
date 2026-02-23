# Handout 11 - 16 Feb 2026
# tidyr, learning about howto tidy data efficiently

library(tidyverse)

table1 #the only tidy data set!
table2
table3
table4a
table4b

table1 %>%
  mutate(rate= cases/population*10000)

table1 %>% count(year, wt= cases)

ggplot(table1, aes(year, cases)) +
  geom_line(aes(group= country), color= "grey50") +
  geom_point(aes(color= country))

table4a %>% 
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

table4b %>%
  pivot_longer(c('1999', '2000'), names_to= "year", 
               values_to = "population")

#combining tables 4a-b
tidy4a <- table4a %>% 
  pivot_longer(c('1999', '2000'), names_to = "year", values_to = "cases")

tidy4b <- table4b %>%
  pivot_longer(c('1999', '2000'), names_to= "year", 
               values_to = "population")

left_join(tidy4a, tidy4b)

table2 %>%
  pivot_wider(names_from = type, values_from = count)

table3 %>%
  separate(rate, into = c("cases", "population"))

table3 %>%
  separate(rate, into = c("cases", "population"), sep= "/") #get the same result as above
  #separate() uses a non alphanumeric character to separate

mean(table3$cases) #cannot do it... there's an NA leftover from the old dataframe

table3 %>% 
  separate(rate, into= c("cases", "population"), convert = TRUE)

table3 %>%
  separate(year, into= c("century", "year"), sep= 2) #sep is separating columns by two digits

#Can you convert to integer? YES
table3 %>%
  separate(year, into= c("century", "year"), sep= 2, convert = TRUE)


table3 %>% 
  separate_wider_position(year, widths= c(century=2, year=2)) %>%
  mutate(across(c(century, year), as.numeric))
###### End code ######