### Exercise 7 Test Script - LP modelling using Julia/JuMP
# This script is to test your Ex7_NRM_SimulateControl code.

# Modify the "using ..." line below to use your Ex7_NRM_SimulateControl script.
# Use "Ex7_NRM_SimulateControl_complete" to use the completed script.
using ...

# After the function is defined, we can use the same data as before:

legs = [1, 2, 3, 4, 5, 6]
fareLegs = [ (1), (2), (3), (4), (5), (6), (1,4), (1,5), (1,6), (2,4), (2,5), (2,6), (3,4), (3,5), (3,6)]
fareProbabilities = [0.06, 0.096, 0.046, 0.073, 0.159, 0.067, 0.043, 0.019, 0.112, 0.075, 0.031, 0.044, 0.012, 0.0210, 0.1130]
fareRevenues = [40, 30, 30, 10, 40, 10, 190, 80, 90, 70, 60, 190, 60, 50, 10]
legCapacities = [20, 20, 20, 20, 20, 20]
T = 300

# Simulate bid price control with 100 fare sequences; time it using tic/toc.
numSims = 100;

tic()
simulateBidPriceControl( legs, fareLegs, fareProbabilities, fareRevenues, legCapacities, T, numSims);
toc()

println();

# Simulate greedy control with 100 fare sequences; time it using tic/toc.
tic()
simulateGreedyControl( legs, fareLegs, fareProbabilities, fareRevenues, legCapacities, T, numSims)
toc()

