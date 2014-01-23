# run:
# julia pmap.jl
# julia -p 2 pmap.jl

blas_set_num_threads(1) # avoid competition with threads

mats = [rand(2000,2000) for i in 1:10]
results = @time pmap( m -> norm(full(qrfact!(m)[:R])), mats)
println(results)
