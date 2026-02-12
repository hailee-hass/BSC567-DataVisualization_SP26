# Handout 9  - 9 Feb 2026 (absent)
# TIBBLES

#__________________________________________________________________#
### How to save PDFs, CSVs, etc. to an R Project ###

#Import libraries
library(tidyverse)

ggplot(diamonds, aes(carat, price)) + 
  geom_hex()

ggsave("diamonds.pdf")

write_csv(diamonds, "diamonds.csv")

#__________________________________________________________________#
### Data Wrangling with tidyverse ###

#coercing a data frame to a tibble
as_tibble(iris)

iris

tibble(
  x= 1:5, 
  y= 1,
  z= x ^ 2 +y) #creating a small tibble

tb <-  tibble(
  ':)' = "smile", 
  ' ' = "space", 
  '2000' = "number")

tb

## Transposed tibble using tribble() ##
tribble(
  ~x, ~y, ~z, 
  "a", 2, 3.6,
  "b", 1, 8.5)

test <- tibble(
  a= lubridate:: now() + runif(1e3) * 86400, 
  b= lubridate::today() + runif(1e3) * 30, 
  c= 1:1e3, 
  d= runif(1e3), 
  e= sample(letters, 1e3, replace= TRUE)
) #1e3 is scientific notation for 1,000. This code would work the same even if you didn't use scientific notation

#__________________________________________________________________#
### Displaying data differently by selecting number of rows and length ###

library(nycflights13)

flights %>%
  print(n=10, width= Inf)

flights

glimpse(flights) #displays in console
view(flights) #opens new tab in script

#__________________________________________________________________#
### Subsetting by name or position

df <- tibble(
  x= runif(5), #uniform distribution
  y= rnorm(5)) #normal distribution

df$x #calling single variable
df[["x"]] #same as above
df[[1]] #same as above

df[[1,2]] #calling a specific position; in this case it's 2nd var in row 1

df[[2,1]] #1st var in 2nd row
df[2,1] #creates a new tibble!!! Make sure to use two brackets!!!

### To use the pipe with subsetting you MUST USE . BEFORE THE SUBSET COMMAND
df %>% .$x #same as lines 71-73

df %>% .[["x"]] #same as above


###### End code ######
