using SQLite

db = SQLite.connect("stations.sqlite")
createtable("../Hubway/stations.csv", db, name="stations", 
            delim=',', header=true)
