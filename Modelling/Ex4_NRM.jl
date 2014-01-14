### 15.S60 Exercise 4 - LP modelling using Julia/JuMP
# In this exercise, we're going to solve the deterministic LP 
# formulation of the network revenue management (NRM) problem.

using JuMP, Gurobi

# Data: the legs, the array of tuples to tell us which legs each fare consumes,
# the probability of each fare, the revenue from each fare, the capacity of each leg
# and the length of the time horizon.
legs = [1, 2, 3, 4, 5, 6]
fareLegs = [ (1), (2), (3), (4), (5), (6), (1,4), (1,5), (1,6), (2,4), (2,5), (2,6), (3,4), (3,5), (3,6)]
fareProbabilities = [0.06, 0.096, 0.046, 0.073, 0.159, 0.067, 0.043, 0.019, 0.112, 0.075, 0.031, 0.044, 0.012, 0.0210, 0.1130]
fareRevenues = [40, 30, 30, 10, 40, 10, 190, 80, 90, 70, 60, 190, 60, 50, 10]
legCapacities = [20, 20, 20, 20, 20, 20]
T = 100

# Get the number of fares
numFares = ...

# Get the number of legs
numLegs = ...


# Step 1: create the model.
m = Model()

# Step 2: create the variables
@defVar(m, x[1:numFares] >= 0)

# Step 3: create the constraints.
# capacity constraints:
for ell = 1:numLegs
	@addConstraint(m, ... <= ...)
end

# expected number of fares constraints:
for f = 1:numFares
	@addConstraint(m, ...)
end

# Step 4: set the objective (total revenue)
@setObjective(m, Max, ... )


# Step 4: solve the model!
solve(m)

# Step 5: write the optimal revenue:
println("Optimal revenue is $(getObjectiveValue(m))")