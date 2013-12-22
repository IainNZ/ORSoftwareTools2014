##################################
# Section 1: Load and explore data frame; some data cleaning

# First, load datasets. It's often more convenient to just keep strings as
# strings, so we pass stringsAsFactors=FALSE.
stations = read.csv("../Hubway/stations.csv", stringsAsFactors=FALSE)
trips = read.csv("../Hubway/trips.csv", stringsAsFactors=FALSE)

# OK, the missing values for start_station and end_station are a nuisance;
# let's remove the rows that are missing this information.
trips = subset(trips, !is.na(start_station) & !is.na(end_station))

# Our start_date and end_date variables are strings. We really want them to be
# dates so we can access useful things like day of week. In R, we use the 
# strptime() function to handle this.
trips$start_date = strptime(trips$start_date, "%Y-%m-%d %H:%M:%S")

# Breakdown by day of week? (0 is Sunday)
table(trips$start_date$wday)

# OK, let's do end_date too
trips$end_date = strptime(trips$end_date, "%Y-%m-%d %H:%M:%S")

# new column with day only (for comparisons)
trips$start_day = format(trips$start_date, "%Y-%m-%d")
trips$end_day = format(trips$end_date, "%Y-%m-%d")
# how many total days do we have?
alldays = unique(trips$start_day)
length(alldays)

# are there trips that span multiple days?
sum(trips$start_day != trips$end_day)
# yes, let's throw them out
trips = subset(trips, start_day == end_day)

# which stations are active on each day?
tapply(trips$start_station, trips$start_day, unique)

# Stations are added over time. Are there any stations that have been removed?
# We could further clean the data.

# write out a list of all the days
write(alldays, file="dateindex")

dir.create("tripsbydate")

# write out a compressed csv file for each day
for (d in alldays) {
	fd <- gzfile(file.path("tripsbydate",paste(d,".csv.gz",sep="")))
	today = subset(trips, start_day == d, select=c("start_date","end_date","start_station","end_station"))
	# cut off date, it's redundant
	today$start = format(today$start_date,"%H:%M:%S")
	today$end = format(today$start_date,"%H:%M:%S")
	today$start_date = NULL
	today$end_date = NULL
	write.csv(today, file=fd, row.names=FALSE)
}

