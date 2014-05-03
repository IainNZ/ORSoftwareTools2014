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
reduced_fp = open("reduced.csv", "w")  # Write

first_line = true
for line in # ???
  if first_line
    first_line = false
    continue
  end

  # trips.csv layout:
  # duration is the second field/column 
  # start_station is the fourth field/column
  # end_station is the sixth field/column
  # ???
  # Just pull the stations straight out of the file
  # Don't try and turn them into numbers
  start_st = # ???
  end_st = # ???

  if # ??? some condition on dur 
    println(reduced_fp, "$start_st, $end_st")
  end
end

close(trips_fp)
close(reduced_fp)

# Part 2
reduced_fp = # ???

# ??? Some way to store the data you read in
# Hint: A simple way would be to make a 100 by 100 matrix
# Hint: zeros

for line in eachline(reduced_fp)
  spl = split(chomp(line), ",")

  # Sometimes we can't turn the station into an int
  # Because its NA. One way to handle this is to
  # try it, and if it causes an error, catch the error
  # and keep on going
  # You can read more about try/catch in the Julia manual
  # Python has a similar structure, as does C++
  start_st = 0
  end_st = 0
  try
    start_st = int(spl[1])
    end_st = int(spl[2])
  catch
    # Failed
    continue
  end

  # ??? store this
end

# Now we can find the biggest and smallest pairs
biggest_pair = (0,0)
biggest_pair_count = 0
smallest_pair = (0,0)
smallest_pair_count = Inf
# for ...??? iterate over your data, depending on how you stored it
    # Remove self trips - they aren't interesting
    if i == j
      continue
    end

    # ??? find the biggest and smallest
  end
end
println(biggest_pair)
println(smallest_pair)