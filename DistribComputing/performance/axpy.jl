
function naive!(a,x,y)
    y[:] = a*x+y
end

function axpy_loop!(a,x,y)
    for i in 1:length(x)
        y[i] += a*x[i]
    end
end

naive!(1.0,[1.0],[1.0])
axpy_loop!(1.0,[1.0],[1.0])
BLAS.axpy!(1.0,[1.0],[1.0]) # precompile

x = rand(100_000_000)
y = rand(100_000_000)

@time naive!(2.0,x,y)
@time axpy_loop!(2.0,x,y)
@time BLAS.axpy!(2.0,x,y)
