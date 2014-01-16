# Big Data Assignment Part 1
# Run this code and submit the part of the output that relates
# to the regression to Stellar
library(ff)
library(ffbase)
library(biglm)
stations = read.csv.ffdf(file="../Hubway/stations.csv", header=TRUE)
lm = bigglm(lat ~ lng, data=stations)
print(summary(lm))