#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# Big Data Exercise 4
# Plot output from code
library(ggplot2)
output = read.csv("output.csv")
output = subset(output, output$count >= 20)
output = subset(output, output$start != output$end)
ggplot(output, aes(x=start, y=end, fill=mu)) + geom_tile()