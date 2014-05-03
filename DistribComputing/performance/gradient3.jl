# In this step, we restructure the code so that the 
# product Q*x is computed only once per iteration,
# instead of twice (separately in f() and fgrad()).

function genF(Q)
    function f_and_fgrad(x)
        grad = Q*x
        return ((1/2)*dot(x,grad), grad)
    end
end

function gradDescent(f_and_fgrad, startX)

    const stepsize = 1.0
    const sigma = 0.1

    x = copy(startX)
    fval, grad = f_and_fgrad(x)
    gradnorm = norm(grad)
    niter = 1
    while gradnorm > 1e-4
        # step in the direction of -grad using the Armijo rule
        k = 0
        BLAS.axpy!(-stepsize/2^k,grad,x)
        fvalnew, gradnew = f_and_fgrad(x)
        while fval - fvalnew < -sigma*(stepsize/2^k)*dot(grad,grad)
            k += 1
            BLAS.axpy!(stepsize/2^(k-1)-stepsize/2^k,grad,x)
            fvalnew, gradnew = f_and_fgrad(x)
        end
        if niter % 5000 == 0
            println("Iter: $niter Obj. val: $fval Gradient norm: $gradnorm")
        end
        fval, grad = f_and_fgrad(x)
        gradnorm = norm(grad)
        niter += 1
    end
    println("Converged")
    #print("Solution: ");show(x);println()

end

dim = 100
srand(10) # fix random seed
R = rand(dim,dim)
f_and_fgrad = genF(R'*R)

gradDescent(f_and_fgrad, ones(dim)) # run once to exclude compilation time
@profile @time gradDescent(f_and_fgrad, ones(dim))
Profile.print(format=:flat)
