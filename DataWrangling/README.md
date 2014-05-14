The following is a summary of the distributed content for the second module of the course, Data Wrangling:

*** Pre-assignment
In the second module (Data Wrangling), we're going to be using the Hubway dataset that you briefly saw during week 1. Hubway is a bike sharing program in the greater Boston area, and the dataset contains information about all the Hubway stations and all the trips taken on Hubway over a one-year period.

For this session's assignment, please complete the following in R, and submit the results of the starred steps on Stellar. You can find examples of each of the commands needed for this assignment in file 1-1.R from the Intro R module.

1. Change your working directory to the Hubway directory in the git repository. (This folder contains files stations.csv and trips.csv)
2. Using the read.csv() function, load stations.csv into a data frame called stations and trips.csv into a data frame called trips. 
3. Using the str() function, how many stations are there in the whole dataset? How many variables are there in the stations data frame?
4. Using the str() function, how many trips are there in the whole dataset? How many variables are there in the trips data frame?
5. Using the table() function, how many of the trips were labeled as being taken by a male? Taken by a female? Have the gender of the traveler missing?  [[In 1-1.R, we passed two arguments to table(); here, try running the command with just a single argument that you want to summarize.]]


*** Instructor Script
A full script for the instructor is available in script.pdf. This script describes how to work through the various files distributed as part of this week and how to switch between code and slides. DataWranglingSlides.pdf provides all slides for the module.

*** Code distributed to students
Files exercise2.R, exercise3.R, and exercise4.R should be distributed to students. They provide started code for three of the in-class exercises.

*** Completed script files
full_script.R contains all commands entered into the R console during the module, in addition to brief comments describing these commands (more detailed explanations are present in script.pdf). exercise2_final.R, exercise3_final.R, exercise4_final.R, latlong.R, and top2.R are completed script files for various parts of the module.
