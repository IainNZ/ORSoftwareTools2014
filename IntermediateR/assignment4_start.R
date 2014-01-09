# Before we start, we need to build a TRUE/FALSE variable for
# being a registered user
trips$is.registered = trips$subscription_type == "Registered"

# Fill in "var name 1" and "var name 2" 
fee.info = trips[,c("var name 1", "var name 2")]

# Input: A row of fee.info (containing duration and
#        registration status for a single trip)
# Output: The fee for the trip
get.fee = function(x) {
    duration = x["duration"]
    # Extract registration status from x, into a variable
    # is.registered
    is.registered = ...
    
    # We'll multiply the fee by the multiplier variable.
    # Change the if clause to check if is.registered is 1.
    multiplier = 1
    if ([is.registered is equal to 1]) {
        multiplier = 0.75
    }
	
    if (duration < 30) {
        return(0*multiplier)
    } else if (duration < 60) {
        # fill in this and the remaining return statements
    }
}

# Fill in the arguments of the apply() function below:
trips$fee = apply([matrix to process],
                  [1 for rows, 2 for columns],
                  [function])
