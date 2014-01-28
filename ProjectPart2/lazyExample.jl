using JuMP
using Gurobi

m = Model(solver=GurobiSolver(LazyConstraints=1))
@defVar(m,x[1:2],Bin)
@setObjective(m,Max, x[1] + 2*x[2])
#@setObjective(m,Max, x[1] - 2*x[2])
function lazy(cb)
    println("checking lazy")
    xVal = getValue(x)
    if xVal[1] + xVal[2] > 1 + 1e-4
        println("lazy violated")
        @addLazyConstraint(cb, x[1] + x[2] <= 1)
    end
end
setLazyCallback(m,lazy)
solve(m)