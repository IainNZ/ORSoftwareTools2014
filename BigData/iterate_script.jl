# In this file we will be exploring different ways to open a file

# First, we can simply load in a file all at once as one big string
bigchunk = readall("../Hubway/stations.csv")
# This will be about as big as memory usage as the file is big

# That isn't too useful. What would be more useful would be to have
# an array where each entry is a line of the file.
station_fp = open("../Hubway/stations.csv", "r")
alllines = readlines(station_fp)
close(station_fp)
alllines[1]
alllines[end]

# We can then manually parse each line to extract the fields
spl = split(alllines[1], ",")
# Notice that \n at end? That is the "enter" or "newline"
spl = split(chomp(alllines[1]), ",")
# Thats better

# Lets calculate the minimum and maximum latitudes and longitudes
min_lat = Inf
max_lat = -Inf
min_lon = Inf
max_lon = -Inf

for i = 2:length(alllines)
  spl = split(chomp(alllines[i]), ",")
  lat = float(spl[3])
  min_lat = min(min_lat, lat)
  max_lat = max(max_lat, lat)

  lon = float(spl[4])
  min_lon = min(min_lon, lon)
  max_lon = max(max_lon, lon)
end

# Check out the values

# Now how can we do this in a more medium data friendly way, e.g.
# the file is 20 GB - we can't load that into memory all at once!
# By default, programming languages never load all a file into memory
# at once - instead, they maintain a pointer to somewhere in the file
# You can think of it as reading a book by moving your finger along
# the lines.
# Usually we want one line at a time, and Julia conveniently provides
# a function eachline() that we can use in loops:

station_fp = open("../Hubway/stations.csv", "r")
for line in eachline(station_fp)
  # Split it up
  spl = split(chomp(alllines[i]), ",")
  # Check it isn't the header!
  if spl[1] == "id"
    println("Header")
    continue
  end
  # Then we can do the same thing as before
end

# This way we never have much more in memory than the current line we
# are dealing with - we can handle almost arbitrary size files.