using SQLite

db = SQLite.connect("hubway.sqlite")
createtable("../Hubway/stations.csv", db, name="stations", 
            delim=',', header=true)
createtable("../Hubway/trips.csv", db, name="trips", 
            delim=',', header=true)