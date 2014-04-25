# Input: vector of durations
# Output: proportion of durations >= 30
# Hint: recall that the mean of a TRUE/FALSE vector is the
#       proportion that are TRUE. For instance,
#       mean(trips$Gender == "Male") is the proportion of
#       trips taken by males.



prop.above.30 = function(durations) {
  # Add the expression to compute the proportion of durations
  # >= 30
  return(mean(durations >= 30))
}



# After this, you would run in the console (with appropriate
# values filled in):

# tapply([data], [category], [function])







most.common = function(x) {
  if (sum(x == "Registered") > sum(x == "Casual")) {
    return("Registered")
  } else if (sum(x == "Registered") < sum(x == "Casual")) {
    return("Casual")
  } else {
    return("Tie")
  }
}
