#Handout 15 - 2 March
# Data wrangling with "forcats"

library(tidyverse)

x1 <- c("Dec", "Apr", "Jan", "Mar")

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", 
  "May", "June", "July", "Aug", 
  "Sep", "Oct", "Nov", "Dec")

y1 <- factor(x1, levels= month_levels)
y1 
sort(y1)

factor(x1)

f1 <- factor(x1, levels= unique(x1))
f1

f2 <- x1 %>% factor() %>% fct_inorder()
f2
levels(f2)

#view the data
gss_cat

gss_cat %>%
  count(race)

unique(gss_cat$race)

ggplot(gss_cat, aes(race)) +
  geom_bar() #this drops values

ggplot(gss_cat, aes(race))+
  geom_bar() + scale_x_discrete(drop= FALSE) #this manually forces them to be plotted even if theyre 0

gss_cat %>%
  count(race, .drop = FALSE)

#most common religion? A: Protestant
gss_cat %>% count(relig)

ggplot(gss_cat, aes(relig)) +
  geom_bar()

#most common partyid? A: Independent
gss_cat %>% count(partyid)

ggplot(gss_cat, aes(partyid)) +
  geom_bar()

relig_summary <- gss_cat %>%
  group_by(relig) %>% 
  summarise(
    age=mean(age, na.rm = TRUE), 
    tvhours= mean(tvhours, na.rm = TRUE), 
    n= n()) #15 obs of 4 var

relig_summary

ggplot(relig_summary, aes(tvhours, relig)) + geom_point() #bad graph... no trend? Hard to read
ggplot(relig_summary, aes(tvhours, fct_reorder(relig, tvhours))) + geom_point() #can see the trend now

relig_summary %>%
  mutate(relig= fct_reorder(relig, tvhours)) %>%
  ggplot(aes(tvhours, relig)) +
  geom_point()

rincome_summary <-  gss_cat %>%
  group_by(rincome) %>%
  summarise(
    age= mean(age, na.rm = TRUE), 
    tvhours= mean(tvhours, na.rm = TRUE), 
    n= n())

ggplot(rincome_summary, aes(age, fct_reorder(rincome, age))) + geom_point() #no bueno!

ggplot(rincome_summary, aes(age, fct_relevel(rincome, "Not applicable"))) +
  geom_point()

by_age <-  gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  summarise(count= n()) %>%
  mutate(prop= count / sum(count))

ggplot(by_age, aes(age, prop, colour= marital)) + 
  geom_line()

ggplot(by_age, aes(age, prop, colour= fct_reorder2(marital, age, prop))) +
  geom_line() + 
  labs(colour= "marital")

gss_cat %>% 
  mutate(marital = marital %>% fct_infreq() %>%
           fct_rev()) %>% ggplot(aes(marital)) + 
  geom_bar() #I like this plot. Easy to read
#fct_rev reverses the order

gss_cat %>% count(partyid)

gss_cat %>%
  mutate(partyid= fct_recode(partyid, 
  "Republican, strong" = "Strong republican", 
  "Republican, weak" = "Not str republican", 
  "Independent, near rep" = "Ind, near rep", 
  "Independent, near dem" = "Ind, near dem", 
  "Democrat, weak" = "Not str democrat", 
  "Democrat, strong" = "Strong democrat")) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid= fct_recode(partyid, 
                             "Republican, strong" = "Strong republican", 
                             "Republican, weak" = "Not str republican", 
                             "Independent, near rep" = "Ind, near rep", 
                             "Independent, near dem" = "Ind, near dem", 
                             "Democrat, weak" = "Not str democrat", 
                             "Democrat, strong" = "Strong democrat", 
                             "Other" = "No answer", 
                             "Other" = "Don't know", 
                             "Other" = "Other party")) %>% count(partyid)

gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                                            other= c("No answer", "Don't know", "Other party"), 
                                            rep= c("Strong republican", "Not str republican"), 
                                            ind= c("Ind,near rep", "Independent", "Ind,near dem"), 
                                            dem= c("Not str democrat", "Strong democrat"))) %>% count(partyid)
         
gss_cat %>% 
  mutate(relig= fct_lump(relig)) %>%
  count(relig)

gss_cat %>% 
  mutate(relig= fct_lump(relig, n= 10)) %>%
  count(relig, sort= TRUE)

###### End code ######