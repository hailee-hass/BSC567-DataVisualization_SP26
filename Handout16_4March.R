#Handout 16 - 4 March 2026 (ABSENT)
# Dates and times with lubridate

#Load libraries
library(tidyverse) #lubridate is part of tidyverse
library(nycflights13)

today()
now()

#Messing around with dates, times, and how you can enter them differently
ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")
#No matter what you enter, the date will return the same

ymd(20170131) #unquoted numbers work just fine too. This is more concise

ymd_hms("2017-01-31 20:11:59")
mdy_hms("01/31/2017 08:01")

#Creating dates from a dataset
flights %>%
  select(year, month, day, hour, minute) #creates a new tibble

flights %>% 
  select(year, month, day, hour, minute) %>%
  mutate(departure= make_datetime(year, month, day, hour, minute))

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100) }

flights_dt <-  flights %>%
  filter(!is.na(dep_time), !is.na(arr_time)) %>%
  mutate(dep_time= make_datetime_100(year, month, day, dep_time), 
         arr_time= make_datetime_100(year, month, day, arr_time),
         sched_dep_time= make_datetime_100(year, month, day, sched_dep_time), 
         sched_arr_time= make_datetime_100(year, month, day, sched_arr_time)) %>%
         select(origin, dest, ends_with("delay"), ends_with("time"))

view(flights_dt)

#departure times across year
flights_dt %>%
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth= 86400) #68400 seconds = 1 day

#departure times from a single day
flights_dt %>% 
  filter(dep_time < ymd(20130102)) %>%
  ggplot(aes(dep_time)) +
  geom_freqpoly(binwidth= 600) #600s= 10 minutes

as_datetime(today())
as_date(now())

as_datetime(60 * 60 * 10)
as_date(365 * 10 +2) #without the "+ 2" the date changes to 2 days earlier

datetime <- ymd_hms("2016-07-08 12:34:56")
year(datetime)
month(datetime)
mday(datetime) #day of month
yday(datetime) #day of year
wday(datetime) #day of week

month(datetime, label = TRUE)
wday(datetime, label= TRUE, abbr= FALSE)

flights_dt %>%
  mutate(wday= wday(dep_time, label= TRUE)) %>% 
  ggplot(aes(x= wday)) +
  geom_bar()

#number of flights per week
flights_dt %>% 
  count(week= floor_date(dep_time, "week")) %>% 
  ggplot(aes(week, n)) +
  geom_line()

(datetime <-  ymd_hms("2016-07-08 12:34:56"))

#changing individual parts of the date below
year(datetime) <- 2020
datetime

month(datetime) <- 01
datetime

hour(datetime) <-  hour(datetime) + 1
datetime

update(datetime, year= 2023, month= 3, mday= 2, hour= 10)

ymd("2015-02-01") %>%
  update(mday=30)

ymd("2015-02-01") %>%
  update(hour=400)

flights_dt %>% 
  mutate(dep_hour = update(dep_time, yday= 1)) %>%
  ggplot(aes(dep_hour)) + 
  geom_freqpoly(binwidth=300)

#arithimetic with dates
my_age <-  today() - ymd("19980228")
my_age
as.duration(my_age)

colin_age <- today() - ymd("19961015")
colin_age
as.duration(colin_age)

#durations are ALWAYS in seconds
dseconds(15)
dminutes(10)
dhours(c(12, 24))
ddays(0:5)
dweeks(3)
dyears(1)

2*dyears(1)
dyears(1) + dweeks(12) + dhours(15)

tomorrow <-  today() + ddays(1)
last_year <-  today() - dyears(1)

one_pm <-  ymd_hms("2016-03-12 13:00:00", tz= "America/New_York")
one_pm
one_pm + ddays(1)

one_pm
one_pm + days(1)
seconds(15)
minutes(10)
hours(c(12, 24))
hours(c(12, 8, 23))
days(7)
months(1:6)
weeks(3)
years(1)

10*(months(6) + days(1))
days(50) + hours(23) + minutes(2)

#leap year unexpected date
ymd("2016-01-01") + dyears(1) #the duration of this year (AKA 365 days) was only until december 31 because it was accounting for a leap year
ymd("2016-01-01") + years(1)

one_pm +ddays(1)
one_pm +days(1)

years(1) / days(1)

#Using intervals
next_year <- today() + years(1)
(today() %--% next_year) / ddays(1)

#determining how many periods are in an interval
(today() %--% next_year) %/% days(1)

#working with time zones
Sys.timezone()
OlsonNames()

(x1 <- ymd_hms("2015-06-01 11:00:00", tz= "America/Chicago"))
(x2 <- ymd_hms("2015-06-01 18:00:00", tz= "Europe/Copenhagen"))
(x3 <- ymd_hms("2015-06-01 04:00:00", tz= "Pacific/Auckland"))

x1-x2
x1-x3

(x4 <- c(x1, x2, x3))

#keeping an instant in time the same, but changing the way its displayed
(x4a <- with_tz(x4, tzone = "Australia/Lord_Howe"))

#if you get an instant in time that's the wrong time zone you can force it.
(x4b <- force_tz(x4, tzone= "Australia/Lord_Howe"))
x4b - x4

###### End Code ######