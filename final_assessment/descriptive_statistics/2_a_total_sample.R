library(haven)

healthdata <- read_sav("HSE.sav")

# How many people are included in the sample?
total_entries <- nrow(healthdata)
print(total_entries)