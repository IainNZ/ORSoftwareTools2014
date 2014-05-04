# IAP 2014
# 15.S60 Software Tools for Operations Research
# Lecture 1: Introduction to R

# Script file 1-4.R
# In this script file, we cover hierarchical and 
# k-means clustering

#############################

# R has many built-in datasets -- 
# let's take a look at what they have
data()

# Load the iris set and learn about it
data(iris)
?iris
str(iris)

#############################
## HIERARCHICAL CLUSTERING ##
#############################

# Since species is not a number, we can't 
# compute a distance, so we need to exclude
# the last column
IrisDist = dist(iris[1:4], method = "euclidean")

# Alternative methods include "maximum" and 
# "manhattan" (different distance metrics)

# Compute the hierarchical clusters.  We use 
# method = "ward" to minimize the distance between
# the clusters and the variance within each 
# of the clusters
IrisHC = hclust(IrisDist, method = "ward")

# Plot a dendrogram
plot(IrisHC)

# This diagram will help us decide how many
# clusters are appropriate for this problem.
# The height of the vertical lines represents
# the distance between the points that were 
# combined into clusters. The record numbers
# are listed among the bottom (usually hard to
# see). The taller the lines, the more likely
# it is that clusters should be separate. Two
# or three clusters would be appropriate here.

# Plot rectangles around the clusters to aid
# in visualization
rect.hclust(IrisHC, k = 3, border = "red")

# Now, split the data into these three clusters
IrisHCGroups = cutree(IrisHC, k = 3)

# IrisHCGroups is now a vector assigning each
# data point to a cluster

# Use a table to look at the properties of each 
# of the clusters.
table(iris$Species, IrisHCGroups)
tapply(iris$Petal.Length, IrisHCGroups, mean)

# Using tapply for the means of each of the 
# attributes will give us the centroids of the
# clusters.

########################
## K-MEANS CLUSTERING ##
########################

# K-means clustering requires that we have
# an initial guess as to how many clusters
# there are.  We will initialize it to 3 in this
# case, but if we didn't know, we could always
# try multiple values and experiment

# Run a k-means cluster with 3 clusters and 
# 100 iterations (centroids recomputed and points
# reassigned each time)
IrisKMC = kmeans(iris[1:4], centers = 3, iter.max = 100)
str(IrisKMC)

# Create a vector with the group numbers
IrisKMCGroups = IrisKMC$cluster

# Check out the properties of the clusters 
# using table
table(iris$Species, IrisKMCGroups)

# Try improving with more iterations!
IrisKMC = kmeans(iris[1:4], centers = 3, iter.max = 10000)
IrisKMCGroups = IrisKMC$cluster
table(iris$Species, IrisKMCGroups)

# Look at the locations of the centroids
IrisKMC$centers

################
## ASSIGNMENT ##
################

# 1a) Cluster the LettersBinary dataset using
#     hierarchical clustering. Don't forget to
#     leave out the "Letter" attribute when
#     computing the distance matrix! (Since
#     this dataset is larger, it may take
#     a bit longer to compute)




#  b) Plot the dendrogram and use it to 
#     decide how many clusters to select.




#  c) Make a table comparing the "Letter" 
#     attribute compared with the HC assignment




# 2) Do the same using k-means clustering. 
#    How well do you think clustering performs
#    on this dataset?



# Clustering doesn't seem to do too well here.


# EXTRA ASSIGNMENT

# An additional parameter in the K-Means 
# algorithm is the number of random starts to 
# use. This is controlled with the parameter 
# nstart in the function kmeans. Try different 
# values for nstart. Does it improve the 
# algorithm?











