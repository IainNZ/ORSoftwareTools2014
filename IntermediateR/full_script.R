##################################
# Section 1: Load and explore data frame; some data cleaning

# First, load datasets. It's often more convenient to just keep strings as
# strings, so we pass stringsAsFactors=FALSE.
stations = read.csv("stations.csv", stringsAsFactors=FALSE)
trips = read.csv("trips.csv", stringsAsFactors=FALSE)

# str() and summary() are always a good way to start
str(stations)
summary(stations)
str(trips)
summary(trips)

# OK, the missing values for start_station and end_station are a nuisance;
# let's remove the rows that are missing this information.
trips = subset(trips, !is.na(start_station) & !is.na(end_station))

# OK, it seems like there's a crazy outlier in the duration column. Let's
# say that if the duration is more than a day we cap it there.
hist(trips$duration, breaks=100)
trips$duration[trips$duration > 24*60*60] = 24*60*60
hist(trips$duration, breaks=100)

# Our start_date and end_date variables are strings. We really want them to be
# dates so we can access useful things like day of week. In R, we use the 
# strptime() function to handle this.
?strptime # We want %Y, %m, %d, %H %M %S
trips$start_date = strptime(trips$start_date, "%Y-%m-%d %H:%M:%S")

# What is in a POSIXlt?
?POSIXlt

# Breakdown by day of week? (0 is Sunday)
table(trips$start_date$wday)

# Yay for histograms! so amaze. wow.
hist(trips$start_date, breaks=100)

# OK, let's do end_date too
trips$end_date = strptime(trips$end_date, "%Y-%m-%d %H:%M:%S")

###################################
# Section 2: tapply/table with built-in commands

# We're going to be doing a lot of tapply, so let's make sure we remember how to
# use it. [[Pretty picture of tapply() works, in slides]]

# How many trips by each subscription type are there in the dataset?
names(trips)  # Remember variable names
table(trips$subscription_type)

# What is the average duration by subscription type?
tapply(trips$duration, trips$subscription_type, mean)

# What are the full summary statistics by subscription type?
tapply(trips$duration, trips$subscription_type, summary)

####################################
# Assignment 1 (Section 2): tapply/table with built-in commands

# What is the average trip duration by gender? The sum of trip durations?
tapply(trips$duration, trips$gender, mean)
tapply(trips$duration, trips$gender, sum)

# What is the average trip duration by day of week at the start of trip? By month of year at the end of the trip?
tapply(trips$duration, trips$start_date$wday, mean)
tapply(trips$duration, trips$end_date$mon, mean)

# Bonus: What is the proportion of users who are casual users by start station? Which (start) stations have the highest and lowest proportions of casual users? Hint: The average of TRUE/FALSE values is the proportion that are TRUE.
sort(tapply(trips$subscription_type == "Casual", trips$start_station, mean))

#########################################
# Section 3: tapply with user-defined functions

# Great. We are experts at tapply() with built-in functions. But sometimes this
# is not enough! Let's say we wanted to figure out the two busiest days of the
# week for each type of user (using start_date). This is easy enough with a
# two-way frequency table:
table(trips$subscription_type, trips$start_date$wday)

# But there are a few problems with this approach:
# 1) We haven't gotten it programmatically (if we wanted to use it later)
# 2) This is not going to fly if we had asked for most common 2 days by start loc

# Let's start by thinking about how to find the two most common days in the
# whole data frame
table(trips$start_date$wday)

# We're going to want to sort our table since we need the biggest values
sort(table(trips$start_date$wday))

# Let's save it to a variable
tab = sort(table(trips$start_date$wday))
tab

# The table stores the frequencies, and we want the names associated.
names(tab)

# Those quotes are strings (names are strings). as.numeric() will make them
# numbers.
ordered.days = as.numeric(names(tab))
ordered.days

# The biggest 2 are the last 2. R indexes from 1 so we want:
ordered.days[7]
ordered.days[6]
c(ordered.days[7], ordered.days[6])

# Remember that we actually wanted to compute the top 2 days for every type
# [[Picture time! Group week day by type, compute 2 most common with fxn]]
# Cool, so we need to actually make these steps into our own user-defined fxn

# [[In separate file; I will show "source" and "copy"; mention need to re-do
#   these steps every time you change the function!]]
get.top.2 = function(x) {
	tab = sort(table(x))
	ordered.days = as.numeric(names(tab))
	day1 = ordered.days[7]
	day2 = ordered.days[6]
	return(c(day1, day2))
}

# How can we test our function? Let's start by calling it on the whole data frame!
# Remember from our picture that the function takes the wday of each value:
get.top.2(trips$start_date$wday)

# Yay! Now we can use it in tapply, broken down by subscription type:
tapply(trips$start_date$wday, trips$subscription_type, get.top.2)

# Just to check:
table(trips$subscription_type, trips$start_date$wday)

# Great! Armed with this function, we can easily find the top 2 days for
# every single start location:
tapply(trips$start_date$wday, trips$start_station, get.top.2)

# Fabulous -- we got the most common two days for each start location. You could
# imagine wanting to actually build a new data frame out of this -- it would have
# one variable for the station id and two more variables for the top 2 days. We
# will see how to do that in the next section, when we'll talk more formally about
# the split-apply-combine paradigm.

#########################
# Assignment 2 (Section 3)

# Hubway charges a fee for any trip longer than 30 minutes. Use tapply() to
# compute the proportion of trips from each start location that are longer than
# 30 minutes (1800 seconds).
prop.above.30 = function(x) {
	return(mean(x > 1800))
}
tapply(trips$duration, trips$start_station, prop.above.30)

# OR:
tapply(trips$duration, trips$start_station, function(x) mean(x > 1800))

# Bonus: compute the most common subscription type (Registered/Casual/Tie)
# between every pair of start/end locations between which there has been at
# least one trip. Treat A->B and B->A as two separate pairs. How many of each type
# of pair are there? Hint -- think about how to use the paste() function (?paste)
# to combine start_station and end_station to build an appropriate second
# argument for tapply.
most.common = function(x) {
	if (sum(x == "Registered") > sum(x == "Casual")) {
		return("Registered")
	} else if (sum(x == "Registered") < sum(x == "Casual")) {
		return("Casual")
	} else {
		return("Tie")
	}
}
pair.results = tapply(trips$subscription_type, paste(trips$start_station, trips$end_station), most.common)
table(pair.results)

##########################
# Section 4: Split-apply-combine

# The trips data frame has rows that represent bike trips, but we saw last time
# how we could split the data up based on some other variable (in our case
# start station) and compute multiple values for that group (in our case the
# first and second most common day of the week for travel). We would like to
# combine this into a data frame with rows representing start stations, and
# columns representing the variables we built for each start station. This
# methodology is called split-apply-combine.

# [[Picture of split-apply-combine; split breaks large df into smaller ones,
#    lapply converts small data frames into 1-row data frames; do.call(rbind)
#    combines them into a single data frame.]]
    
# Let's first split on the start station.
spl = split(trips, trips$start_station)
summary(spl[[1]])
summary(spl[[2]])

# Next, let's rewrite our function to return a 1-row data frame with the most
# common two days, as well as the id of the start station:
# [[In separate file; start by copying get.top.2]]
get.top.2.df = function(x) {
	tab = sort(table(x$start_date$wday))
	ordered.days = as.numeric(names(tab))
	day1 = ordered.days[7]
	day2 = ordered.days[6]
	return(data.frame(start_station=x$start_station[1], day1=day1, day2=day2))
}

# Let's test it out on a few of our split up data frames
get.top.2.df(spl[[1]])
table(spl[[1]]$start_date$wday)
get.top.2.df(spl[[2]])
table(spl[[2]]$start_date$wday)

# OK, now let's use lapply() to convert all the elements of spl to their 1-row
# summary data frames.
spl2 = lapply(spl, get.top.2.df)
spl2[[1]]
spl2[[2]]

# Last step is to combine everything together. We could manually combine with
# rbind:
rbind(spl2[[1]], spl2[[2]], spl2[[3]])

# do.call is a nifty function that passes all of the elements of its second
# argument to its first argument, which is a function
station.info = do.call(rbind, spl2)
station.info
table(station.info$day1)
table(station.info$day2)

##########################
# Assignment 3 (Section 4): Split-apply-combine

# From trips, create a data frame called bicycle.info, where each row corresponds
# to one bicycle. Include the following variables in your new data frame:
#   - bike_nr: The bicycle number of this bicycle
#   - mean.duration: Average trip duration (seconds)
#   - sd.duration: Standard deviation of trip duration (seconds)
#   - num.trips: Number of trips taken by the bicycle (Hint: ?nrow)

# Remember that you can start by creating just a few of these variables. If you
# edit your function, remember to refresh it in your R console before re-running
# lapply.

spl = split(trips, trips$bike_nr)

process.bike = function(x) {
	bike_nr = x$bike_nr[1]
	mean.duration = mean(x$duration)
	sd.duration = sd(x$duration)
	num.trips = nrow(x)
	return(data.frame(bike_nr, mean.duration, sd.duration, num.trips))
}

spl2 = lapply(spl, process.bike)
bicycle.info = do.call(rbind, spl2)

# Bonus: Add the following additional variables:
#   - multi.day: Number of trips starting and ending on a different day
#   - common.start: Most common start location (hint: length(tab) is the
#                   number of values in a table tab)
#   - common.end: Most common end location

process.bike.bonus = function(x) {
	bike_nr = x$bike_nr[1]
	mean.duration = mean(x$duration)
	sd.duration = sd(x$duration)
	num.trips = nrow(x)
	multi.day = sum(x$start_date$yday != x$end_date$yday | x$start_date$year != x$end_date$year)
	tab = sort(table(x$start_station))
	common.start = as.numeric(names(tab))[length(tab)]
	tab = sort(table(x$end_station))
	common.end = as.numeric(names(tab))[length(tab)]
	return(data.frame(bike_nr, mean.duration, sd.duration, num.trips,
	                  multi.day, common.start, common.end))
}

spl2 = lapply(spl, process.bike.bonus)
bicycle.info.bonus = do.call(rbind, spl2)

##########################
# Section 5: Merging data, and the apply() function

# So far we have not taken advantage of the lat/long information for the
# start and end locations of our trips because trips and stations are separate.
# Let's change that by merging together our data. Our eventual goal from this will
# be to compute the distance of each trip (as the crow flies).

# [[Picture of database operations in R (inner join, left outer join)]]
# Let's combine together our data using merge(). First we will pull in data about
# the start location.
merged = merge(trips, stations, by.x="start_station", by.y="id")
summary(merged)

# Great -- the "name", lat" and "lng" fields were merged in for the start
# location. We want to do this for the end station, so let's merge again:
merged = merge(merged, stations, by.x="end_station", by.y="id")
summary(merged)

# name.x, lat.x and lng.x are for the start location, name.y, lat.y and lng.y
# are for the end location. The next step is to compute the distance for each
# row.

# We are now going to learn about a new function called apply(). [[picture of
# apply, focus on how this is a matrix, so we need to have just numbers]].
# OK, so right now we have more than just numbers (e.g. dates, text). We need
# to limit ourselves to just numbers. We can do this by building a data frame
# with just the columns we need (lat.x, lat.y, lng.x, lng.y):
lat.long = merged[,c("lat.x", "lat.y", "lng.x", "lng.y")]
lat.long = as.matrix(lat.long)  ## Technically don't need this step
summary(lat.long)

# OK, so now we need a function to compute great circle distance from lat/long.
# Life is too short to do this stuff yourself, so we'll use a package. I found
# one on the Internet called Imap that has a nice interface (there are many
# others). We want the gdist function. Let's try it out!
install.packages("Imap")
library(Imap)
?gdist
lat.long[1,]
gdist(-71.07730, 42.34967, -71.10081, 42.34002, units="km")

# Great -- let's write our function. We want to input a row of lat.long and
# output gdist called on its four coordinates. [[Do in separate file]]
lat.long.dist = function(x) {
	return(gdist(x["lng.x"], x["lat.x"], x["lng.y"], x["lat.y"], units="km"))
}

# We want this function to be run on the rows of lat.long, so we can test it on
# a row. If there are errors, this makes it very manageable to debug, since
# it's just being called once, on the row you selected.
lat.long.dist(lat.long[1,])
lat.long.dist(lat.long[2,])

# OK, time to use apply to compute the distance for every single trip.
distance = apply(lat.long, 1, lat.long.dist)

# (This takes a little over 2 minutes on my laptop, so I'll stall by describing
# the assignment for this session).

# Awesome -- now that we're done, we can plot the histogram of trip distance
hist(distance, breaks=100)

# Finally, we'll copy the distance variable we created into our data frame
trips$distance = distance

#####################################
# Assignment 4 (Section 5)

# Hubway charges a variable amount for a bike ride, depending on the duration of
# the ride. They have the following rates for casual users:
# 0-1799 sec -- $0
# 1800-3599 sec -- $2
# 3600-5399 sec -- $6
# 5400-7199 sec -- $14
# 7200-8999 sec -- $22
# 9000-10799 sec -- $30
# 10800-12599 sec -- $38
# 12600-14399 sec -- $46
# 14400-16199 sec -- $54
# 16200-17999 sec -- $62
# 18000-19799 sec -- $70
# 19800-21599 sec -- $78
# 21600-23399 sec -- $86
# 23400-25199 sec -- $94
# 25200+ sec -- $100
# The rate for registered users is 75% that of casual users (e.g. registered
# users has a max fee of $75). Use the apply() function to compute the fee
# associated with each trip. The fee depends on both the duration of the trip
# and the registration_status of the trip.

# Helpful hint -- if you create a matrix with registration_status and duration,
# it will because a matrix of text because registration_status is text. It will
# be easier to work with a matrix of numbers, so you can use this function
# to build a TRUE/FALSE (1/0) variable for whether the user for each trip is
# registered:
trips$is.registered = trips$subscription_type == "Registered"

# Solution:
get.fee = function(x) {
	duration = x["duration"]
	if (x["is.registered"] == 1) {
		multiplier = 0.75
	} else {
		multiplier = 1
	}
	if (duration <= 1799) {
		return(0)
	} else if (duration <= 3599) {
		return(2*multiplier)
	} else if (duration <= 5399) {
		return(6*multiplier)
	} else if (duration <= 7199) {
		return(14*multiplier)
	} else if (duration <= 8999) {
		return(22*multiplier)
	} else if (duration <= 10799) {
		return(30*multiplier)
	} else if (duration <= 12599) {
		return(38*multiplier)
	} else if (duration <= 14399) {
		return(46*multiplier)
	} else if (duration <= 16199) {
		return(54*multiplier)
	} else if (duration <= 17999) {
		return(62*multiplier)
	} else if (duration <= 19799) {
		return(70*multiplier)
	} else if (duration <= 21599) {
		return(78*multiplier)
	} else if (duration <= 23399) {
		return(86*multiplier)
	} else if (duration <= 25199) {
		return(94*multiplier)
	} else {
		return(100*multiplier)
	}
}

fee.info = trips[,c("is.registered", "duration")]
get.fee(fee.info[1,])
get.fee(fee.info[36,])
fee = apply(fee.info, 1, get.fee)

# Fun things to do
table(fee)
sum(fee)

# OK, and we'll copy over the fees to the trips data frame
trips$fee = fee
