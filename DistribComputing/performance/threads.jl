# In this small script, we show how to tell BLAS to
# exploit a multicore machine to speed up basic linear
# algebra operations.


function solve(n)
    A = rand(n,n)
    b = rand(n)
    x = @time A\b
    return x
end

solve(10) # throw away
for t in [1,2,4,8]
    blas_set_num_threads(t)
    println("LU Factorization with $t threads:")
    solve(10_000)
end


