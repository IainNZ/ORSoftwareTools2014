###  1D Facility Location Problem
###  Exercise 1a - baby steps: change code so that facility locations are not at 1:L, but rather, at random uniform locations on [0,100]

using JuMP

#problem data
customerLocations = [ 3, 7, 9, 10, 12, 15, 18, 20]
facilityLocations = 100 * rand(25,1)
println(facilityLocations)
L, M = 25, 5

modelObj = Model(:Min)

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
@setObjective(modelObj, sum{ abs(customerLocations[iCust] - facilityLocations[jFact]) * x[iCust, jFact], iCust=1:numCustomers, jFact=1:L } )

status = solve(modelObj)
println("Status $status")

#determine locations 
isOne( j ) = getValue( y[j] ) > .9 
yVals = filter( isOne, 1:L )
println("Facilities:")
println(yVals)
