using Base.Test
include("tspSolver.jl")

function buildInstance(points)
    n = size(points,1)
    return [norm(points[i,1:2] - points[j,1:2]) for i=1:n, j=1:n]
end

coors = [0.0 0.0;
         1.0 0.0;
         0.0 1.0]
         

weights = buildInstance(coors)

(actual_solution,tour) = solveTsp(weights)
println(tour)
expected_solution = 1+1+sqrt(2)

@test_approx_eq_eps actual_solution expected_solution 1e-4


coors2 = [0.0 0.0;
          1.0 0.0;
          0.0 1.0;
          1.0 1.0;
          101.0 0.0;
          101.0 1.0;
          102.0 0.0;
          102.0 1.0]

weightedGraph2 = buildInstance(coors2)
(actual2, tour2) = solveTsp(weightedGraph2)
println(tour2)

#without cutset callback, will get 4+4
#expected2 = 4+4
expected2 = 100+100+3+3

@test_approx_eq_eps actual2 expected2 1e-4
