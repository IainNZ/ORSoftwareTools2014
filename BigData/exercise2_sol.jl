#############################################################################
# Software Tools for Operations Research
#############################################################################
# Big Data Exercise 2
# Write a program in Julia (or whatever) that
# 1. Takes trips.csv and extracts the start_station and end_station for 
#    all trips with a duration between 60 and 3600, and saves them to
#    reduced.csv as you go
# 2. Load reduced.csv line-by-line and determine which pair of stations
#    had the fewest trips and most trips.
# Hints: not all station IDs are used. Maybe record a list of station
# ids as you load reduced.csv? You can store the matrix of start-end trips
# in a matrix or dictionary-of-dictionaries (extra: can you be even smarter?)

# Part 1
trips_fp = open("../Hubway/trips.csv", "r")
reduced_fp = open("reduced.csv", "w")

first_line = true
for line in eachline(trips_fp)
  if first_line
    first_line = false
    continue
  end

  spl = split(chomp(line), ",")
  dur = float(spl[2])
  start_st = spl[4]
  end_st = spl[6]

  if dur >= 60 && dur <= 3600
    println(reduced_fp, "$start_st, $end_st")
  end
end

close(trips_fp)
close(reduced_fp)

# Part 2
reduced_fp = open("reduced.csv", "r")
# Lots of ways to do this, here is one easy way
trip_mat = zeros(100, 100)

for line in eachline(reduced_fp)
  spl = split(chomp(line), ",")

  # Sometimes we can't turn the station into an int
  # Because its NA. One way to handle this is to
  # try it, and if it causes an error, catch the error
  # and keep on going
  start_st = 0
  end_st = 0
  try
    start_st = int(spl[1])
    end_st = int(spl[2])
  catch
    # Failed
    continue
  end

  trip_mat[int(start_st), int(end_st)] += 1
end

# Now we can find the biggest and smallest pairs
biggest_pair = (0,0)
biggest_pair_count = 0
smallest_pair = (0,0)
smallest_pair_count = Inf
for i = 1:100
  for j = 1:100
    # Remove self trips - they aren't interesting
    if i == j
      continue
    end
    if trip_mat[i,j] > biggest_pair_count
      biggest_pair = (i,j)
      biggest_pair_count = trip_mat[i,j]
    end
    if trip_mat[i,j] < smallest_pair_count && trip_mat[i,j] > 0
      smallest_pair = (i,j)
      smallest_pair_count = trip_mat[i,j]
    end
  end
end
println(biggest_pair)
println(smallest_pair)