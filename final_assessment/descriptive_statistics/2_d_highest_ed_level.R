library(haven)
library(ggplot2)

healthdata <- read_sav("HSE.sav")

# What is the highest educational level?
valid_ed_levels<-subset(healthdata, topqual3 > 0) # the options below 0 or NA are not eligible.
highest_education <- min(valid_ed_levels$topqual3) # the list seems to be ordered from 1 to 7, being 1 the highest educational level.
print(highest_education)

bar_plot <- ggplot(valid_ed_levels, aes(x = as.factor(topqual3))) +
  geom_bar() +
  labs(title = "Educational Levels", x = "Values", y = "Count")

print(bar_plot)