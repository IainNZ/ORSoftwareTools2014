###  1D Facility Location Problem
using JuMP

#problem data
customerLocations = [ 3, 7, 9, 10, 12, 15, 18, 20]
L, M = 25, 5

modelObj = Model()

#create x_ij variables
numCustomers = length(customerLocations)
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
@setObjective(modelObj, :Min, sum{ abs(customerLocations[iCust] - jFact) * x[iCust, jFact], iCust=1:numCustomers, jFact=1:L } )

status = solve(modelObj)
println("Status $status")

#determine locations 
isOne( j ) = getValue( y[j] ) > .9 
yVals = filter( isOne, 1:L )
println("Locations:")
println(yVals)
