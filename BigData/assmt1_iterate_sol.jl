# Assignment 1: Iterating and Memory
# Note: you don't really want to run this file directly
# Instead, use it to inform what commands you type into the Julia prompt

# 1. Open Julia
# Record memory usage here:

# 2. Load trips.csv all at once
# Use the readlines command we used before
# Record memory usage here:
trips_fp = open("../Hubway/trips.csv", "r")
alllines = readlines(trips_fp)
close(trips_fp)

# 3. Use a for loop to calculate the average duration of trips
# We can modify the code we had for stations to do this
# Think about how we can calculate an average on-the-fly - what
# is the definition of sample average? What do we need to
# accumulate as we go?
# Record memory usage here:
sumx = 0
n = 0
for i = 2:length(alllines)
  spl = split(chomp(alllines[i]), ",")
  dur = float(spl[2])
  sumx += dur
  n += 1  
end
mean_dur = sumx / n
println(mean_dur)

# 4. Close Julia, open it again
# Record memory usage here:

# 5. Use eachline...
# If you are up to here, you don't need a hint!
# Record memory usage here:
trips_fp = open("../Hubway/trips.csv", "r")

sumx = 0
n = -1
for line in eachline(trips_fp)
  spl = split(chomp(line), ",")
  if n == -1
    # Skip first line
    n += 1
    continue
  end

  dur = float(spl[2])
  sumx += dur
  n += 1  
end
mean_dur = sumx / n
println(mean_dur)

close(trips_fp)