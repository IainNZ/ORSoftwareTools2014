# Before we start, we need to build a TRUE/FALSE variable for
# being a registered user
trips$is.registered = trips$subscription_type == "Registered"

# Fill in "var name 1" and "var name 2" 
fee.info = trips[c("var name 1", "var name 2")]

# Input: A row of fee.info (containing duration and
#        registration status for a single trip)
# Output: The fee for the trip
get.fee = function(x) {
  # We’ll multiply the fee by the multiplier variable.
  # Change the if clause to check if is.registered is 1.
  multiplier = 1
  if (x["is.registered"] == 1) {
    multiplier = 0.75
  }

  if (x["duration"] < 30) {
    return(0*multiplier)
  } else if (x["duration"] < 60) {
    return(2*multiplier)
  } else if (x["duration"] < 420) {
    return((8*floor(x["duration"]/30)-10)*multiplier)
  } else {
    return(100*multiplier)
  }
}

# Fill in the arguments of the apply() function below:
trips$fee = apply([matrix to process],
                  [1 for rows, 2 for columns],
                  [function])
