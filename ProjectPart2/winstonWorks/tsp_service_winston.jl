#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# StationService
#
# A webservice that takes four lat-lon points and returns an image of
# the shortest tour visiting every station inside the box.
#############################################################################

using HttpServer
using SQLite

# Provides the type FileResponse
using HttpCommon
# Uncomment out when the TSP solver is ready
include("tspSolver.jl")


# Create, load the database
SQLite.connect("hubway.sqlite")

function tspservice(req::Request, res::Response)
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
        sql_query = "SELECT name, lat, lng FROM stations WHERE ( lat >= $latL AND lat <= $latR ) AND ( lng >= $lngL AND lng <= $lngR )"

        # Run the query
        results = query(sql_query)
        # Return results
        N = size(results, 1)
        println("Stations in query: ", N)
        if N < 3
            return Response(400, string("Need at least 3 cities to form a tour, but query had: ",N))
        else
            latlngs = zeros(N, 2)
            for i in 1:N
                latlngs[i,1] = float(results[i,:lat])
                latlngs[i,2] = float(results[i,:lng])
            end
            mat = getDistMatrix(latlngs)
            (optDist,tour) = solveTsp(mat)
            println("Optimal tour: ", optDist/1000.0,"km")
            plotTour(tour,latlngs,"tour.png")
            return FileResponse("tour.png")
            # to instead get a text representation, use the code below.
            # If we want to just return the stations
            #ret_str = "$(size(results,1)) results:"
            #for i in 1:size(results, 1)
            #    ret_str = string(ret_str, "<br>$(results[i,:name])")
            #end
            #ret_str = string(ret_str,tour)
            #return Response(ret_str)
        end

    else
        # User requested something that we don't do!
        # Return 404 NOT FOUND
        return Response(404, "We don't do that...")
    end
end

# Computes the approximate distance between two points rounded to the nearest
# meter. Assumes that the points are near a latitude of 40 degrees.
function distance(lat1, lng1, lat2, lng2)
    yDist = 111000*(lat2 - lat1)
    xDist = 85000*(lng2 - lng1)
    return iround(sqrt(yDist^2 + xDist^2))
end

# Input: an n x 2 matrix of latitude longitude pairs.
# Output a symmetric n x n matrix of distances rounded to the nearest meter.
function getDistMatrix(points)
    n = size(points,1)
    return [distance(points[i,1],points[i,2],points[j,1],points[j,2]) for i=1:n, j=1:n]
end



# Create and start the server
http = HttpHandler(tspservice)
server = Server(http)
run(server, 8000)

# Go the url below to see all the stations in a single tour:
# http://localhost:8000/stationservice/42.3/42.4/-71.2/-71.0
