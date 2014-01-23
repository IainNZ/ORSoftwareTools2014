
function run(n)
    R = rand(n,n)
    A = R'*R # random positive definite matrix
    b1 = rand(n)
    b2 = rand(n)

    println("Method 1"); tic()
    x1 = A\b1
    x2 = A\b2
    toc()

    println("Method 2"); tic()
    LU = lufact(A)
    x1 = LU\b1
    x2 = LU\b2
    toc()

    println("Method 3"); tic()
    chol = cholfact(A)
    x1 = chol\b1
    x2 = chol\b2
    toc()

end

run(1) # throw away

println("\nReal run")
run(5_000)
