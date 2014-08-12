# Project Part 2 - MILP Callbacks

* Ross Anderson
* http://rma350.scripts.mit.edu/home/

## Lecture Notes

Slides are provided in `projectPartII.pdf`.

* `lazyExample.jl` is the script for the simple one-constraint lazy constraint example.
* `lazyExercise.jl` is the prompt file for the lazily-approximated norm exercise, and has a solved counterpart `lazyExercise_sol.jl`.
* The `project` folder contains everything provided for the project itself, including setup files from Project Part 1 needed for the pre-class assignment. `tsp_service.jl` is the main file, with TSP-specific logic in `tspSolver.jl` and test scripts `tsplib.jl` and `testTspSolver.jl`. The finished version of `tspSolver.jl` is in `tspSolver_sol.jl`.

## Installation Instructions

Please install the Winston plotting package `Pkg.add("Winston")` (see [GitHub](https://github.com/nolta/Winston.jl) and [these instructions](http://homerreid.dyndns.org/teaching/18.330/InstallingWinston.shtml)). Be sure that you have Julia and Gurobi working (i.e. that you completed the installation assignment for the Modeling class).

## Pre-class Assignment

We have provided an _enhanced solution_ to Project Part 1, which we will be using in Part 2.  Make sure you can run it!  We recommend you make a fresh start from Part 1 in a new directory, but you will have to repeat a few of the installation steps.  We have provided duplicates of a few scripts.

* Navigate to the directory `provided`
* Run `create_db.jl` to build the SQLite database.
* Run `test_db.jl` to make sure it is working.
* Run `tsp_service.jl`. You should get a message like "Listening on 8000..."
* Open a browser and go to http://localhost:8000/stationservice/42.3/42.4/-71.2/-71.0.  You should see a plot of the hubway stations on the x-y plane connected in a (not optimal) tour.

Some information will be printed out to the terminal when you make a webpage request.  Paste it into a text file and submit the results.