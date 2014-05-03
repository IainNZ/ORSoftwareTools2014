#############################################################################
# Software Tools for Operations Research
#############################################################################
# Big Data Exercise 4
# Hubway charges a variable amount for a bike ride, depending on the duration
# of the ride. They have the following rates for casual users:
# [0, 30) minutes -- $0
# [30, 60) minutes -- $2
# [60, 420) minutes -- $[8*floor(minutes/30)-10]
# 420+ minutes -- $100
# The rate for registered users is 75% that of casual users (e.g. registered
# users has a max fee of $75). The fee depends on both the duration of the
# trip and the registration_status of the trip.
# We want to find, between each pair of stations, the average charge and
# the standard deviation of the charges, as well as number of trips in the
# dataset. The final output should a be file in the format:
# start_station, end_station, count, avg_charge, stddev_charge
#############################################################################

# Open the trips data file
file_ref = open("../Hubway/trips.csv", "r")

# MAP
# Design the map function before coding.
# 1. What information do you need from the string?
# 2. Which fields is this located in?
# 3. One you've extracted them, you need to calculate the fare
#    (you can put the fair calculation in a seperate function to keep your
#     code clean, and that way you can test your fare calculation code
#     seperately from your MapReduce.)
# You should look at "mapreduce_script.jl" for inspiration!
function mapper(line)
    line_split = split(line, ",")

    # Extract relevant fields
    # If entry is corrupted, just return nothing
    # ...


    # Calculate charge
    # ...
    
    # Our key is a pair, (start, end)
    # Our value is the charge
    return ((start_station, end_station), charge)
end

function apply_mapper(file_ref)
  tic()
  results = map(mapper, eachline(file_ref))
  println("Map time: $(toq()) seconds")
  return results
end
map_results = apply_mapper(file_ref)


# SHUFFLE
# We now have a list of key value pairs. The shuffle stage now bunchs up
# the same keys together.
# This would be done by the MapReduce software, e.g. Hadoop, so I will
# provide it here so you don't need to worry.
function apply_shuffle(map_results)
  results = Dict()
  tic()
  for keyval in map_results
    # Check it isn't nothing, i.e. a corrupted entry
    if (keyval == nothing)
      continue
    end
    # Check if key is already in Dict
    key, value = keyval
    if !(key in keys(results))
      results[key] = [float(value)]
    else
      push!(results[key], float(value))
    end
  end
  println("Shuffle time: $(toq()) seconds")
  return results
end
shuffle_results = apply_shuffle(map_results)


# REDUCE
# We now have ((start,end), [charge1,charge2,...]) pairs.
# Now we can calculate statistics for each (start, end)
function reducer(keyvalues)
  # Pull apart tuple
  startend, charges = keyvalues
  
  # Calculate statistics
  # Challenge: you could use the inbuilt functions, but
  # can you do it in a "streaming way"?
  # Challenge: add the random sampling method to select
  # one of the charges at random and return that as well
  # using the algorithm you saw earlier

  return (startend[1], startend[2], charge_count, charge_mean, charge_stddev)
end
function apply_reducer(shuffle_results)
  tic()
  results = map(reducer, shuffle_results)
  println("Reduce time: $(toq()) seconds")
  return results
end
reduce_results = apply_reducer(shuffle_results)

# Save the results to file. You could load the CSV in R
# and plot a heatmap!
out_fp = open("output.csv", "w")
println(out_fp, "start, end, count, mu, sd")
for result in reduce_results
  println(out_fp, "$(result[1]), $(result[2]), $(result[3]), $(result[4]), $(result[5])")
end
close(out_fp)