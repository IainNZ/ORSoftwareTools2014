# Input: subset of trips data frame (all trips on a single bike)
# Output: 1-row data frame summarizing these trips

process.bike = function(x) {
  bike.nr = x$bike_nr[1]
  mean.duration = mean(x$duration)
  sd.duration = sd(x$duration)
  num.trips = nrow(x)
  return(data.frame(bike.nr, mean.duration, sd.duration, num.trips))
}


# In the console, you can run split/apply/combine with
# the following (you need to fill in the category to split
# the data frame):

# spl = split(trips, [category])
# spl2 = lapply(spl, process.bike)
# bicycle.info = do.call(rbind, spl2)



process.bike = function(x) {
  bike.nr = x$bike_nr[1]
  mean.duration = mean(x$duration)
  sd.duration = sd(x$duration)
  num.trips = nrow(x)
  multi.day = sum(x$start_date$yday != x$end_date$yday |
                  x$start_date$year != x$end_date$year)
  tab = sort(table(x$start_station), decreasing=TRUE)
  common.start = as.numeric(names(tab))[1]
  tab = sort(table(x$end_station), decreasing=TRUE)
  common.end = as.numeric(names(tab))[1]
  return(data.frame(bike.nr, mean.duration, sd.duration, num.trips,
                    multi.day, common.start, common.end))
}
