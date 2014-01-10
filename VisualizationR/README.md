# Visualization in R

## Prerequisites

This module builds on the Intro R and Intermediate R classes given in the first week. You should be comfortable writing R code to run linear regression, logistic regression, and clustering algorithms which were all taught in Intro R. You should also be comfortable using the table command, the apply family of functions (tapply, lapply, apply), the merge command, and the split-apply-combine framework taught in Intermediate R. Please review these concepts before class on Tuesday.

## Installation Instructions

Please run the following commands in an R console:

```
install.packages("ggplot2")
install.packages("maps")
install.packages("ggmap")
install.packages("mapproj")
```

## Assignment

Run the following code and save the 3 plots that are produced. Submit a document with the three plots on Stellar.

```
library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
```

Save plot.

```
library(maps)
france = map_data("france")
ggplot(france, aes(x = long, y = lat, group = group)) + geom_polygon()
```

Save plot.

```
library(ggmap)
MIT = get_map(location = "Massachusetts Institute of Technology", zoom = 15)
ggmap(MIT)
```

Save plot.
