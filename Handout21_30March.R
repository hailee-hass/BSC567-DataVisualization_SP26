#Handout 21 - exploring themes
# 30 March 2026

library(ggplot2)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE) +
  theme_bw()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE) +
  theme_classic()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE) +
  theme_dark()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE) +
  theme_void()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color= class)) +
  geom_smooth(se= FALSE) +
  theme_linedraw()

library(ggthemes)

df <- data.frame(x= 1:3, y= 1:3)
base <- ggplot(df, aes(x,y)) + geom_point()
base_x <- base + labs(title= "This is a gpplot") +
  xlab(NULL) + ylab(NULL)
base_x + theme(plot.title = element_text(size=16))
base_x + theme(plot.title = element_text(face= "bold", color= "red"))
base_x + theme(plot.title = element_text(hjust= 1))

base_x + theme(plot.title = element_text(margin =
                                          margin()))
base_x + theme(plot.title = element_text(margin = margin(t
                                                         = 10, b = 10)))
base + theme(axis.title.y = element_text(margin = margin(r
                                                         = 10)))

base + theme(panel.grid.major = element_line(color =
                                               "black"))
base + theme(panel.grid.major = element_line(linewidth =
                                               2))
base + theme(panel.grid.major = element_line(linetype =
                                               "dotted")) # I like this the most

base + theme(plot.background = element_rect(fill =
                                              "grey80", color = NA))
base + theme(plot.background = element_rect(color = "red",
                                            size = 2)) #would be good to add a border (for a journal)
base + theme(plot.background = element_rect(fill =
                                              "linen"))
base
last_plot() + theme(panel.grid.minor = element_blank())
last_plot() + theme(panel.grid.major = element_blank())
last_plot() + theme(panel.background = element_blank())
last_plot() + theme(axis.title.x = element_blank(),
                    axis.title.y = element_blank()) #removes axis labels (in this case, "y" and "x")

base + theme(plot.background = element_rect(color =
                                              "grey50", size = 2))
base + theme(plot.background = element_rect(color =
                                              "grey50", size = 2), plot.margin = margin(2, 2, 2, 2))
base + theme(plot.background = element_rect(fill =
                                              "lightblue"))

base + theme(axis.line = element_line(color = "grey50",
                                      size = 1))
base + theme(axis.text = element_text(color = "blue", size
                                      = 12))
base + theme(axis.text.x = element_text(angle = -90, vjust
                                        = 0.5))

df <- data.frame(
  x = c("label", "a long label", "an even longer
label"),
  y = 1:3)
base <- ggplot(df, aes(x, y)) + geom_point()
base
base + theme(axis.text.x = element_text(angle = -30, vjust
                                        = 1, hjust = 0)) + xlab(NULL) + ylab(NULL)

df <- data.frame(x = 1:4, y = 1:4, z = rep(c("a", "b"),
                                           each = 2))
base <- ggplot(df, aes(x, y, color = z)) + geom_point()
base + theme(legend.background = element_rect(fill =
                                                "lemonchiffon", color = "grey50", size = 1))
base + theme(legend.key = element_rect(color = "grey50"),
             legend.key.width = unit(0.9, "cm"), legend.key.height =
               unit(0.75, "cm"))
base + theme(legend.text = element_text(size = 15),
             legend.title = element_text(size = 15, face = "bold"))

base2 <- base + theme(plot.background = element_rect(color
                                                     = "grey50"))
base2 + theme(aspect.ratio = 9/16)
base2 + theme(aspect.ratio = 2/1)
base2 + theme(aspect.ratio = 1)

base_f <- ggplot(df, aes(x, y)) + geom_point() +
  facet_wrap(~z)
base_f + theme(panel.margin = unit(0.5, "in"))
base_f + theme(strip.background = element_rect(fill =
                                                 "grey20", color = "grey80", size = 1), strip.text =
                 element_text(colour = "white"))

my_theme <- function () {
  theme_bw(base_size=12, base_family="Times") %+replace%
    theme(
      panel.background = element_blank(),
      plot.background = element_rect(fill="gray96",
                                     color=NA),
      legend.background = element_rect(fill="transparent",
                                       color=NA),
      legend.key = element_rect(fill="transparent",
                                color=NA)
    )
}
base + ggtitle("No theme")
base + ggtitle("Black and White") + theme_bw()
base + ggtitle("Custom Theme") + my_theme()  
  
###### End Code ######