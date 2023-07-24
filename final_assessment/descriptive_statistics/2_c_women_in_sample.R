library(haven)
library(ggplot2)

healthdata <- read_sav("HSE.sav")

# What is the percentage of women in the sample?
total_entries <- nrow(healthdata)
women <- subset(healthdata, Sex==2)
women_patients_percentage <- (nrow(women)/total_entries) * 100
print(women_patients_percentage)
