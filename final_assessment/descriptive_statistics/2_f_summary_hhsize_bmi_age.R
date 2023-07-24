library(haven)

healthdata <- read_sav("HSE.sav")

# Find the mean, median, mode, minimum, maximum,
# range and standard deviation of household size, BMI and age at last birthday.
print(summary(healthdata$HHSize))
print(summary(healthdata$bmival))
print(summary(healthdata$Age))