using JuMP
using Gurobi

r = 5
c = [1, 2]

m = Model(solver=GurobiSolver(LazyConstraints=1))
@defVar(m,-r<= x[1:2] <= r,Int)

#1. Set the objective function
#@setObjective(m,Max,...

#2. Fill in the lazy callback
function lazy(cb)
    xVal = getValue(x)
    # By making the xVal into an array, we can use the julia
    # built in norm function
    xValVec = [xVal[1] xVal[2]]
    # if norm(xValVec) > ...?
    #    ...
    #    @addLazyConstraint(cb, ...
    # end
end
setLazyCallback(m,lazy)
solve(m)
println("obj: ", getObjectiveValue(m))
println("x1: ",getValue(x[1]),", x2: ",getValue(x[2]))