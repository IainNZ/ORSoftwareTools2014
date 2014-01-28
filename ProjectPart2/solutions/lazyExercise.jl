using JuMP
using Gurobi

r = 5
c = [1, 2]

m = Model(solver=GurobiSolver(LazyConstraints=1))
@defVar(m,-r<= x[1:2] <= r,Int)
@setObjective(m,Max, c[1]*x[1] + c[2]*x[2])
function lazy(cb)
    xVal = getValue(x)
    xValVec = [xVal[1] xVal[2]]
    if norm(xValVec) > r + 1e-4
        d = xValVec/norm(xValVec)
        @addLazyConstraint(cb, d[1]*x[1] + d[2]*x[2] <= r)
    end
end
setLazyCallback(m,lazy)
solve(m)
println("obj: ", getObjectiveValue(m))
println("x1: ",getValue(x[1]),", x2: ",getValue(x[2]))