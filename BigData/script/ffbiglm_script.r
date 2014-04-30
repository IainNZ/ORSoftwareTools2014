#install.packages(c("biglm", "ff", "ffbase"))
library(ff)
library(ffbase)

# Read in first ten lines of the file
firstten = read.table("../Hubway/trips.csv", header=TRUE, nrows = 10, sep=",")
# Each variable/column has a type
classes = sapply(firstten, class)
# Issue: zipcode is read in as integer, but really a factor stored like
# "02139" that might have NAs.
classes["zip_code"] = "factor"
classes

# Ok, now we are ready to "medium data" load the trips file. Its mostly
# the same except its breaks a bit easier! We will manually tell it the
# classes 
trips = read.csv.ffdf(file="../Hubway/trips.csv",header=TRUE,
                      na.strings=c("NA",'""'), colClasses=classes)

# We can use it mostly like a normal data frame, even though the file
# might not be entirely in memory
mean(trips$birth_date, na.rm=TRUE)
table(trips$gender)

# We can even do linear regression (and GLM) using the biglm package
library(biglm)
# Clean data first
trips.clean = subset(trips, !is.na(birth_date))
mymodel = bigglm(duration ~ birth_date, data = trips.clean)
summary(mymodel)