using SQLite

# Open a connection to our database
db = SQLite.connect("hubway.sqlite")

# Lets to the example from the homework first
# The query is just an ordinary string
# The result is a Julia DataFrame, they are like R's dataframes
# but the syntax is a bit different
result = query("SELECT * FROM stations WHERE name LIKE '%MIT%'")
println("MIT Stations")
for i in 1:size(result,1)
    println("#$(i) [ID $(result[i,:id])]: $(result[i,:name])")
end

# Lets try getting the duration of trips to an MIT station
# We want to join the two databases on:
#  trips: end_station
#  stations: id
query_str = "SELECT duration FROM"
query_str = query_str * " trips INNER JOIN stations"
query_str = query_str * " ON trips.start_station = stations.id"
query_str = query_str * " WHERE stations.name LIKE '%MIT%'"
result = query(query_str)
println(result)