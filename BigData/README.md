# Big Data

## Lecture Slides

Slides are available via [Google Docs](https://docs.google.com/presentation/d/1pDGyRcIBwEC-W63NPNQMS6EGwndpOY82kf2g4-h3OV8/edit?usp=sharing).

## Installation Instructions

We will use Julia and R. You will need the following R packages:

 * ``ff``
 * ``biglm``

## Assignment

Run the following R code and Julia code and submit the results on Stellar:

```R
library(ff)
library(biglm)
do something here
```

```Julia
mydata = [1,3,10,15]
function printfact(n)
  f = factorial(n)
  println("$n factorial is $f")
  return f
end
map!(printfact, mydata)
println(sum(mydata))
```
