# This small script introduces students to the basic
# syntax in Julia for performing distributed calculations,
# in this case a distributed loop.
# To run the code in serial, run "julia parfor.jl" from
# the command line.
# To run the code in paralle, run "julia -p N parfor.jl",
# and Julia will run N tasks. N should be set to the number
# of cores in the local machine.

function simulate(n)
    nheads = @parallel (+) for i=1:200000000
        int(randbool())
    end
end
simulate(1)

nheads = @time simulate(2_000_000_000)
println("$nheads heads")

