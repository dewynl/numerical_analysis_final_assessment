library(haven)
library(ggplot2)
library(chisq.posthoc.test)
library(tidyr)
library(reshape2)

healthdata <- read_sav("HSE.sav")

# Run a significance test to find out which region drinks the most alcohol.
regions_alcohol_table <- table(healthdata$gor1, healthdata$dnnow)
regions_chi_square <- chisq.test(regions_alcohol_table)
print(regions_chi_square)

observed_freq <- regions_chi_square$observed
expected_freq <- regions_chi_square$expected

regions <- c(
                "North East", "North West", "Yorkshire and The Humber",
                "East Midlands", "West Midlands", "East of England",
                "London", "South East", "South West", "Wales", "Scotland"
            )

observed_freq_df <- as.data.frame(observed_freq)

drinkers <- c(subset(observed_freq_df, Var2 == 1)$Freq, rep(NA, 2))
non_drinkers <- c(subset(observed_freq_df, Var2 == 2)$Freq, rep(NA, 2))


plot_data <- data.frame(
  Regions = regions,
  Drinkers = drinkers,
  NonDrinkers = non_drinkers
)

melted_data <- melt(plot_data, id.vars = "Regions")

# Create the plot
p <- ggplot(melted_data, aes(x = Regions, y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of People Who Drink and Don't Drink by Region",
       x = "Region",
       y = "Number of People",
       fill = "Drinking Status") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(p)

# The results suggest there is a significant association
# between regions and alcohol with a p-value strongly below 0.05.

# To see which region is the one with the most elevated
# number of people that drinks, we will add a post-hoc test.
posthoc_test <-chisq.posthoc.test(regions_alcohol_table)
print(posthoc_test)

# Given the results from the post-hoc test in the chi square
# results, we see that the residuals go from 4.018324 to -4.018324.
# With a p-value well below 0.05, we can conclude that
# region number 9, which is the 'South East' region, seems to be the one
# with the most people drinking nowadays in the data set.
