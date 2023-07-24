library(haven)
library(ggplot2)
library(chisq.posthoc.test)

healthdata <- read_sav("HSE.sav")

# Run a significance test to find out which gender drinks more alcohol.
# Using chi square in this case because the data is categorical.
# The Chi-Square test for independence is specifically designed to assess the association between two categorical variables.
contingency_table <- table(healthdata$Sex, healthdata$dnnow)
chi_test<-chisq.test(contingency_table)
print(chi_test)
# Based on the p-value being extremely small, you can conclude that there is a statistically significant association between gender and drinking status in the dataset.
# The test suggests that gender and drinking status are not independent of each other.
observed_freq <- chi_test$observed
expected_freq <- chi_test$expected

plot_data <- data.frame(
  Category = rep(c("Male", "Female"), each = 2),
  Status = rep(c("Drink", "Doesn't Drink"), 2),
  Frequency = c(observed_freq, expected_freq)
)

chis_test_plot <- ggplot(plot_data, aes(x = Status, y = Frequency, color = Category, group = Category)) +
  geom_line() +
  geom_point(size = 3, shape = 21, fill = "white") +
  labs(title = "Chi-Squared Test Results",
       x = "Drink Status",
       y = "Frequency",
       color = "Gender",
       fill = "Gender") +
  theme_minimal()

print(chis_test_plot)

posthoc_test <- chisq.posthoc.test(chi_test$observed)
print(posthoc_test)


#Based on the results, it appears that males tend to drink more alcohol compared to females,
# as indicated by the positive residual for "Drinks Alcohol" in the male category.