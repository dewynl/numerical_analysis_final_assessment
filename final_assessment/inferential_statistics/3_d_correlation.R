library(haven)
library(ggplot2)
library(nortest)
library(reshape2)

healthdata <- read_sav("HSE.sav")

# What is the correlation between whether a person drinks nowadays,
# total household income, age at last birthday and gender?

# checking if the data is normally distributed for each variable.
ad.test(healthdata$dnnow)

df <- data.frame(healthdata$dnnow,
                 healthdata$totinc,
                 healthdata$Age,
                healthdata$Sex)

correlation <- cor(df)
print(correlation)

# The correlation between "healthdata.dnnow" (Whether a person drinks nowadays)
# and "healthdata.totinc" (Total household income) is 1.0000.
# However, this value is meaningless since "healthdata.dnnow"
# is categorical, and "healthdata.totinc" is continuous.

# Correlation between a binary and a
# continuous variable is not a meaningful measure.

# The correlation between "healthdata.Age"
# and "healthdata.Sex" is 0.0327, which indicates a very weak positive
# correlation between age and gender.

# For the other combinations, the correlation is not available (NA).

# Convert the correlation matrix to a long-format data frame for plotting
correlation_data <- melt(correlation)

heatmap <- ggplot(correlation_data, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                       midpoint = 0, limit = c(-1, 1), name = "Correlation") +
  theme_minimal() +
  labs(title = "Correlation Matrix",
       x = "Variables",
       y = "Variables")