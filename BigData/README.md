# Big Data

* Iain Dunning
* http://iaindunning.com
* iaindunning@gmail.com

## Lecture Slides

Slides are provided in ``bigdataslides.pdf``. The code script files ``ffbiglm_script.r``, ``iterate_script.jl``, ``sketch_script.jl`` and ``mapreduce_script.jl`` are all referenced from the slides they should be used with.

## Exercises

Starter files were provided for three of the four in-class exercises (the ``..._start.jl`` files) as well as completed versions (the ``..._sol.jl`` files).

## Installation Instructions

We will use Julia and R in this module. No additional packages are needed for Julia, but you will need the following R packages:

 * ``ff``
 * ``ffbase``
 * ``biglm``

## Pre-class Assignment

Run the following R code and Julia code and submit the results on Stellar. You can find the source code files in this folder. You will need the Hubway station data as well - if the R code can't find the data, you will need to change the location of the file.

```R
library(ff)
library(ffbase)
library(biglm)
stations = read.csv.ffdf(file="../Hubway/stations.csv", header=TRUE)
lm = bigglm(lat ~ lng, data=stations)
summary(lm)
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
