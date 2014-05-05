# This file, together with subproblem.jl was built as a case
# study on how to use the parallel computing facilities of
# Julia to solve a large scale data-driven optimization 
# problem by applying Benders (or, L-shaped) decomposition.

# The model is a capacity planning problem for the Hubway
# bicycle sharing system, that is, to decide how to optimally
# reallocate capacity (bicycle parking spots) across the network.
# For tractability, we consider capacity of each Hubway station
# to be continuous. The objective we minimize are the expected
# total costs of "reshuffling" bikes across the network, an operation
# that the system operators continuously perform in order to rebalance
# the network when a station becomes completely full or empty.
# As an approximation of the expected value, we use the average over
# each historical day (the dataset contains 327 days) as "scenarios"
# in a two-stage stochastic programming formulation.

# The content of this code and a formal description of the model used
# are beyond the scope of the High-performance and Distributed Computing
# module.


require("subproblem.jl")

const weight = 100

@everywhere networkLP(args) = networkLP(args...)

function master(dates, cutoffs, totalBikes)
    S, costMatrix = genCostMatrix()
    # preprocess each date:
    dateinfo = Dict()
    for d in dates
        dat = loadday(d)
        dateinfo[d] = calculateNetFlows(S, cutoffs, dat...)
    end

    m = Model()
    @defVar(m, cap[S] >= 0)
    @defVar(m, theta[dates] >= 0 )
    @setObjective(m, Min, sum{ cap[s], s = S } + 
        weight*(1/length(dates))*sum{ theta[d], d = dates })

    ub = Inf
    lb = -Inf
    niter = 0
    while ub - lb > 1e-4
        solve(m)
        niter += 1
        println("SOLVED $niter")
        lb = getObjectiveValue(m)
        currentCapacities = [s=>getValue(cap[s]) for s in S]
        ub = sum([currentCapacities[s] for s in S])
        args = {}
        for d in dates
            stationsThisPeriod, netFlow = dateinfo[d]
            push!(args, (stationsThisPeriod, costMatrix, netFlow, totalBikes, currentCapacities))
        end
        # solve subproblems in parallel
        results = pmap(networkLP,args)
        # process results
        for (i,d) in enumerate(dates)
            stationsThisPeriod, netFlow = dateinfo[d]
            status, subgrad, objval = results[i]
            if status == :Optimal
                #println("OPT")
                # subgradient cut
                # f_d(cap) >= f_(cap') + subgrad(cap').(cap-cap')
                @addConstraint(m, 
                    theta[d] >= objval + sum{ subgrad[s]*(cap[s]-currentCapacities[s]),
                        s = stationsThisPeriod })
                ub += weight*(1/length(dates))*objval
            elseif status == :Infeasible
                #println("INFEAS")
                # feasibility cut
                # ray(cap').cap <= 0
                @addConstraint(m, objval +
                    sum{ subgrad[s]*cap[s], s = stationsThisPeriod} <= 0 )
                ub = Inf
            end
        end
        println("LB: $lb, UB: $ub")
    end
    println(getValue(cap))

end

function run()
    dates = [split(s,'.')[1] for s in readdir("tripsbydate")]
    cutoffs = [i*60^2 for i in 1:23] # reshuffle every hour
    totalBikes = 500
    master(dates[1:10], cutoffs,totalBikes)


end

@time run()
