#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# A "map-reduce" approach to analyzing the Hubway trip data.
# This is the worked example at end of the class.
#############################################################################

# CONTROLLER
# Controller makes decision about how to distribute work
# This would be done by your framework, e.g. Hadoop, but will possibly need
# to be tweaked by you depending on the capabilities of your 
# compute cluster. E.g. there are 500 million rows, computer 1 will take the
# first 100 million, computer 2 will take the next 100 million, and so on.
# However, in our case, we are running on one computer, with one file, so
# we don't need to worry about that
file_ref = open("../Hubway/trips.csv", "r")

# MAP
# Takes each line of file allocated to it and emits a key-value pairs
# (bin, gender) where "bin" = 0 if         duration < 1000
#							= 1 if 1000 <= duration < 2000
#							= 2 if 2000 <= duration
# and "gender" is "Male" or "Female"
function mapper(line)
    line_split = split(line, ",")

    # Analyze "duration" field
    duration = 0
    try
      duration = int(line_split[2])
    catch
      # Bad duration
      return nothing
    end
    bin = (duration < 1000) ? 0 : ((duration < 2000) ? 1 : 2)

    # Analyze "gender" field
    gender = chomp(line_split[end]) 
    if gender == "\"Male\""
      gender = "M"
    elseif gender == "\"Female\""
      gender = "F"
    else
      gender = "NA"
    end

    return (bin, gender)
end
# Controller now applies map function. We'll do it that "big data way":
# eachline is a Julia function that, given a file reference, will
# return an iterable object, i.e. read in each line one at a time
# automatically for us.
function apply_mapper(file_ref)
  tic()
  results = map(mapper, eachline(file_ref))
  println("Map time: $(toq()) seconds")
  return results
end
map_results = apply_mapper(file_ref)


# SHUFFLE
# We now have a list of key value pairs. The shuffle stage now bunchs up
# the same keys together
function apply_shuffle(map_results)
  results = [ 0 => String[],  #  Duration < 1000
              1 => String[],  # 1000 <= D < 2000
              2 => String[]]  # 2000 <= Duration
  tic()
  for keyval in map_results
    # Check it isn't nothing, i.e. a corrupted entry
    if !(keyval == nothing)
      push!(results[keyval[1]], keyval[2])
    end
  end
  println("Shuffle time: $(toq()) seconds")
  return results
end
shuffle_results = apply_shuffle(map_results)


# REDUCE
# We now have (key, [values...]) pairs, only three of them actually.
# We can now calculate summary statistics for each pair and output our final
# results
function reducer(keyvalues)
  # Pull apart tuple
  key = keyvalues[1]
  values = keyvalues[2]
  # Initialize counters
  num_male = 0
  num_female = 0
  num_other = 0
  for v in values
    if v == "M"
      num_male += 1
    elseif v == "F"
      num_female += 1
    else
      num_other += 1
    end
  end
  return num_male, num_female, num_other
end
function apply_reducer(shuffle_results)
  tic()
  results = map(reducer, shuffle_results)
  println("Reduce time: $(toq()) seconds")
  return results
end
reduce_results = apply_reducer(shuffle_results)
println(reduce_results)