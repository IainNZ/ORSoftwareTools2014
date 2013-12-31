# Big Data

## Lecture Slides

Slides are available via [Google Docs](https://docs.google.com/presentation/d/1pDGyRcIBwEC-W63NPNQMS6EGwndpOY82kf2g4-h3OV8/edit?usp=sharing).

## Installation Instructions

We will use Julia and R. You will need the following R packages:

 * ``ff``
 * ``ffbase``
 * ``biglm``

## Assignment

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
