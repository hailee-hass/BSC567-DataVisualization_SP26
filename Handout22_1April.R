# Handout 22 - 1 April 2026
# Themes pt. 2 in ggplot2
# Multiple figures on same page; multi-panel figures

library(ggplot2)
library(ggpubr)
library(patchwork)

p1 <- ggplot(mpg) + geom_point(aes(x = displ, y = hwy))
p1

p2 <- ggplot(mpg) + geom_bar(aes(x = as.character(year),
                                 fill = drv), position = "dodge") + labs(x = "year")
p2

p3 <- ggplot(mpg) + geom_density(aes(x = hwy, fill = drv),
                                 color = NA) + facet_grid(rows = vars(drv))
p3
p4 <- ggplot(mpg) + stat_summary(aes(x = drv, y = hwy, fill
                                     = drv), geom = "col", fun.data = mean_se) +
  stat_summary(aes(x = drv, y = hwy), geom = "errorbar",
               fun.data = mean_se, width = 0.5)

p1 + p2

p1 + p2 + p3 + plot_layout(ncol= 2)

p1 / p2
p3 | p4
p3 | (p2 / (p1 | p4))

p1 + p2 + p3 + plot_layout(ncol= 2, guides = "collect")
p1 + p2 + p3 + guide_area() + plot_layout(ncol= 2, guides = "keep") + scale_fill_discrete(name= "drv")

p12 <- p1 + p2
p12[[2]] <- p12[[2]] + theme_light()
p12

p1 + p4 & scale_y_continuous(limits = c(0,45))

p123 <- p1 | (p2 / p3)
p123 + plot_annotation(tag_levels = "I") #uppercase Roman numerals

p1 + inset_element(p2, left = 0.5, bottom = 0.4, right =
                     0.9, top = 0.95) #don't like this

p24 <- p2 / p4 + plot_layout(guides = "collect")

p1 + inset_element(p24, left = 0.5, bottom = 0.05, right =
                     0.95, top = 0.9)

p12 <- p1 + inset_element(p2, left = 0.5, bottom = 0.5,
                          right = 0.9, top = 0.95)
p12 & theme_bw()

p12 + plot_annotation(tag_levels = 'A') & theme_bw() #labeling inset graphs, legend is too large
ggsave("my_plot.pdf") #save most recent plot to working directory
'getwd()'

ggsave("my_custom_theme_plot.pdf", width = 6, height= 6)

###### End Code ######