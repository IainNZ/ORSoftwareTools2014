using SQLite

db = SQLite.connect("stations.sqlite")
result = query("SELECT * FROM stations WHERE name LIKE '%MIT%'")
println("MIT Stations")
for i in 1:size(result,1)
    println("#$(i) [ID $(result[i,:id])]: $(result[i,:name])")
end
