##########################
# VISUALIZATION IN R
##########################

#############
# Before class: installations
install.packages("ggplot2")
install.packages("maps")
install.packages("ggmap")
library(ggplot2)
library(maps)
library(ggmap)

#############
# Section 1: Understanding your data + Intro to ggplot

# Anscombe's quartet is built into R
data(anscombe)
str(anscombe)

# We have 4 x-y datasets here. Let's investigate some of the properties of these datasets.

# Find the mean
apply(anscombe, 2, mean)

# finding the mean of columns is so common there is a actually built in handy short cut 
# we could have used instead!
colMeans(anscombe)

# Let's look at the standard deviation
apply(anscombe, 2, sd)

# How good is the regression fit?
a1 <- lm(y1 ~ x1, data = anscombe)
a2 <- lm(y2 ~ x2, data = anscombe)
a3 <- lm(y3 ~ x3, data = anscombe)
a4 <- lm(y4 ~ x4, data = anscombe)

summary(a1)$r.squared
summary(a2)$r.squared
summary(a3)$r.squared
summary(a4)$r.squared

# practically identical!
# these 4 datasets seem to have the same statistical properties

#Let's investigate them visually

par(mfrow=c(2,2)) #splits the window into a 2x2 pane

plot(anscombe$x1, anscombe$y1)
abline(a1)

plot(anscombe$x2, anscombe$y2)
abline(a2)

plot(anscombe$x3, anscombe$y3)
abline(a3)

plot(anscombe$x4, anscombe$y4)
abline(a4)

# Clearly these 4 datasets do are not all well represented by a linear model! 
# Good thing we can look at them visually. However, the plots we just made are 
# not particularly pretty. Also, it would be hard to add custom elements. We
# managed to add the regression line, but what if we wanted confidence intervals? 
# Or to color an outlying point? This would be hard. Enter: ggplot.


# Let's look at one of the datasets in Anscombe's quartet again but in ggplot instead.

ggplot(data = anscombe, aes(x = x1, y = y1)) + geom_point()

# Let's parse this command.

# data = anscombe

# the aesthetic mappings are specified using aes()
# x = x1 maps the column x1 to the x position
# y = y1 maps the column y1 to the y position

# then we tell ggplot what geometric objects to put in the plot!
# Could use bars, lines, points, or something else.

# This is the ggplot difference: you build different types of graphs by building 
# on the same commands. No need to learn one set of commands for bar graphs and
# another set of commands for line graphs, etc.

# Here we just want a straightforward scatterplot, so the "geom" we add is points.
# Note that the syntax for doing this is simply a + sign.


# Just to see that we could have made a line graph just as easily:
ggplot(data = anscombe, aes(x = x1, y = y1)) + geom_line()

# Back to our scatterplot
ggplot(data = anscombe, aes(x = x1, y = y1)) + geom_point()

# Options within the point geometry: color, shape, size
ggplot(data = anscombe, aes(x = x1, y = y1)) + geom_point(color = "blue", size = 3, shape = 17) 

# Add a title to the plot
ggplot(data = anscombe, aes(x = x1, y = y1)) + geom_point(color = "blue", size = 3, shape = 17) + 
  ggtitle("Anscombe's Quartet #1")

# Great, we have created a basic scatterplot in ggplot! Let's save the plot.

# To make things easier, first let's save it to a single variable:
anscombe_plot = ggplot(data = anscombe, aes(x = x1, y = y1)) + 
  geom_point(color = "blue", size = 3, shape = 17) + ggtitle("Anscombe's Quartet #1")

# Two ways to save plots.

# Can start by creating a new file
pdf("MyPlot.pdf")
print(anscombe_plot)
dev.off()

# In ggplot, ggsave() saves the last plot you created. You only need to pass it a title and
# R will figure out what file format to save the file to. Saves in the working directory.
# If you are on a mac you will need to have x11 installed for this to work, otherwise you 
# may crash RStudio!
ggsave("MyPlot.jpg")

# What type of file format do you want? jpg, png, pdf, svg, wmf all supported.
# Can pass options. For example: ggsave("MyPlot.jpg", width = 4, height = 4, units = "cm")

# Your turn! Do your own scatterplot! Let's use the iris dataset 
# (remember this from Intro R lecture in the clustering section)

data(iris)
str(iris)

# Exercise 1: Plot sepal length vs. petal length in a scatterplot and title the graph
# Solution
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) + geom_point() + ggtitle("Iris Data")

# Let's color the points based on species.

# We need to add this within the aesthetic, because we are mapping a data property
# to a visual property. There are two ways to do this.

# First way: within the aesthetic of the entire plot
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, color = Species)) + 
  ggtitle("Iris Data") + geom_point()

# Second way: within the aesthetic of the points
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) + 
  ggtitle("Iris Data") + geom_point(aes(color = Species))

# In this case, the two ways give exactly the same results. However, by adding it
# to the point aesthetic, you override any of the general plot aesthetics, 
# but just for points.

# Consider the two ways again, but this time where we give different color
# commands within the general plot aesthetic and the point aesthetic:

# First way: within the plot aesthetic:
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, color = Species)) + 
  ggtitle("Iris Data") + geom_point(color = "blue")

# Second way: within the point aesthetic:
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length, color = "blue")) + 
  ggtitle("Iris Data") + geom_point(aes(color = Species))

# Important distinction when we want to add additional layers to the plot
# (could be lines, shapes, sizes, or even points from another dataset)

# How was the clustering algorithm in lecture 1 able to tell the difference between
# versicolor (green) and virginica (blue)? We have not plotted all the dimensions of
# this data on this graph...

# Exercise 2: Change the size of points, by Petal.Width
# Solution
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) + 
  ggtitle("Iris Data") + geom_point(aes(color = Species, size = Petal.Width))

# Very cool! now we see how the clustering algorithm was able to pick out all 3 clusters. 
# But maybe there are some green points hiding there under the blue ones.
# Let's adjust the transparency with the "alpha" parameter
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) + 
  ggtitle("Iris Data") + geom_point(aes(color = Species, size = Petal.Width, alpha = 0.6))

# fantastic, we have seen that it's important to explore your data before you model.
# We've looked at simple x-y datasets that you might want to use for linear regression, and 
# data that you might be trying to cluster. What other types of data might you want to explore?


# Let's take a look at map data! Using latitude and longitude info from the Hubway data,
# let's draw a map of Boston and put all of the Hubway stations on it

library(ggmap)
boston <- get_map(location = "boston", zoom = 13)
ggmap(boston)

# load in the hubway data from last class
stations = read.csv("stations.csv", stringsAsFactors=FALSE)
trips = read.csv("trips.csv", stringsAsFactors=FALSE)

# time-consuming to work with entire trips dataset, so let's take a random sample
set.seed(1)
indices = sample(nrow(trips), size = 50000)
trips = trips[indices,]

trips$duration[trips$duration > 10000] = 10000 #cut off trips > 10000 seconds
trips$start_date = strptime(trips$start_date, "%Y-%m-%d %H:%M:%S")
trips$end_date = strptime(trips$end_date, "%Y-%m-%d %H:%M:%S")

# Let's put the Hubway stations on the map
ggmap(boston) + geom_point(data = stations, aes(x = lng, y = lat))

# let's label the stations
ggmap(boston) +  geom_point(data = stations, aes(x = lng, y = lat)) + 
  geom_text(data = stations, aes(x = lng, y = lat, label = name, size = 3))
# messy! but easier to read when you zoom in.

# Exercise 3: Plot the Hubway stations on a map of Boston, but change the station size to be 
# relative to the total number of trips out of the station. 
# Hint: create a frequency table of trips by start station. Turn this into a data frame. 
# Merge the frequency data frame and station data frame. 

# Solution:
start_df = as.data.frame(table(trips$start_station))
names(start_df) = c("id", "freq")
merged = merge(stations, start_df, by = "id")
ggmap(boston) + geom_point(data = merged, aes(x = lng, y = lat, size = freq))

# Moving on from maps! suppose we wanted to explore ridership by time of day and day of week. 
# One way we could do this is by making a histogram.

# Here is a histogram of ridership by time of day:
ggplot(data = trips, aes(x = start_date$hour)) + 
  geom_histogram(binwidth = 1)

# histograms plot data on intervals like this: [,)

# this is a great time to talk about the difference between color and fill
ggplot(data = trips, aes(x = start_date$hour)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "light blue")

# this is the aggregated histogram. What if we want one for every day of the week?
# We can plot a separate histogram for each day of the week using the facet command.

# 1st need to add a column to the trips dataset specifically with day of the week
trips$weekday = trips$start_date$wday

# now can use facets
ggplot(data = trips, aes(x = start_date$hour)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "light blue") + facet_grid(weekday ~ .)

# lay out the histograms horizontally instead
ggplot(data = trips, aes(x = start_date$hour)) + 
  geom_histogram(binwidth = 1, color = "black", fill = "light blue") + facet_grid(. ~ weekday)

# Exercise 4: plot a histogram of trip length. Make bin size 10 minutes long.
# Facet it by subscription type. What do you notice?

# Solution: 
ggplot(data = trips, aes(x = duration)) + 
  geom_histogram(binwidth = 600) + 
  facet_grid(subscription_type~.)

# An alternative to faceting: let's overlay these histograms on top of each other
ggplot(data = trips, aes(x = duration, fill = subscription_type)) + 
  geom_histogram(binwidth = 600) 

# but these are stacked! to overlay, need to include position = "identity". Don't forget
# to make it semi-transparent using the alpha parameter.
ggplot(data = trips, aes(x = duration, fill = subscription_type)) + 
  geom_histogram(binwidth = 600, position = "identity", alpha = 0.5) 

# Histograms are great, but they are a 1-dimensional exploration. In order to 
# see time of day and day of week, we needed to plot 7 different time-of-day histograms.
# Heatmaps are an alternative way to do 2-dimensional data exploration: we can see time 
# of day and day of week on the same plot.

# First we need to reshape the data so that for every day of the week and 
# every hour of the day, we have the number of trips
weekday_timeday = as.data.frame(table(trips$weekday, trips$start_date$hour))
str(weekday_timeday)

#Now we can plot this as a heatmap
ggplot(weekday_timeday, aes(x = Var2, y = Var1, fill = Freq)) + geom_tile()

# Let's save this to a variable. We will come back to it later when we are talking about
# color spectrums and how to change them.

hubway_heatmap = ggplot(weekday_timeday, aes(x = Var2, y = Var1, fill = Freq)) + geom_tile()

# end of section 1! So far, we have:
# talked about why visualization in general, why ggplot in particular
# Learned how to explore scatterplots, clusters, map data, histograms, heat maps

# other visual data explorations we will not explore today could include 
# box plots, cluster dendrograms, time series, networks, etc...


######################
# Section 2: Understand your model

# Add a regression line! automatically includes a 95% confidence interval
# use stat_smooth(method = "lm")
# first time we use stat. 

anscombe_plot + stat_smooth(method = "lm")

# the "level" parameter specifies the confidence interval.

# Exercise 5: draw a 99% confidence interval instead. Make the regression line hot pink 
# and large enough to show up. This should be easy by now!

# Solution:
anscombe_plot + stat_smooth(method = "lm", level = 0.99, color = "hot pink", size = 2)

# no confidence interval
anscombe_plot + stat_smooth(method = "lm", se = F)

# If you don't specify the method, you get a loess curve (locally weighted polynomial)
# Can also specify other methods: ex) method = "glm", family = "binomial" for logistic regression

# If you want to make your own model, can also do this and add it to the plot
# using geom_line()

# Now suppose we did the clustering of the iris dataset and wanted to
# plot the convex hull of the points in each cluster

# Let's bring back the plot of the iris dataset:
ggplot(iris, aes(x = Petal.Length, y = Sepal.Length)) + 
  ggtitle("Iris Data") + geom_point(aes(color = Species, size = Petal.Width, alpha = 0.6))

# Run k-means clustering
clusterSolution <- kmeans(iris[1:4], centers = 3)

# Add a column to the iris data frame indicating which cluster each 
# data point belongs to
iris$whichCluster <- factor(clusterSolution$cluster)

# Identify the convex hull - we will use the split-apply-combine strategy:

# Split the data into clusters
# Apply a function to find the convex hull of each cluster
# Combine the data

# So let's write a function to find the convex hull of a cluster.
# Luckily, R has a built-in function chull()!

?chull()

# Run chull on the iris data (restricted to 2 dimensions)
chull(iris$Sepal.Length, iris$Petal.Length)

# chull() gives the indices, but we need to tell ggplot which points to 
# connect

iris[chull(iris$Sepal.Length, iris$Petal.Length),]

# Let's generalize this and make it a function

hull <- function(df){
  df[chull(df$Sepal.Length, df$Petal.Length), ]
}

splitData <- split(iris, iris$whichCluster)
appliedData <- lapply(splitData, hull)
combinedData <- do.call(rbind, appliedData)

#Now let's plot it:
ggplot(data = iris, aes(x = Petal.Length, y = Sepal.Length)) + geom_point() +
  geom_polygon(data = combinedData, aes(fill = whichCluster), alpha = 0.5) 

# Note that we keep the point geom but we also include a polygon geom! 
# And the geoms are from different datasets. How cool.


# On to our next type of model output we might want to visualize:
# the output of logistic regression on a map 

# Map data
states_map <- map_data("state")
# other built in maps include county, france, italy, nz, usa, world

str(states_map)
# order = order to connect each point within a group
# region = names of states
# group = grouping variable for each "polygon". In our case a polygon is a state.

ggplot(states_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") + coord_map("mercator")

# Can use various types of projections. Let's see a different one:
ggplot(states_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") + coord_map("polyconic")

# Suppose we want to color this map according to election predictions.

polling = read.csv("pollData.csv")       
str(polling)

# dependent variable: Republican = 1 if republican won state, 0 if Democrat
# SurveyUSA: polled R% - polled D%
# DiffCount = # polls in that state with R winner - # polls in that state with D winner

Train = subset(polling, Year == 2004 | Year == 2008)
Test = subset(polling, Year == 2012) 
str(Train)
str(Test) 

# note that we only have 45 states to test on. we are missing Alaska, Delaware,
# Alabama, Wyoming, and Vermont, so these will not appear in our map

mod = glm(Republican ~ SurveyUSA + DiffCount, data = Train, family = "binomial")
TestPrediction = predict(mod, newdata = Test, type = "response")

# Let's figure out whether we predict Republican or Democrat for each state
# by rounding our logistic regression output probabilities as we did in Intro R

TestPredictionBinary = as.numeric(TestPrediction > 0.5)

# We'll put our prediction data into a data frame:

predictiondf = data.frame(TestPrediction, TestPredictionBinary)

# We need to merge our prediction data with the map data
# Remember that in our Test dataset the State variable has state names capitalized
# and in the states_map data the region variable has them in lower case.
# To simplify our merge, let's make them the same:

predictiondf$region = tolower(Test$State)

str(predictiondf)       

# Now we can merge map data and prediction data, and then use prediction data for fill

prediction_map = merge(states_map, predictiondf, by= "region")
str(prediction_map)

# need to reorder so that polygons are drawn in the right order
prediction_map = prediction_map[order(prediction_map$order),]

# plot predictions      
ggplot(prediction_map, aes(x = long, y = lat, group = group, fill = TestPredictionBinary))+
  geom_polygon(color = "black")

# Legend has a gradient but there are only two possible outcomes, 0/1
# Let's replot with discrete outcomes and with appropriate colors
ggplot(prediction_map, aes(x = long, y = lat, group = group, fill = TestPredictionBinary))+
  geom_polygon(color = "black")+
  scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1))

# Exercise 6: plot gradient outcomes according to probabilities. Change the legend's title
# to say "Prediction 2012".
# How do you think uncertainty should play a role in designing a visualization?

# Solution:
ggplot(prediction_map, aes(x = long, y = lat, group = group, fill = TestPrediction))+
  geom_polygon(color = "black") +
  scale_fill_gradient(low = "blue", high = "red",  name = "Prediction 2012")   

# In this section we have: 
# add a regression line to a scatterplot
# Visualize output of clustering model using the convex hull of points 
# Plot the output of logistic regression on a map

# Other models you might wish to understand visually that we won't cover today:
# car trees/cart partitions, Markov processes, diagnostic plots for linear regression
# branch and bound trees, ...

######################
# Section 3: Make a decision and communicate your findings

# Without talking about it, we just used scale_fill_gradient in our election map
# predictions. Let's use it again on our heatmap!

hubway_heatmap
hubway_heatmap + scale_fill_gradient(low = "white", high = "black")

# Can also use predefined color palettes from RColorBrewer (see slides)

# Use shiny to explore iris dataset interactively
http://spark.rstudio.com/dgrapov/1Dplots/
  
#####################
# Remaning time:
# do your own Hubway Visualization challenge:
# design a visualization of some part of the hubway dataset, save it as a pdf 
# and send it to my by email - we'll look at them at the end, if time permits!
