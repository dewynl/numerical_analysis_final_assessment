library(haven)
library(ggplot2)

healthdata <- read_sav("HSE.sav")

# mapping the values for male and female like this for better plotting.
# this is safe in this case because the summary in the dataset
# shows that all entries are either 1 or 2 in the dataset.
healthdata$Sex <- ifelse(healthdata$Sex == 1, "male", "female")

# --------------------------------------
# Investigate whether there is a statistical difference
# between men and women on the following variables:

# -> Valid height:
hist(healthdata$htval)

# by looking at the plots the data doesnt look too much as a normal distribution
# In this case I think using the wilcox test is better because it doesn't assume
# that the data follows a normal distribution.

height_test <- wilcox.test(htval ~ Sex, data=healthdata)
print(height_test)

height_boxplot <- ggplot(healthdata, aes(x = Sex, y = htval)) + geom_boxplot()
print(height_boxplot)

# with a resulting p-value of strongly below 0.05, we can reject the H0 and
# conclude that there is in fact a significant difference between the height
# of men and women in the data set. By looking at the boxplot, we can conclude
# that men tend to be taller than women in the data set.

# ------ Valid Weight -------
hist(healthdata$wtval)

# by looking at the plots the data doesnt look too much as a normal distribution
# In this case I think using the wilcox test is better because it doesn't assume
# that the data follows a normal distribution.

weight_test <- wilcox.test(wtval ~ Sex, data=healthdata)
print(weight_test)

weight_boxplot <- ggplot(healthdata, aes(x=Sex, y=wtval)) + geom_boxplot()
print(weight_boxplot)

# with a resulting p-value of strongly below 0.05, we can reject the H0 and
# conclude that there is in fact a significant difference between the weight
# of men and women in the data set. By looking at the boxplot, we can conclude
# that men tend to have more weight than women in the data set.