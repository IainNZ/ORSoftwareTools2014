# IAP 2014
# 15.S60 Software Tools for Operations Research
# Lecture 1: Introduction to R

# Script file 1-1.R
# In this script file, we cover the basics of using R.

###################################################
## RUNNING R AT THE COMMAND LINE, SCRIPTING, AND ##
## SETTING THE WORKING DIRECTORY                 ##
###################################################

# Using the R console (command line):
# - You can type directly into the R console (at '>') and 
#   execute by pressing Enter
# - Previous lines can be accessed using the up and down arrows
# - Tabs can be used for auto-completion
# - Incomplete commands will be further prompted by '+'

# Using R scripts in conjunction with the console:
# - We are currently in a script ("1-1.R")
# - Individual lines (or multiple) in this script can be executed 
#   by placing the cursor on the line (or selecting) and typing 
#   Ctrl + r on PC or Cmd + Enter on Mac
# - An entire script file can also be run by Edit -> Run All on PC 
#   or Edit -> Source on Mac or typing the following:
source("Assignment.R")

# Oops! We need to set our working directory.  
# Check the current directory (also in the upper part of console)
getwd()

# Set your directory path here! Where did you save the folder?
setwd("~/Desktop/")

# Alternatively, you can do File -> Change dir... on PC or 
# Misc -> Change Working Directory... on Mac 

################################################
## BASICS: CALCULATIONS, FUNCTIONS, VARIABLES ##
################################################

# You can use R as a calculator.  E.g.:
3^(6-4)
22/7
16^(1/4)

6*9 == 

# What happened with that last one? Check the R console!
# Let's see if it's equal to 42...

# Use the arrow keys to recall the command and check to see
# if 54 will give you the answer you expect.

# Other useful functions:
sqrt(2)
abs(-2)

sin(pi/2)
cos(0)

exp(-1)
(1 - 1/100)^100

log(exp(1))

# The help function can explain certain functions
# What if we forgot if log was base 10 or natural log?
help(log)
?log

# You can save values, calculations, or function outputs to variables
# with either <- or = 
x <- 2^3
y = 6

# Use just the variable name to display the output
x
y

# Note! If you run a script using source(""), output will be 
# suppressed, unless you use the print function
print(x)
print(y)

# Rules for variable names 
# - Can include letters, numbers
# - Can have periods, underscores
# - CANNOT begin with a number
# - Case-sensitive
# - CANNOT use spaces

# Use the ls() function to see what variables are available
ls()

########################################
## VECTORS, MATRICES, AND DATA FRAMES ##
########################################

# Create a vector of numbers from 1 through 10, access an index,
# and sum all of them
z <- seq(1:10)
z[5]
sum(z)
double_z <- z^2

# Create vectors of locations and capacities
locations = c("Davis", "Porter", "Harvard", "Central", "Kendall")
capacities = c(10, 15, 20, 15, 25)

# Place vectors together as a matrix using bind

# bind together as columns
cbind(locations, capacities)

# bind together as rows
rbind(locations, capacities)

# Create a data frame
df1 = data.frame(locations, capacities)

# Add the capacities of another bike rack
capacities = c(15, 10, 10, 5, 5)

# Create another data frame
df2 = data.frame(locations, capacities)

# Append rows of the second data frame to those of the first
df.bikes = rbind(df1, df2)

# Check out the class and structure of various variables
class(locations)
str(locations)

class(capacities)
str(capacities)

class(df.bikes)
str(df.bikes)
df.bikes

# Use data.frame$col to extract the column col from a data frame
df.bikes$locations

# The summary function can often give you useful information 
summary(df.bikes)
summary(df.bikes$locations)

# Use the subset function to extract rows of interest from 
# a data frame (first argument is the data frame, second
# argument is the criterion on which to select)
bikesKendall = subset(df.bikes, locations=="Kendall")
bikesKendall

# Find the total bike capacity at Kendall 
sum(bikesKendall$capacities)

############################
## WORKING WITH CSV FILES ##
############################

# Load csv files using read.csv
# header = TRUE is usually ASSUMED, so not strictly necessary
CEOcomp = read.csv(file = "CEOcomp.csv", header = TRUE)

# Use str to look at variable names
str(CEOcomp)

# Use the $ command to look at specific variables
CEOcomp$Years
CEOcomp$MBA

# If you only have one dataset, you can attach the name of the
# data frame.  This isn't generally recommended practice, though!
attach(CEOcomp)
Years
MBA
detach(CEOcomp)

####################################################
## BASIC STATISTICS, PLOTTING, AND SUMMARY TABLES ##
####################################################

# Calculate the mean, standard deviation, and other statistics
mean(CEOcomp$Years)
sd(CEOcomp$Years)
summary(CEOcomp$Years)

# Plot compensation versus years of experience
plot(CEOcomp$Years, CEOcomp$TotalCompensation)

# Plot with a title, x- and y-axis labels
plot(CEOcomp$Years, CEOcomp$TotalCompensation, main="Total Compensation by Year", xlab = "Years of Experience", ylab = "Total Compensation (thousand USD)")

# For other plots and information about the graphics package
library(help = "graphics")

# Create a table to summarize the data
# Here, we look at mean CEO compensation, based on whether or not 
# the CEO has an MBA
tapply(CEOcomp$Years, CEOcomp$MBA, mean)

# We can also create a table to look at counts 
table(CEOcomp$Years, CEOcomp$MBA)

# In our dataset, how many CEOs have 7 years of experience and 
# an MBA?

################################
## UNDERSTANDING R WORKSPACES ##
################################

# You may save an entire workspace, including variables using the
# following command (alternatively, you can use the Workspace tab
# in the menu bar):
save.image("eg.RData")

# To load, you can run the following:
load("eg.RData")

# You should save the image if you are working on a large project
# and are taking a pause from working on it.  This way, when you
# come back to R, you can just load the workspace and continue
# as before

# You can also save individual variables as follows:
save(CEOcomp, file = "CEOcomp.RData")

# This is useful when the variable is given the result of 
# a computation that takes a lot of time (e.g., loading
# very large data sets, result of running multiple SVMs, etc.)

#################
## ASSIGNMENTS ##
#################

# 1a) Use the help function on seq to assign the variable 'evens'
#     to be the even numbers from 2 through 20, inclusive.



#  b) Propose an alternative way to get 'evens' to be the even 
#     numbers from 2 through 20, inclusive, with perhaps more
#     than one command.  Write down the commands.





##
# 2a) Try out a few other basic statistics and graphing functions

min(CEOcomp$Years)
median(CEOcomp$Years)
max(CEOcomp$Years)

sum(CEOcomp$MBA)

hist(CEOcomp$Years)
boxplot(CEOcomp$Years)

#  b) Edit the histogram plot above to ensure that it has a title
#     and that the x-axis is labeled properly




##
# 3a) Load the Hubway dataset "stations.csv"




#  b) Take a look at the structure of the stations dataset. This 
#     dataset gives the names and locations (latitude, longitude)
#     of all of the Hubway stations.




#  c) Find the centroid (mean of longitude, and mean of latitude)
#     of all of the Hubway stations





#  d) Make a geographic map of all of the hubway stations
#     (hint: x-axis should be longitude).  Make sure that your
#     map has a title and that the axes are properly labeled.





#  e) Use the round function and the table function to create
#     a matrix so that you can determine the number of stations
#     within a .01 lng x .01 lat square centered at -71.08 lng and 
#     42.35 lat










