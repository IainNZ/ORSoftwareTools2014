# Introduction to R

## Installation Instructions

Please download and install R from [this webpage](http://cran.us.r-project.org). 

Once there, select your operating system:

-For Windows users, select "Install R for the first time" then "Download R 3.0.2 for Windows"

-For Mac users, select "R-3.0.2.pkg"

## Assignment

Copy and paste the following lines of code to the R Console:

	library(stats)
	lm_test <- lm(mpg ~ hp + cyl + wt + gear, data = mtcars)
	summary(lm_test)


Press Enter and copy the output to a .txt file.  Submit the file to Stellar.

The first two lines of your output should look like:

	Call:
	lm(formula = mpg ~ hp + cyl + wt + gear, data = mtcars)
