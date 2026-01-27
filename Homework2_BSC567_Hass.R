### Homework 2 ###
#Due: Thurs. Jan 30
#Import data and make 1 appropriate plot. Submit .R and PDF of plot

#set wd
setwd("C:/Users/haile/Box/PhD/Projects/IF-AT/Data")
getwd() #double check

#Load libraries
library(tidyverse)
library(ggplot2)

#Import data
ifat <- read.csv("BSC108_IFAT_dataFA22-SP25.csv") #24 obs of 10 var
names(ifat)
str(ifat)
head(ifat) #noticed some NAs... 

anyNA.data.frame(ifat) #check NAs; TRUE (i.e., there are NAs within this data)
narm_ifat <- na.omit(ifat) #remove NA; only 1 
anyNA.data.frame(narm_ifat) #check NAs in new dataset; FALSE
head(narm_ifat) # double checking NAs are omitted; probably overkill

## Interested in looking at student scores by instructor in BSC108 at UA
# Create separate data frame for each instructor
j_data <- narm_ifat %>% filter(Instructor== "CJY") #11 obs of 10 variables; one NA removed in line 20
b_data <- narm_ifat %>% filter(Instructor== "JBS") #12 obs of 10 variables

# Bar chart of average exam grades from FA22-SP25 from overall course, NOT by instructor
ggplot(narm_ifat, add.kde= TRUE, aes(x=AvgGrade)) + labs(y= "Frequency", x= "Average Exam 3 Grade (%)") +
  geom_histogram(color="navyblue", fill="lightblue")+ theme_classic() + scale_y_continuous(expand = c(0,0))

mean(narm_ifat$AvgGrade) #73.8513 mean

#By Instructor J
ggplot(j_data, aes(x=AvgGrade)) + labs(y= "Frequency", x= "Exam 3 Grade (%)") +
  geom_histogram(color="burlywood", fill="burlywood4")+ theme_classic() + scale_y_continuous(expand = c(0,0))

mean(j_data$AvgGrade, na.rm= TRUE) #74.08545; ALL of J's sections (2022-2025)
var(j_data$SD, na.rm= TRUE) #17.31534

#By Instructor B
ggplot(b_data, aes(x=AvgGrade)) + labs(y= "Frequency", x= "Exam 3 Grade (%)") +
  geom_histogram(color="aquamarine", fill="aquamarine4")+ theme_classic() + scale_y_continuous(expand = c(0,0))

# so... not a single one of B's section has ever had the same average grade? Need to double check
# Need to figure out how to remove decimals from y-axis.. .don't like this

mean(b_data$AvgGrade, na.rm= TRUE) #73.63667 for ALL of B's sections (2022-2025)
var(b_data$SD, na.rm= TRUE) #9.200533

# Create separate dataframe for each assessment type (computer, IFAT)
ifat_data <- narm_ifat %>% filter(ExamType== "IFAT") #4 obs of 10 var
comp_data <- narm_ifat %>% filter(ExamType== "Computer") #19 obs of 10 var (because the data is more representative of computer tests)

basic_violinassessment <- ggplot(data = narm_ifat) + 
  geom_violin(mapping= aes(x= ExamType, y= AvgGrade, fill= ExamType)) + 
  theme_classic()

print (basic_violinassessment) #HW2 plot

#Adding error bars to plot
errbar_lims <- group_by(narm_ifat, ExamType) %>% 
  summarize(mean=mean(AvgGrade), se=sd(AvgGrade)/sqrt(n()), 
            upper=mean+(2*se), lower=mean-(2*se))
AssessViolin_ErrorBars <- 
  ggplot() +
  geom_violin(data= narm_ifat, aes(x=ExamType, y=AvgGrade, fill=ExamType, color=ExamType)) +
  geom_point(data=errbar_lims, aes(x=ExamType, y=mean), size=3) +
  geom_errorbar(aes(x=errbar_lims$ExamType, ymax=errbar_lims$upper, 
                    ymin=errbar_lims$lower), stat='identity', width=.25) +
  theme_classic() #theme_minimal removes axis lines

print(AssessViolin_ErrorBars)

########## End code ##########