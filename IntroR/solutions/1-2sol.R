# IAP 2014
# 15.S60 Software Tools for Operations Research
# Lecture 1: Introduction to R

# Script file 1-2.R
# In this script file, we cover linear regression
# and logistic regression.

#######################
## LINEAR REGRESSION ##
#######################

# Use lm to create a linear regression model
CEO.linReg <- lm(TotalCompensation ~ Years + ChangeStockPrice + ChangeCompanySales + MBA, data = CEOcomp)

# First argument is the formula, second argument
# is the data.  Notice that you don't need $ here 
# since we are specifying the dataset

# Use summary to take a look at the model
summary(CEO.linReg)

# Which variables are significant predictors of
# TotalCompensation?

# Check out some other useful outputs of a 
# linear regression
CEO.linReg$coefficients
CEO.linReg$residuals
confint(CEO.linReg, level = 0.95)

# We can also compute correlation between variables
cor(CEOcomp$TotalCompensation, CEOcomp$Years)

# Or create a correlation table (note: all columns
# must be numeric to compute correlation of
# the entire dataset)
cor(CEOcomp)

# We can also get more data on pairwise correlation:
cor.test(CEOcomp$TotalCompensation, CEOcomp$Years)

################################################
## SPLITTING DATA INTO TRAINING AND TEST SETS ##
################################################

# Load the dataset of interest
TitanicPassengers = read.csv("TitanicPassengers.csv")
str(TitanicPassengers)

# We first need to install a package to help
# us split the data.  Note that this only
# needs to be done once per machine!
install.packages("caTools")

# Now load the library.  This needs to be done
# every time you wish to use the library.
library(caTools)


# Now split the dataset into training and testing
split <- sample.split(TitanicPassengers$Survived, SplitRatio = 0.6)
TitanicTrain <- TitanicPassengers[split, 1:5]
TitanicTest <- TitanicPassengers[!split, 1:5]

#########################
## LOGISTIC REGRESSION ##
#########################

# Run a logistic regression using general linear model
Titanic.logReg = glm(Survived ~ Class + Age + Sex, data = TitanicTrain, family = binomial)
summary(Titanic.logReg)

# Compute predicted probabilities on training data
Titanic.logPred = predict(Titanic.logReg, type = "response")

# Build a classification table to check accuracy on 
# training set. Note that due to randomness of split, 
# classification matrices may be slightly different
table(TitanicTrain$Survived, round(Titanic.logPred))

# We now do the same for the test set
Titanic.logPredTest = predict(Titanic.logReg, newdata = TitanicTest, type = "response")
test.table <- table(TitanicTest$Survived, round(Titanic.logPredTest))
test.table

# Compute percentage correct (overall accuracy)
sum(diag(test.table))/nrow(TitanicTest)

################
## ASSIGNMENT ##
################

# 1a) Load the dataset LettersBinary.csv and check its structure.

letters <- read.csv("LettersBinary.csv")
str(letters)

#     Doesn't make much sense, huh? Each observation 
#     in this dataset is a capital letter H or R, in one
#     of a variety of fonts, and distorted in various 
#     ways. The attributes x1 ... x16 are all properties
#     of the resultant transformation.  In this 
#     assignment, we wish to see if these attributes 
#     can be useful predictors of what the original 
#     letter was.

#  b) Split the dataset into training and test sets 
#     such that the training set is comprised of 60% 
#     of the original data.

split <- sample.split(letters$Letter, SplitRatio = 0.6)
lettersTrain <- letters[split, 1:17]
lettersTest <- letters[!split, 1:17]

#  c) Build a logistic regression model to predict 
#     the letter based on the attributes. Then create a 
#     classification matrix and determine the 
#     accuracy of the model on the test set.

letters.formula <- formula(Letter ~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10 + x11 + x12 + x13 + x14 + x15 + x16)

#     You can use letters.formula in place of 
#     typing the formula

letter.logReg <- glm(letters.formula, data = lettersTrain, family = binomial)
letter.logPred <- predict(letter.logReg, newdata = lettersTest, type = "response")
letter.table <- table(lettersTest$Letter, round(letter.logPred))
sum(diag(letter.table))/nrow(lettersTest)


# EXTRA ASSIGNMENT: For linear regression, there are 
# several tests that should be done to make sure a model 
# is valid. We already did one of them (computed the 
# correlations). Here we will go through the others.

# *1) Plot the residuals to see if they are normally 
#     distributed (testing normality of the error 
#     distribution):
hist(CEOlinearReg$residuals)

# *2) Plot the observed vs. predicted values to see if 
#     they are symmetrically distributed around a diagonal 
#     line (testing the linear relationship between the 
#     dependent and independent variables)
plot(CEOcomp$TotalCompensation, predict(CEOlinearReg))

# *3) Plot the residuals as a function of the predicted 
#     values (testing for heteroscedasticity)
plot(predict(CEOlinearReg), CEOlinearReg$residuals)


























