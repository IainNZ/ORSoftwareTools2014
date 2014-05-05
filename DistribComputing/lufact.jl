# This example is meant to illustrate the potential gains by
# restructuring linear algebra operations.


function run(n)
    R = rand(n,n)
    A = R'*R # random positive definite matrix
    b1 = rand(n)
    b2 = rand(n)

    # Naively recomputes the factorization of the matrix twice.
    println("Method 1"); tic()
    x1 = A\b1
    x2 = A\b2
    toc()

    # First compute the LU factorization, then reuse it.
    println("Method 2"); tic()
    LU = lufact(A)
    x1 = LU\b1
    x2 = LU\b2
    toc()

    # Take advantage of the symmetric positive-definite structure 
    # of the matrix by using a Cholesky factorization.
    println("Method 3"); tic()
    chol = cholfact(A)
    x1 = chol\b1
    x2 = chol\b2
    toc()

end

run(1) # First run includes Julia's compilation time

println("\nReal run")
run(5_000)
