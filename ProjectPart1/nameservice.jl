#############################################################################
# Software Tools for Operations Research
#############################################################################
# NameService
# A simple web service that, when given a name, inserts the name into
# a message and returns it back to the user
#############################################################################

# Required package: HTTPServer
using HttpServer

# Build a request handler (HttpHandler)
# The "constructor" for a HttpHandler takes one argument, which is a
# function that determines the action taken when someone contacts our
# server. In Julia we could write this in two ways. First, we could
# write:
#   function myHandler(req::Request, res::Response)
#       # ...
#   end
#   http = HttpHandler(myHandler)
#
# A possibly more visually appealing way to write this would be to use
# Julia's "do" block:
#
#   http = HttpHandler() do req::Request, res::Response
#     # ...
#   end
#
# which creates an anonymous function and passes it as the first argument
# of HttpHandler. We'll use the first one to make things simpler.

function nameservice(req::Request, res::Response)
    # * req contains details about the incoming request, e.g. the URL
    # * res contains details about our response. We will be writing
    #   a simple server so we will just return our response directly

    # First check if the the request is of the correct type
    println(req.resource)
    # Note that the first part of our ismatch call is a "regex"
    # Regexs are in pretty much every programming langauge as well
    # as many command line tools, but they are out of the scope of
    # this class. We are just doing a simple match, so we don't
    # need anything fancy.
    if ismatch(r"/nameservice/", req.resource)
        # Great, we support this service!

        # We expect the user's name to appear right after the second
        # forward slash, so lets split the request on the slashes
        req_split = split(req.resource, "/")

        # For debugging purposes, lets look at whats in the split
        println(req_split)

        # We are expecting the length of req_split to be 3:
        # * Before the first slash (empty string)
        # * NameService
        # * The name
        # If it isn't, e.g. /nameservice/iain/junk, lets return
        # error code 400 BAD REQUEST
        if length(req_split) != 3
            return Response(400, "Error: too many arguments!")
        end

        user_name = req_split[3]

        # Build our response string
        # We'll include a bit of HTML to make it bold
        return Response("<b>Hey there $(user_name)!</b>")
    else
        # User requested something that we don't do!
        # Return 404 NOT FOUND
        return Response(404, "We don't do that...")
    end
end

# Create our HttpHandler
http = HttpHandler(nameservice)

# Create a Server that uses our HttpHandler
server = Server(http)

# We'll run our Server on port 8000
# You can access it by going to your browser and going
# to http://localhost:8000/...
# e.g. 
#  http://localhost:8000/nameservice/Iain
#  http://localhost:8000/nameservice/Bad/Extra/Junk
#  http://localhost:8000/catpictures
run(server, 8000)