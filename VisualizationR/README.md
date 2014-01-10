# Visualization in R

## Installation Instructions

Please run the following commands in an R console:

1. install.packages("ggplot2")
2. install.packages("maps")
3. install.packages("ggmap")
4. install.packages("mapproj")

## Assignment

Run the following code and save the output the 3 plots. Submit a document with the three plots on Stellar.

1. library(ggplot2)
2. ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()

Save plot.

1. library(maps)
2. france = map_data("france")
3. ggplot(france, aes(x = long, y = lat, group = group)) + geom_polygon()

Save plot.

1. library(ggmap)
2. MIT = get_map(location = "Massachusetts Institute of Technology", zoom = 15)
3. ggmap(MIT)

Save plot.
