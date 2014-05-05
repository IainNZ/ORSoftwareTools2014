This folder contains all materials for the Visualization module as offered in January 2014. This README.txt file contains the pre-course assignment given to students to complete before the module and explains how to use the materials in this folder to present the module.

********************************************************************

Pre-course assignment (contains prerequisites, installation instructions, and assignment itself)

Prerequisites:

This module builds on the Machine Learning in R and Data Wrangling classes given in the first week. You should be comfortable writing R code to run linear regression, logistic regression, and clustering algorithms which were all taught in Machine Learning in R. You should also be comfortable using the table command, the apply family of functions (tapply, lapply, apply), the merge command, the split-apply-combine framework, and creating your own functions. These were taught in Intermediate R. Please review all these concepts before class on Tuesday, especially if you are new to R.

Installation Instructions:

Please run the following commands in an R console:
install.packages("ggplot2")
install.packages("maps")
install.packages("ggmap")
install.packages("mapproj")

Assignment:

Run the following code and save the 3 plots that are produced. Submit a document with the three plots.

library(ggplot2)
ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
Save plot.

library(maps)
france = map_data("france")
ggplot(france, aes(x = long, y = lat, group = group)) + geom_polygon()
Save plot.

library(ggmap)
Berlin = get_map(location = "Berlin", zoom = 15)
ggmap(Berlin)
Save plot.


********************************************************************

How to use the materials to present the module:

The R file "script.R" contains the full script used for live coding. This was distributed to students ahead of time in case they wanted to use it as a reference after the class, or if they fell behind during class and wanted to catch up quickly. However, the main intent was for students to code in real time along with the instructor. Comments within the code can be used by the instructor as a guide for what to say, and are helpful to include for students if they refer to the script as a reference later on.

The PowerPoint file "slides.pptx" contains the slides used in the module. This was distributed to students.

The csv file "pollData.csv" was used as additional data for Exercise 6. This was distributed to students.

The materials can be used to teach the module by interleaving slides and code in the following order:

-Present slides 1-2 to give an introduction to the importance of visualization
-Present slide 3 to give a high level outline of what will be covered in today's module
-Present slides 4-11 to show students the types of plots they will be able to create by the end of the module
-Present slides 12-13 to remind students about the Hubway dataset and discuss the Hubway visualization challenge, which was the original reason for the release of the Hubway dataset
-Present slide 14 as an introduction to Section 1 - Using Visualization to Understand Data
-Live code lines 15-67: Anscombe's quartet using base R
-Present slides 15-21: Introduction to ggplot
-Live code lines 68-100: Scatterplots
-Present slide 22: Point shapes in R
-Live code lines 101-133: Scatterplots, saving plots
-Present slide 23: Exercise 1
-Live code lines 134-172: Solution to exercise 1, how to use the aesthetic parameter to map data properties to visual properties
-Present slide 24: Exercise 2
-Live code lines 173-188: Solution to exercise 2 and segue into maps
-Present slide 25 to introduce the ggmap package
-Live code lines 189-216: plot the Hubway stations on a map of Boston
-Present slide 26: Exercise 3
-Live code lines 217-154: Solution to exercise 3, histograms, and faceting.
-Present slide 27: Exercise 4
-Live code lines 255-297: Solution to exercise 4, overlaid histograms, heatmaps, wrap up of Section 1.
-Present slide 28: Introduction to Section 2 - Using Visualization to Understand Your Model
-Live code lines 299-308: Plotting a regression line
-Present slide 29: Exercise 5
-Live code lines 309-394: Solution to exercise 5, plotting 2-D convex hulls, introduce built in blank maps.
-Present slides 30-33: Election Prediction
-Live code lines 395-449: Plotting predictions on a map
-Present slide 34: Exercise 6
-Live code lines 450-467: Solution to exercise 6, wrap up of Section 2
-Present slide 35: Introduction to Section 3 - Communicating Using Visualization
-Live code lines 468-477: Changing color gradient
-Present slides 36-39: Color palettes for visualization
-Present slides 40-54: Best Practices and What Not To Do
-Present slide 55: Next Steps
-Live code lines: 478-481: Use internet to access an example of a dynamic and interactive visualization made with ggplot 
-Present slide 56: References for Visualization in R
-Present slide 57: Other visualization tools
-Present slide 58: Overview of what was covered today
-Live code lines 482-487: Let students make their own visualizations and display and discuss them at the end of class
