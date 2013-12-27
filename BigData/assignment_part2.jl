# Big Data Assignment Part 2
# Run this code and submit the output on Stellar

mydata = [1,3,10,15]
function printfact(n)
  f = factorial(n)
  println("$n factorial is $f")
  return f
end
map!(printfact, mydata)
println(sum(mydata))
