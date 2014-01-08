# Input: subset of trips data frame (all trips on a single bike)
# Output: 1-row data frame summarizing these trips
process.bike = function(df) {
    bike.nr = df$bike_nr[1]
    mean.duration = mean(df$duration)
    # Compute sd.duration
    # Compute num.trips
    return(data.frame(bike_nr, mean.duration,
	                  [add other variables here]))
}


# In the console, you can run split/apply/combine with
# the following (you need to fill in the category to split
# the data frame):

# spl = split(trips, [category])
# spl2 = lapply(spl, process.bike)
# bicycle.info = do.call(rbind, spl2)
