using JuMP
using MathProgBase
using Gurobi
using Winston

# Inputs:
#    coors: the x-y coordinates for a list of cities
#    tour: A list of integers indicating the the order the cities should
#          be visited in.
#    fileName: where an image file visualizing the tour will be written.
# Example usage:
#   plotTour([2,1,3], [0 0; 0 1; 1 0],"example.png")
#   a tour would be drawn visiting the cities:
#   (0,1) => (0,0) => (1,0) => (0,1)
#
#   Note that the tour was automatically closed.
function plotTour(tour,coors,fileName)
    x = coors[tour,2]
    push!(x,x[1])
    y = coors[tour,1]
    push!(y,y[1])
    plot(x,y,"b-o")
    file(fileName)
end

# Inputs: A square, symetric matrix that is zero on the diagonal.
# Result: a tuple containing the distance of the min-distance tour and the
#         order that the cities in were visited to obtain the min-distance tour.
function solveTsp(distance)
    m = Model(solver=GurobiSolver(LazyConstraints=1))
    n = size(distance,1)
    @defVar(m,x[1:n,1:n],Bin)
    # TODO: you need to fill this in!!!
    # ...

    #1. Objective
    #Set the objective
    #@setObjective(m,...

    # 2. Account for extra variables
    # Make x_ij and x_ji be the same thing (undirectional)
    # Don't allow self-arcs

    #3. Degree Constraints
    # For each vertex, add a constraint giving it a degree of two.


    #4. Solution.
    # Use the code below to solve the model return the result.
    # Delete the place holder.
    #solve(m)
    #return getObjectiveValue(m), extractCycle(getValue(x),1)
    return 0, [1:n]

    # 5. Cutset constraints
    # Once you get the solution without cutset constraints working, do these.
    # Move this code right before solve
    # Fill in the the cutset function below
    # function cutset(cb)
    #     edgeVals = getValue(x)
    #     components = connectedComponents(edgeVals)
    #     ...
    # end
    # setlazycallback(m,cutset)
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