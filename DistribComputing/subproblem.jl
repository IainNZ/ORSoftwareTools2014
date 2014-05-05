# Code for solving the second-stage subproblem,
# included from master.jl.

import GZip
using JuMP
#using Clp
using Gurobi

# converts a time "HH:MM:SS" into the number of seconds since midnight
function secs(str)
    h,m,s = split(strip(str,['\n','"',' ']),":")
    return 3600*int(h) + 60*int(m) + int(s)
end

function loadday(date)
    fd = GZip.open(joinpath("tripsbydate","$date.csv.gz"))

    stationstart = Int[] # station ID
    stationend = Int[]
    timestart = Int[] # seconds since midnight
    timeend = Int[]
    
    readline(fd) # skip the header
    for line in eachline(fd)
        in(',',line) || continue
        ss, se, ts, te = split(line,",")
        push!(stationstart, int(ss))
        push!(stationend, int(se))
        push!(timestart, secs(ts)) 
        push!(timeend, secs(te))
    end
    return (stationstart, stationend, timestart, timeend)
end

function calculateNetFlows(S,cutoffs, stationstart, stationend, timestart, timeend)
    cutoffs = [cutoffs, 100000]
    T = length(cutoffs)
    period(t) = (i = 1; while t > cutoffs[i]; i+=1; end; i)
    @assert length(stationstart) == length(stationend) == length(timestart) == length(timeend)
    netFlowPerPeriod = [ [ s => 0 for s in S ] for i in 1:T ]
    
    stationsThisPeriod = Set{Int}()
    for i in 1:length(stationstart)
        netFlowPerPeriod[period(timestart[i])][stationstart[i]] -= 1
        netFlowPerPeriod[period(timeend[i])][stationend[i]] += 1
        push!(stationsThisPeriod,stationstart[i])
        push!(stationsThisPeriod,stationend[i])
    end

    m = maximum([maximum([abs(netFlowPerPeriod[i][s]) for s in S]) for i in 1:T])
    println("Max net flow: $m")

    return stationsThisPeriod, netFlowPerPeriod

end

function genCostMatrix()
    table, header = readcsv("../Hubway/stations.csv", has_header=true)
    S = int(table[:,1])
    locations = [ S[i] => [table[i,3],table[i,4]] for i in 1:size(table,1) ]

    costMatrix = [ s => Dict{Int,Float64}() for s in S ]
    for s in S
        for q in S
            costMatrix[s][q] = norm(locations[s]-locations[q])
        end
    end

    return S, costMatrix

end

# solve min-cost optimal "shuffling" problem as a network LP
# S is the set of station IDs
# directedCostMatrix[a][b] is the cost of moving one bike from station with index a to station with index b
# netFlowPerPeriod[t][a] is the net bicycle flow into station (from trips) a during time period t
# totalBikes is the total number of bicycles in the system today
# stationCapacity is the capacity of each station
function networkLP(S, directedCostMatrix, netFlowPerPeriod, totalBikes, stationCapacities, verbose = false)

    T = length(netFlowPerPeriod)
    #m = Model(solver=ClpSolver())
    m = Model(solver=GurobiSolver(Threads=1,InfUnbdInfo=1,OutputFlag=0,Method=1))
    # flow from "source" node into each station
    @defVar(m, fsource[S] >= 0)
    # flow from last exit nodes into "sink"
    @defVar(m, fsink[S] >= 0)
    
    # we enforce station capacity constraints by introducing an entry and exit node for each station
    # (entry node s,t) ===> (exit node s,t)   
    @defVar(m, fcap[s=S, 1:T] >= 0)

    @defConstrRef capacityConstraint[S,1:T]
    for s in S
        for t in 1:T
            capacityConstraint[s,t] = 
                @addConstraint(m, fcap[s,t] <= stationCapacities[s])
        end
    end

    # flow from one station to another between time period t and t+1
    @defVar(m, fshuffle[S, S, 1:(T-1)] >= 0)
    
    # balance constraints:
    # total number of bikes:
    @addConstraint(m, sum{ fsource[s], s=S } == totalBikes)
    @addConstraint(m, sum{ fsink[s], s=S } == totalBikes)
    # balance at entry nodes for t = 1
    for s in S
        @addConstraint(m, fsource[s] == fcap[s,1])
    end
    
    # balance at exit nodes for t = 1,...,T-1
    for t in 1:(T-1)
        for s in S
            @addConstraint(m, sum{ fshuffle[s,k,t], k = S } - fcap[s,t] == netFlowPerPeriod[t][s])
        end
    end
    
    # balance at entry nodes for t = 2,...,T
    for t in 2:T
        for s in S
            @addConstraint(m, sum{ fshuffle[k,s,t-1], k = S } == fcap[s,t])
        end
    end
    
    # balance at exit nodes for t = T
    for s in S
        @addConstraint(m, fsink[s]-fcap[s,T] == netFlowPerPeriod[T][s])
    end
    
    @setObjective(m, Min, sum{ directedCostMatrix[s][k]*fshuffle[s,k,t], 
        s = S, k = S, t = 1:(T-1)})

    status = solve(m)
    val = 0.0
    
    if status == :Optimal
        val = getObjectiveValue(m)
        if verbose
            println(getValue(fsource))
            println(getValue(fsink))
            for t in 1:(T-1)
                println("At period $t:")
                for s in S
                    for k in S
                        v = getValue(fshuffle[s,k,t])
                        if abs(v) > 1e-7
                            if k == s
                                #println("Keep $v at station $s")
                            else
                                println("Shuffle $v from station $s to station $k")
                            end
                            #println(directedCostMatrix[s][k])
                        end
                    end
                end
            end
            println("Optimal objective is: ", getObjectiveValue(m))
        end
    end


    # return a subgradient with respect to the station capacities
    subgrad = [s => 0.0 for s in S]
    for t in 1:T
        for s in S
            du = getDual(capacityConstraint[s,t])
            @assert du < 1e-6
            subgrad[s] += du
            val -= du*stationCapacities[s]
        end
    end

    if status == :Infeasible
        negval = val
        # compute ray value
        val = dot(m.linconstrDuals,[JuMP.rhs(c) for c in m.linconstr])
        #println("VAL: $val")
        @assert val > 1e-5
        val += negval
    end

    return status, subgrad, val

end


function test()
    S = [1,2]
    costMatrix = {[0.0, 1.0],[1.0,0.0]}
    flow = { [ -1, 0], [0, 1] }
    totalBikes = 2
    capacities = [2,2]
    networkLP(S, costMatrix, flow, totalBikes, capacities)
end


function test(date,cutoffs, totalBikes)
    S, costMatrix = genCostMatrix()
    day = loadday(date)
    stationsThisPeriod, netFlowPerPeriod = calculateNetFlows(S, cutoffs, day...)
    println(length(stationsThisPeriod), " stations")
    capacities = [ s => 35 for s in S ]
    networkLP(stationsThisPeriod,costMatrix,netFlowPerPeriod,totalBikes,capacities)

end

test()
#test("2012-07-05", [43200], 800)
#test("2012-07-05", [36000,57600, 72000], 400)
#test("2012-07-05", [i*60^2 for i in 1:23], 200)
#@time test("2012-07-05", [i*60^2 for i in 1:23], 200)


