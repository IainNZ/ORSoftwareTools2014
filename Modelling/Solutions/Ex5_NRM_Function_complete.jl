### Exercise 4 - LP modelling using Julia/JuMP
# In this exercise, we're going to solve the deterministic LP 
# formulation of the network revenue management (NRM) problem.

using JuMP, Gurobi


function solveNRMProblem( legs, fareLegs, fareProbabilities, fareRevenues, 
				legCapacities, T)

	# Get the number of fares
	numFares = length(fareProbabilities)
	
	# Get the number of legs
	numLegs = length(legs)

	
	# Step 1: create the model.
	m = Model()
	
	# Step 2: create the variables
	@defVar(m, x[1:numFares] >= 0)

	# Step 3: create the constraints.
	# capacity constraints:
	for ell = 1:numLegs
		@addConstraint(m, sum{ x[f] , f = 1:numFares; ell in fareLegs[f]} <= legCapacities[ell])
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
	println("Optimal revenue is $(getObjectiveValue(m))")

end
