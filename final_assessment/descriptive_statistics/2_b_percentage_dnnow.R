library(haven)
library(ggplot2)
library(dplyr)

healthdata <- read_sav("HSE.sav")
total_entries <- nrow(healthdata)

# What is the percentage of people who drink alcohol?
drink_alcohol <- subset(healthdata, dnnow == 1)
doesnt_drink <- subset(healthdata, dnnow == 2)
total_drink_alcohol <- nrow(drink_alcohol)
percentage_drink_alcohol <- (total_drink_alcohol/total_entries) * 100
percentage_not_drink_alcohol <- (nrow(doesnt_drink)/total_entries) * 100
print(percentage_drink_alcohol)

na_percetange <- 100 -(percentage_drink_alcohol + percentage_not_drink_alcohol)
percetanges_df <- data.frame(category = c("Drinks", "Doesn't Drink", "NA"),
                             proportion = c(percentage_drink_alcohol, 
                             percentage_not_drink_alcohol, na_percetange)
                             )

# calculate where to put the labels
percetanges_df <- percetanges_df %>%
  arrange(desc(category)) %>%
  mutate(prop = proportion / sum(percetanges_df$proportion) * 100) %>%
  mutate(ypos = cumsum(prop) - 0.5 * prop)

pie_chart <- ggplot(data = percetanges_df,
                    aes(x = "", y = proportion, fill = category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  theme_minimal() + labs(title = "Drinks Alcohol", fill = "Status") +
  geom_text(aes(y = ypos, label = round(proportion, 2)), color = "white", size = 8)

print(pie_chart)