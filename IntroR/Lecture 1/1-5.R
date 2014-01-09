# IAP 2014
# 15.S60 Software Tools for Operations Research
# Lecture 1: Introduction to R

# Script file 1-5.R
# In this script file, we cover SVMs

#############################
## SUPPORT VECTOR MACHINES ##
#############################

# Install and load new package
install.packages("e1071")
library(e1071)

# Build SVM model for iris data set (since SVM is 
# easier to visualize with smaller datasets with 
# continuous attributes)

# First, we want to subset the dataset to only 
# keep two attributes (so we can easily visualize 
# the model)

IrisDataSVM = subset(iris, select = Petal.Length:Species)

# SVM model - linear kernel
IrisSVM = svm(Species ~ Petal.Length + Petal.Width, data = IrisDataSVM, kernel = "linear")

# Plot the model
plot(IrisSVM, data = IrisDataSVM)

# Color of the data points indicates 
# the true class; background color indicates 
# prediction; X indicates a support vector

# SVM model - polynomial kernel
IrisSVM = svm(Species ~ Petal.Length + Petal.Width, data = IrisDataSVM, kernel = "polynomial", degree = 3)
plot(IrisSVM, data = IrisDataSVM)

# degree = degree of polynomial used. Different 
# values will often give very different results.

#SVM model - radial basis kernel
IrisSVM = svm(Species ~ Petal.Length + Petal.Width, data = IrisDataSVM, kernel = "radial", gamma = 10)
plot(IrisSVM, data=IrisDataSVM)

# gamma controls how well the model will 
# fit the data. Larger gamma will fit the data 
# more exactly. Try gamma = 100 and gamma = 0.1










