using JuMP
using MathProgBase
using Gurobi

# Inputs: A square, symetric matrix that is zero on the diagonal.
# Result: a tuple containing the distance of the min-distance tour and the
#         order that the cities in were visited to obtain the min-distance tour.
function solveTsp(distance)
    m = Model(solver=GurobiSolver(LazyConstraints=1))
    n = size(distance,1)
    @defVar(m,x[1:n,1:n],Bin)
    #1. Objective
    @setObjective(m,Min,sum{distance[i,j]*x[i,j], i=1:n,j=i+1:n})

    # 2. Account for extra variables
    # Make x_ij and x_ji be the same thing (undirectional)
    # Don't allow self-arcs
    for i = 1:n
        @addConstraint(m, x[i,i] == 0)
        for j = (i+1):n
            @addConstraint(m, x[i,j] == x[j,i])
        end
    end

    #3. Degree Constraints
    # For each vertex, add a constraint giving it a degree of two.
    for i=1:n
        @addConstraint(m,sum{x[i,j],j=1:n} == 2)
    end

    # 5. Cutset constraints
    # (Moved above step 4. solve())
    function cutset(cb)
        edgeVals = getValue(x)
        components = connectedComponents(edgeVals)
        if length(components) > 1
            for i = 1:(length(components)-1)
                @addLazyConstraint(cb,sum{x[l,r], l=components[i], r=1:n; !in(r,components[i])} >= 2)
            end
        end
    end
    setLazyCallback(m,cutset)

    #4. Solution.
    solve(m)
    return getObjectiveValue(m), extractCycle(getValue(x),1)
end

# Inputs:
#   degreeTwoIncidenceMatrix: a symmetric, n x n, 0-1 matrix, where x_ij = 1
#                             indicates an edge bewteen i and j.  It is assumed
#                             that every node in the implied graph has degree 2.
# Result: the list of cycles that make up the graph, where each cycle is
#         represented as a set of nodes.
# Example usage:
# degreeTwoIncidenceMatrix = [0 1 1 0 0 0;
#                             1 0 1 0 0 0;
#                             0 1 1 0 0 0;
#                             0 0 0 0 1 1;
#                             0 0 0 1 0 1;
#                             0 0 0 0 1 1]
# connectedComponents(degreeTwoIncidenceMatrix)
#     => [{1,2,3},{4,5,6}]
function connectedComponents(degreeTwoIncidenceMatrix)
    cycleList = IntSet[]
    usedNodes = IntSet()
    n = size(degreeTwoIncidenceMatrix,1)
    for i = 1:n
        if !in(i, usedNodes)
            component = IntSet(extractCycle(degreeTwoIncidenceMatrix,i)...)
            union!(usedNodes,component)
            push!(cycleList,component)
        end
    end
    return cycleList
end

# Inputs:
#   degreeTwoIncidenceMatrix: a symmetric, n x n, 0-1 matrix, where x_ij = 1
#                             indicates an edge bewteen i and j.  It is assumed
#                             that every node in the implied graph has degree 2.
#   start: a node in [1..n] to begin at
# Result: the cycle in the graph containing the node start, as a list of nodes.
# Example usage:
# degreeTwoIncidenceMatrix = [0 1 1 0 0 0;
#                             1 0 1 0 0 0;
#                             0 1 1 0 0 0;
#                             0 0 0 0 1 1;
#                             0 0 0 1 0 1;
#                             0 0 0 0 1 1]
# start = 4
# extractCycle(degreeTwoIncidenceMatrix,start)
#     => [5 6 4]
function extractCycle(degreeTwoIncidenceMatrix,start)
    cycle = [start]
    blocked = start
    head = nextNode(degreeTwoIncidenceMatrix,start,blocked)    
    while head != start
        push!(cycle,head)
        oldHead = head
        head = nextNode(degreeTwoIncidenceMatrix,head,blocked)
        blocked = oldHead
    end
    return cycle
end

# Used in extractCycle, not important
function nextNode(degreeTwoIncidenceMatrix,start,blocked)
    n = size(degreeTwoIncidenceMatrix,1)
    for i = 1:n
        if abs(degreeTwoIncidenceMatrix[start,i] - 1) <1e-4 && i != blocked
            return i
        end
    end
    throw(DomainError())
end