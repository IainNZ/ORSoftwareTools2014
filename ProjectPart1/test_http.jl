#############################################################################
# MIT 15.S60
# Software Tools for Operations Research
# IAP 2014
#############################################################################
# NameService
# A simple web service that, when given a name, inserts the name into
# a message and returns it back to the user
#
# This is the short version of "solution" file.
#############################################################################

using HttpServer
function nameservice(req::Request, res::Response)
    if ismatch(r"/nameservice/", req.resource)
        req_split = split(req.resource, "/")
        if length(req_split) != 3
            return Response(400, "Error: too many arguments!")
        end
        return Response("Hey there $(req_split[3]), it worked!")
    end
    return Response(404, "We don't do that...")
end
run(Server(HttpHandler(nameservice)), 8000)