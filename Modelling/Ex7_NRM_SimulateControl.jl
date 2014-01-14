### 15.S60 Exercise 7 Script - LP modelling using Julia/JuMP
# In this exercise, we use the NRM LP solver code within a 
# function to simulate bid-price control. The code is partially 
# filled in; you need to fill in the parts labeled "- fill in here -" 
# and "— fill in if condition below -" .

Pkg.add("Distributions")

using Distributions
using Ex6_NRM_DualFunction_complete


# simulateBidPriceControl
# Takes data defining a NRM problem, and outputs the average revenue that 
# is achieved from running numSims simulations of the DLP-based bid price 
# control policy. 
function simulateBidPriceControl( legs, fareLegs, fareProbabilities, fareRevenues, legCapacities, T, numSims)

	numLegs	=length(legs)
	numFares = length(fareProbabilities)
	# We are going to adjust fareProbabilities, so that the last number 
	# in the array is the probability of no request on a given day.
	adjustedFareProbs = [fareProbabilities,  1-sum(fareProbabilities)]

	simRevenues = zeros(numSims, 1)
	for i = 1:numSims
		usedCap = zeros(numLegs,1)
		totalRevenue = 0
		for t=1:T
			# Randomly sample a fare request. Note that 
			# if request = numFares+1, then that means that 
			# there was no request in the period.
			request = rand(Categorical( adjustedFareProbs ))

			if (request != numFares+1 
			    && all( [ usedCap[ell] < legCapacities[ell] for ell in fareLegs[request]] )  )
				# A real request arrives, and we have sufficient capacity to accept it, 
				# so let's solve the LP to get the dual prices...
				# - fill in here -				

				# ...and check if the revenue from the request exceeds the 
				# opportunity cost (~= the sum of the dual prices of the consumed legs) 
				# — fill in if condition below -
				if( ...  )
					# Accept the request!
					for ell in fareLegs[request]
						usedCap[ell] = usedCap[ell] + 1
					end
					totalRevenue = totalRevenue + fareRevenues[request]
				end
				
				
			end
		end
		simRevenues[i] = totalRevenue
	end

	dualPrices, obj = solveNRMProblem( legs, fareLegs, fareProbabilities, fareRevenues, legCapacities, T)

	println("*** DLP-based bid price control: ***")
	println("DLP objective is $obj");
	println("Mean revenue is $(mean(simRevenues)),  standard error is $(std(simRevenues)/sqrt(numSims)).")
end


# simulateGreedyControl
# Takes data defining a NRM problem, and outputs the average revenue that 
# is achieved from running numSims simulations of the greedy control policy 
# (this policy does not use the problem data; if a request is at hand and there is
# enough capacity to accept it, it is accepted).
function simulateGreedyControl( legs, fareLegs, fareProbabilities, fareRevenues, legCapacities, T, numSims)

	numLegs	=length(legs)
	numFares = length(fareProbabilities)
	adjustedFareProbs = [fareProbabilities,  1-sum(fareProbabilities)]

	simRevenues = zeros(numSims, 1)
	for i = 1:numSims
		usedCap = zeros(numLegs,1)
		totalRevenue = 0
		for t=1:T
			# Randomly sample a fare request
			request = rand(Categorical( adjustedFareProbs ))

			if (request != numFares+1 
			    && all( [ usedCap[ell] < legCapacities[ell] for ell in fareLegs[request]] )  )
				# A real request arrives; accept the request!
				# (No need to check; that is the point of greedy!)
				for ell in fareLegs[request]
					usedCap[ell] = usedCap[ell] + 1
				end
				totalRevenue = totalRevenue + fareRevenues[request]
			end
		end
		simRevenues[i] = totalRevenue
	end

	println("*** Greedy control (accept all requests, capacity permitting): ***")
	println("Mean revenue is $(mean(simRevenues)),  standard error is $(std(simRevenues)/sqrt(numSims)).")
end





