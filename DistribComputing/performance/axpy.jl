# This example is meant to introduce BLAS (Basic Linear Algebra 
# Subprograms), an efficient numerical library for basic vector
# and matrix operations.
# It may be advantageous to restructure computations in order to
# use existing BLAS (and LAPACK) functions, although this
# comes at a cost of readability of the code.

# Using Julia's built-in vectorized expressions
# These are potentially inefficient because they create temporary objects
function naive!(a,x,y)
    y[:] = a*x+y
end

# Instead, we consider writing a scalar loop to build y "in-place"
function axpy_loop!(a,x,y)
    for i in 1:length(x)
        y[i] += a*x[i]
    end
end

# To be even more efficient, we can use the low-level "axpy" 
# (y <- a*x plus y) function of BLAS.
# This is faster but sacrifices readability.

naive!(1.0,[1.0],[1.0])
axpy_loop!(1.0,[1.0],[1.0])
BLAS.axpy!(1.0,[1.0],[1.0]) # precompile

x = rand(100_000_000)
y = rand(100_000_000)

@time naive!(2.0,x,y)
@time axpy_loop!(2.0,x,y)
@time BLAS.axpy!(2.0,x,y)
