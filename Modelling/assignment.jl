### 15.S60 Assignment - LP modelling using Julia/JuMP
# In this assignment, we're going to assume you're planning a party,
# and you're trying to decide which of your friends to invite. Your
# party is a potluck, so you'd like to maximize the number of dishes
# that everybody brings in total. However, your friends are a peculiar
# bunch - some of them will only come if others come, some hate each
# other, and so on - and you'd like to account for their dynamics as
# well.

using JuMP, Gurobi

# Our data: a dictionary, where the keys are your friends, and the
# values are how many dishes each of them brings.
friendsFood = [ "Daenerys Targaryen"=>3, "Jorah Mormont"=>1, "Tywin Lannister"=>5, "Tyrion Lannister"=>2, "Shae"=>1, "Cersei Lannister"=>3, "Joffrey Baratheon"=>0, "Ned Stark"=>1, "Robb Stark"=>2, "Jon Snow" => 3]
friends = keys(friendsFood)

# Step 1 -- build a model.
m = Model()

# Step 2 — define variables.
@defVar(m, x[friends], Bin)

# Step 3 - define the objective.
@setObjective(m, Max, sum{ friendsFood[i] * x[i], i in friends})

# Step 3 - define constraints.
# Your apartment is small - at most seven (other) people can fit.
@addConstraint(m, sum{ x[i], i in friends } <= 7)

# If you invite Daenerys, you have to invite Jorah.
@addConstraint(m, x["Daenerys Targaryen"] <= x["Jorah Mormont"])

# Although Lannisters always pay their debts, they're a bit much to handle as a group — so you only want to invite at most two of them:
@addConstraint(m, sum{ x[i], i in friends; contains(i, "Lannister")} <= 2)

# You can only invite at most one of Robb or Tywin
@addConstraint(m, x["Robb Stark"] + x["Tywin Lannister"] <= 1)


# Step 4 - solve the model.
solve(m)

# Step 5 - post processing.
# Get values of binary variables.
xvals = Dict()
for i in friends
	xvals[i] = getValue(x[i])
end

# Figure out which friends are coming
isAtParty(i) = xvals[i] > 0.5
partyFriends = filter(isAtParty, collect(friends))

# Output the invite list:
println()
println("*** PARTY INVITATION LIST ***")
println(partyFriends)



