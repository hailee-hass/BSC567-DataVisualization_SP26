# HW 8 - themes
# Due April 10th at 11:59 pm

#Instructions:
  #Find a plot in one of the journals you read regularly and see if you can create a
  #custom theme that mimics the journal's style. Don't worry about the data (just use
  #one of the base plots from this week) and focus on the plot elements we have
  #learned about this week. On Blackboard, upload 1) your annotated standalone
  #code (with the call for the data frame) as a .R file and 2) a screenshot of the plot
  #you used as your template.

#AI Statement:
  #I used Google to help me solve some of my problems. 
  #I'm including this here because I'm pretty certain Google Gemini 
  #is fairly well embedded within all of Google's search results. However, 
  #I did not knowingly use any form of generative AI to complete this 
  #homework assignment.

#Theme Inspiration
  #The journals I read usually use some form of theme_classic() but I'll try to zhuzh it up a bit.
  #You can see the figure I uploaded is rather plain (B&W). It's from American Biology Teacher

library(tidyverse)
library(ggthemes)

df <- data.frame(
  x = c("Donuts", "Chocolate Chip Cookies", "Maple Cinnamon Rolls"),
  y = 1:3)
base <- ggplot(df, aes(x,y)) + geom_point()
base1 <- base + labs(title= "How much I enjoy different sweets") +
  xlab(NULL) + ylab(NULL)+ theme(plot.title = element_text(size=16, face= "bold", color= "sienna"))
          
base2 <-  base1 + theme(panel.background = element_blank())
base2 + theme(aspect.ratio = 1)

#Making a custom theme
my_theme <- function () {
  theme_bw(base_size=16, base_family="Times") %+replace%
    theme(
      panel.background = element_blank(),
      panel.border = element_blank(),           # Remove the full box
      axis.line.x.bottom = element_line(color = "black"), # Add bottom line
      axis.line.y.left   = element_line(color = "black"),  # Add left line
      plot.background = element_rect(fill="transparent",
                                     color=NA),
      legend.background = element_rect(fill="transparent",
                                       color=NA),
      legend.key = element_rect(fill="transparent",
                                color=NA)
    )
}


base2 + ggtitle("How much I enjoy different sweets") + my_theme()  

###### End Code for HW 8 ######