

function genF(Q)
    f(x) = (1/2)*dot(x,Q*x)
    fgrad(x) = Q*x
    return f, fgrad
end

function gradDescent(f, fgrad, startX)

    const stepsize = 1.0
    const sigma = 0.1

    x = copy(startX)
    fval = f(x)
    grad = fgrad(x)
    gradnorm = norm(grad)
    niter = 1
    while gradnorm > 1e-4
        # step in the direction of -grad using the Armijo rule
        k = 0
        while fval - f(x - (stepsize/2^k)*grad) < -sigma*(stepsize/2^k)*dot(grad,grad)
            k += 1
        end
        x = x - (stepsize/2^k)*grad
        if niter % 5000 == 0
            println("Iter: $niter Obj. val: $fval Gradient norm: $gradnorm")
        end
        fval = f(x)
        grad = fgrad(x)
        gradnorm = norm(grad)
        niter += 1
    end
    println("Converged")
    #print("Solution: ");show(x);println()

end

dim = 100
srand(10) # fix random seed
R = rand(dim,dim)
f, fgrad = genF(R'*R)
println("Test run:")
gradDescent(x->0, x->[0.0], ones(1)) # run once to exclude compilation time

@unix_only begin
	@profile @time gradDescent(f, fgrad, ones(dim))
	Profile.print(format=:flat)
end
@windows_only begin
	@time gradDescent(f, fgrad, ones(dim))
end
