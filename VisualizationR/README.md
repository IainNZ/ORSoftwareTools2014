# Visualization in R

## Installation Instructions

Please run the following commands in an R console:

install.packages("ggplot2")
install.packages("maps")
install.packages("ggmap")

## Assignment

Run the following code and save the output plots. Submit a document with the plots on Stellar.

library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

library(maps)
france = map_data("france")
ggplot(france, aes(x = long, y = lat, group = group)) + geom_polygon()

library(ggmap)
MIT = get_map(location = "Massachusetts Institute of Technology", zoom = 15)
ggmap(MIT)
