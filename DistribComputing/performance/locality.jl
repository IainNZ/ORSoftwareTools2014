
function normAndMin(x)
    n = 0.0
    m = Inf
    for i in 1:length(x)
        n += x[i]^2
        if x[i] < m
            m = x[i]
        end
    end
    return sqrt(n),m
end
normAndMin([1.0,2.0]) # throw away

x = rand(100_000_000)
n1,m1 = @time normAndMin(x)
n2, m2 = @time norm(x),minimum(x)
println("$n1 $m1")
println("$n2 $m2")

