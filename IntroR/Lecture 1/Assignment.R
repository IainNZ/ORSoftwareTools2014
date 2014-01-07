# IAP 2014
# 15.S60 Software Tools for Operations Research
# Lecture 1: Introduction to R

# Pre-assignment

library(stats)
lm_test <- lm(mpg ~ hp + cyl + wt + gear, data = mtcars)
print(summary(lm_test))

