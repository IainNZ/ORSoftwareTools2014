###  2D Facility Location Problem
###  Exercise 2 — problem modification: solve the problem several times (currently 
###  hardcoded at 3), each time adding a constraint that cuts out the current selection of 
###  facility locations.
using JuMP



function createAndSolveFLProblem( customerLocations, facilityLocations, M, L)

	modelObj = Model(:Min)

	#create x_ij variables
	numCustomers = length(customerLocations[:,1])
	println("numCustomers $numCustomers")
	@defVar(modelObj, 0 <= x[1:numCustomers, 1:L] <= 1 )

	#create the yj variables
	@defVar(modelObj, y[1:L], Bin)

	#can't serve a customer unless open a factory
	for iCust in 1:numCustomers
    		for jFact in 1:L
		       	@addConstraint(modelObj, x[iCust, jFact] <= y[jFact] )
    		end
	end

	#every customer must be served
	for iCust in 1:numCustomers
	    @addConstraint(modelObj, sum{ x[iCust, jFact], jFact = 1:L } == 1 )
	end

	#max Factories
	@addConstraint(modelObj, sum{y[jFact], jFact = 1:L} <= M )

	#objective
	#distanceMatrix = [ norm(customerLocations[iCust, :] - facilityLocations[jFact,:]) for iCust = 1:numCustomers, jFact = 1:L]
	@setObjective(modelObj, sum{ norm(customerLocations[iCust,:] - facilityLocations[jFact,:]) * x[iCust, jFact], iCust=1:numCustomers, jFact=1:L } )


	for k in 1:3
		status = solve(modelObj)
		println("Status of solve $k : $status")
	
		#determine locations 
		isOne( j ) = getValue( y[j] ) > .9 
		yVals = filter( isOne, 1:L )
		println("Facilities after solve $k :")
		println(yVals)
		# Get the locations that were NOT selected.
		notyVals = setdiff(1:L, yVals)

		# Now, add the constraint:
		@addConstraint(modelObj, sum{y[jFact], jFact in yVals} + sum{1 - y[jFact], jFact in notyVals} <= L - 1)

				
	end
end



#problem data
customerLocations = [55 68; 23 96; 56 98; 54 76; 24 90; 59 1; 86 68; 36 93; 40 42; 90 83]
facilityLocations = [1:8] * [10 10]
println(facilityLocations)
L, M = 8, 3

modelObj = createAndSolveFLProblem( customerLocations, facilityLocations, M, L)
