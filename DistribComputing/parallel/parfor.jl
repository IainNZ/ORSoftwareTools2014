# run:
# julia parfor.jl
# julia -p 2 parfor.jl

function simulate(n)
    nheads = @parallel (+) for i=1:200000000
        int(randbool())
    end
end
simulate(1)

nheads = @time simulate(2_000_000_000)
println("$nheads heads")

