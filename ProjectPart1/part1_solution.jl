#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# Solution to first two questions at end of first half of class.
# This is the "solution" file - don't cheat :)
#############################################################################

using HttpServer

function myservices(req::Request, res::Response)
    if ismatch(r"/nameservice/", req.resource)
        req_split = split(req.resource, "/")
        if length(req_split) != 3
            return Response(400, "Error: too many arguments!")
        end
        user_name = req_split[3]
        message_id = rand(1:3)
        if message_id == 1
            return Response("<b>Hey there $(user_name)!</b>")
        elseif message_id == 2
            return Response("<b>Lookin' good $(user_name)!</b>")
        else
            return Response("<b>KILL ALL HUMANS INCLUDING $(user_name)!</b>")
        end
    elseif ismatch(r"/addservice/", req.resource)
        req_split = split(req.resource, "/")
        if length(req_split) != 4
            return Response(400, "Error: wrong number of arguments!")
        end
        first_num = 0.0
        second_num = 0.0
        try
            first_num = float(req_split[3])
            second_num = float(req_split[4])
        catch
            return Response(400, "Error: expected numbers!")
        end
        return Response("$(first_num + second_num)")
    else
        # User requested something that we don't do!
        # Return 404 NOT FOUND
        return Response(404, "We don't do that...")
    end
end

http = HttpHandler(myservices)
server = Server(http)
run(server, 8000)