# Intermediate R

## Assignment

In the second lesson (Intermediate R), we're going to be using the Hubway dataset that you briefly saw during week 1. Hubway is a bike sharing program in the greater Boston area, and the dataset contains information about all the Hubway stations and all the trips taken on Hubway over a one-year period.

For this session's assignment, please complete the following in R, and submit the results of the starred steps on Stellar. You can find examples of each of the commands needed for this assignment in file 1-1.R from the Intro R week. 

1. Change your working directory to the Hubway directory in the git repository. (This folder contains files stations.csv and trips.csv)
2. Using the read.csv() function, load stations.csv into a data frame called stations and trips.csv into a data frame called trips. 
3. Using the str() function, how many stations are there in the whole dataset? How many variables are there in the stations data frame?
4. Using the str() function, how many trips are there in the whole dataset? How many variables are there in the trips data frame?
5. Using the table() function, how many of the trips were labeled as being taken by a male? Taken by a female? Have the gender of the traveler missing?  [[In 1-1.R, we passed two arguments to table(); here, try running the command with just a single argument that you want to summarize.]]

## Brief overview of the lesson

In the intermediate R week, we'll go over data reshaping, one of the common sources of frustration for new R users. By the end of the lesson, you will equipped to do the following:
- Locate and deal with outliers and missing data
- Handle date/time information in a dataset
- Simple use of tapply() using built-in functions [example task: find the average trip duration of trips out of each Hubway station in a single command]
- More advanced use of tapply() using user-provided functions [example task: find the two most common days of the week for trips starting from each Hubway station]
- The split-apply-combine paradigm [example task: reshape the trips data frame -- where each row represents a single trip -- into a data frame where the rows represent bicycles and the columns represent summary information about all the trips made using that bicycle]
- Merging datasets [example task: link the information in stations.csv to the information in trips.csv using the unique identifier for each station, which appears in trips.csv in the start_station and end_station variables and in stations.csv as the id variable.]
- Applying a function to each row (or column) of a data frame [example task: compute the fee charged by Hubway for each trip in trips.csv using a formula that takes into account the duration of the trip and whether the trip was taken by a registered or casual user.]

## Download files for class
In addition to trips.csv and stations.csv, please also download assignment2_start.R, assignment3_start.R, and assignment4_start.R from the IntermediateR folder.
