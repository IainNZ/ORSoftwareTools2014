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

# 3. Close Julia, open it again
# Record memory usage here:

# 4. Use eachline...
# Record memory usage here:
trips_fp = open("../Hubway/trips.csv", "r")

sumx = 0
n = 0
first_line = true
for line in eachline(trips_fp)
  spl = split(chomp(line), ",")
  if first_line
    # Skip first line
    first_line = false
    continue
  end

  dur = float(spl[2])
  sumx += dur
  n += 1  
end
mean_dur = sumx / n
println(mean_dur)

close(trips_fp)