# This small script introduces students to the basic
# syntax in Julia for performing distributed calculations,
# in this case a parallel "map", where a function
# is applied independently to a sequence of inputs in parallel.
# To run the code in serial, run "julia parfor.jl" from
# the command line.
# To run the code in paralle, run "julia -p N parfor.jl",
# and Julia will run N tasks. N should be set to the number
# of cores in the local machine.

blas_set_num_threads(1) # avoid competition with threads

mats = [rand(2000,2000) for i in 1:10]
results = @time pmap( m -> norm(full(qrfact!(m)[:R])), mats)
println(results)
