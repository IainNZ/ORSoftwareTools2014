### Exercise 3 - LP modelling using Julia/JuMP
# In this exercise, we use the facility location model
# from Exercise 2, and we iteratively add constraints to cut off
# the best solution.


using JuMP, Gurobi

# Data: locations of customers and facilities
customerLocs = [3, 7, 9, 10, 12, 15, 18, 20]
facilityLocs = [1, 5, 10, 12, 24]

K = 3 # at most 3 facilities can be opened.

# Get M and N from the location arrays.
M = length(customerLocs)
N = length(facilityLocs)

# Step 1: build the model.
m = Model(solver = GurobiSolver())

# Step 2: define the variables.
@defVar(m, 0 <= x[1:M,1:N] <= 1)
@defVar(m, y[1:N], Bin)

# Step 3a: add the constraint that the amount that facility j can serve
# customer x is at most 1 if facility j is opened, and 0 otherwise.
for i=1:M
	for j=1:N
		@addConstraint(m, x[i,j] <= y[j])
	end
end

# Step 3b: add the constraint that the amount that each customer must
# be served
for i=1:M
	@addConstraint(m, sum{ x[i,j], j=1:N} == 1)
end

# Step 3c: add the constraint that at most 3 facilities can be opened.
@addConstraint(m, sum{ y[j], j=1:N} <= K)

# Step 4: add the objective.
@setObjective(m, Min, sum{ abs(customerLocs[i] - facilityLocs[j]) * x[i,j], i=1:M, j=1:N} )

# Step 5: solve the problem!
solve(m)

# Step 6: post-process the y variables:
# - put the y values in an array
# - find the indices for which y[i] is 1
# - print those indices, and the locations of those facilities.

yvals = zeros(N,1)
for j=1:N
	yvals[j] = getValue(y[j])
end 

finalInds = find( yvals .> 0.9)

println()
println("Chosen facilities: ")
println(finalInds)
println()
println("Locations of those facilities:")
println( facilityLocs[ finalInds[:]])


# Step 7: problem modification for Exercise 3.
# We need to iteratively add constraints to 

for iter=1:3
	# Step 7a: find facility indices for which y[i] = 1 and
	# for which y[i] = 0.
	zeroInds = find ( yvals .< 0.5 )
	oneInds = find ( yvals .> 0.5 )

	# Step 7b: add constraint to remove the solution.
	@addConstraint(m, sum{ (1 - y[i]) , i in zeroInds} + sum{ y[i], i in oneInds} <= N-1)

	# Step 7c: solve the model again.
	solve(m)

	# Step 7d: write new solution results.
	yvals = zeros(N,1)
	for j=1:N
		yvals[j] = getValue(y[j])
	end 

	finalInds = find( yvals .> 0.5)
	
	println()
	println("Iteration $(iter): Objective $(getObjectiveValue(m))")
	println("Chosen facilities - $(iter+1) best: ")
	println(finalInds)
	println()
	println("Locations of those facilities:")
	println( facilityLocs[ finalInds[:]])

	
end