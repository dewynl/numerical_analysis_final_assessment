library(haven)
library(ggplot2)
library(dplyr)

healthdata <- read_sav("HSE.sav")

# What is percentage of divorced and separated people?
total_entries <- nrow(healthdata)
divorced_people <- subset(healthdata, marstatc == 4)
separated_people <- subset(healthdata, marstatc == 5)

divorced_percentage <-
    (nrow(divorced_people) / total_entries) * 100

separated_percentage <-
    (nrow(separated_people) / total_entries) * 100


divorced_separated_percentage <- (nrow(divorced_people) + nrow(separated_people)) / total_entries * 100
print(divorced_separated_percentage)

bar_plot <- ggplot(healthdata, aes(x = as.factor(marstatc))) +
  geom_bar() +
  labs(title = "Marital Status", x = "Status", y = "Count")

print(bar_plot)

other_percentage <- 100 - (separated_percentage + divorced_percentage)

percetanges_df <- data.frame(category = c("Separated", "Divorced", "Other"),
                             proportion = c(separated_percentage,
                             divorced_percentage, other_percentage)
                             )


# calculate where to put the labels
percetanges_df <- percetanges_df %>%
  arrange(desc(category)) %>%
  mutate(prop = proportion / sum(percetanges_df$proportion) * 100) %>%
  mutate(ypos = cumsum(prop) - 0.5 * prop)

pie_chart <- ggplot(data = percetanges_df,
                    aes(x = "", y = proportion, fill = category)) +
  geom_bar(stat = "identity", width = 1) +
  theme_void() +
  geom_text(aes(y = ypos, label = round(proportion, 2)), color = "white", size = 2)

print(pie_chart)