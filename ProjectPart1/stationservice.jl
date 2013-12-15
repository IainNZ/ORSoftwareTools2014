#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# StationService
# A webservice that takes four lat-lon points and returns the names of all
# stations inside that box.
#############################################################################

using HttpServer
using SQLite

# Create, load the database
SQLite.connect("stations.sqlite")


function nameservice(req::Request, res::Response)
    println(req.resource)
    
    if ismatch(r"/stationservice/", req.resource)
        req_split = split(req.resource, "/")
        println(req_split)

        # We are expecting the length of req_split to be 6:
        # * Before the first slash (empty string)
        # * stationservice
        # * latL
        # * latR
        # * lonL
        # * lonR
        if length(req_split) != 6
            return Response(400, "Error: wrong number of arguments!")
        end

        # Attempt to parse the arguments
        latL = 0.0
        latR = 0.0
        lngL = 0.0
        lngR = 0.0
        try
          latL = float(req_split[3])
          latR = float(req_split[4])
          lngL = float(req_split[5])
          lngR = float(req_split[6])
        catch
            return Response(400, "Error: couldn't parse arguments!")
        end

        # Build SQL query
        sql_query = "SELECT name FROM stations WHERE ( lat >= $latL AND lat <= $latR ) AND ( lng >= $lngL AND lng <= $lngR )"

        # Run the query
        results = query(sql_query)
        println(results)

        # Return results
        if size(results, 1) == 0
            return Response("No results")
        else
            ret_str = "$(size(results,1)) results:"
            for i in 1:size(results, 1)
                ret_str = string(ret_str, "<br>$(results[i,:name])")
            end
            return Response(ret_str)
        end

    else
        # User requested something that we don't do!
        # Return 404 NOT FOUND
        return Response(404, "We don't do that...")
    end
end

# Create and start the server
http = HttpHandler(nameservice)
server = Server(http)
run(server, 8000)

# http://localhost:8000/stationservice/42.34/42.341/-71.11/-71.1
# 2 results:
# Colleges of the Fenway
# Longwood Ave/Riverway