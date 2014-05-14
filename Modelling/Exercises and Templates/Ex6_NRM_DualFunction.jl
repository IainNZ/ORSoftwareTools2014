### Exercise 6 - LP modelling using Julia/JuMP
# In this exercise, we need to modify the solveNRMProblem function
# from Exercise 5 so that it outputs the dual prices as well as the
# objective value.

using JuMP, Gurobi


function solveNRMProblem( legs, fareLegs, fareProbabilities, fareRevenues, 
				legCapacities, T)

	# Get the number of fares
	numFares = length(fareProbabilities)
	
	# Get the number of legs
	numLegs = length(legs)

	
	# Step 1: create the model.
	m = Model(solver = GurobiSolver(OutputFlag = 0))
	
	# Step 2: create the variables
	@defVar(m, x[1:numFares] >= 0)

	# Step 3: create the constraints.
	
	# capacity constraints:
	# — fill in below -
	@defConstrRef ...

	for ell = 1:numLegs
		... = @addConstraint(m, sum{ x[f] , f = 1:numFares; ell in fareLegs[f]} <= legCapacities[ell])
	end
	
	# expected number of fares constraints:
	for f = 1:numFares
		@addConstraint(m, x[f] <= fareProbabilities[f] * T)
	end
	
	# Step 4: set the objective (total revenue)
	@setObjective(m, Max, sum{ fareRevenues[f] * x[f], f = 1:numFares} )
	
	# Step 4: solve the model!
	solve(m)
	
	# Step 5: write the optimal revenue:
	#println("Optimal revenue is $(getObjectiveValue(m))")

	# Step 6: retrieve the dual information.
	# — fill in below
	dualVec = ...
	for ell = 1:numLegs
		dualVec[ell] = ...
	end
	
	# Step 7: return the vector of dual variables, followed by the objective value.
	return ..., ...

end
