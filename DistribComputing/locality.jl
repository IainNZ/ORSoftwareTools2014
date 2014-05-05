# This example is meant to illustrate the importance of reducing the
# number of accesses to memory. 
# In computeStats(), we make a single pass through the vector to
# compute all of the quantities of interest.
# This is about twice as fast as using the efficient built-in methods
# that have to pass through the array on each call, even though
# we perform the exact same operations.

x = [1.0,2.0]
norm(x), minimum(x), norm(x,1), maximum(x) # pre-compile

# compute L2, L1 norms, minimum and maximum element
function computeStats(x)
    sumsq = 0.0
    sumabs = 0.0
    mx = -Inf
    mn = Inf
    for i in 1:length(x)
        val = x[i]
        sumsq += val*val
        absval = abs(val)
        sumabs += absval
        if val > mx
            mx = val
        end
        if val < mn
            mn = val
        end
    end
    return sqrt(sumsq), sumabs, mn, mx
end
computeStats(x) # throw away

x = rand(100_000_000) # 800Mb

tic()
results1 = computeStats(x)
toc()

tic()
results2 = norm(x), norm(x,1), minimum(x), maximum(x)
toc()

println(results1)
println(results2)

