# Project Part 1 - Internet and Databases

## Lecture Notes

Slides are provided in `bigdataslides.pdf`. The ``nameservice.jl`` file is a commented version of the "name returning service" described in the Internet section. It can be used as a script, and as a prompt for the exercise at the conclusion of this section. The solution is in ``nameaddservice_solution.jl``. The code file `db_script.jl` was used in the databases section of the module during the live coding session. Finally ``projpart1_solution.jl`` represents the desired result of the final exercise in the module.

## Installation Instructions

You have already installed Julia for the previous classes. First, update your package database with `Pkg.update()`, then add the following packages:

* HttpServer
* SQLite

You can do this with the `Pkg.add()` command.

### Note for Mac users
HttpServer requires a C compiler (clang) to install properly. To check if this is available on your machine, at the Terminal run 
```
>> clang
```
If this returns ``clang: error: no input files``, then you have the necessary compiler. Otherwise, you need to install the Xcode command line tools. On newer versions of OSX, this can be done by running 
```
>> xcode-select --install
```
and following the prompts. On older versions, you may need to install the entire Xcode application, which can be found [here](https://developer.apple.com/xcode/).

## Pre-class Assignment

You need to test each package individually.

1. We will turn the stations.csv Hubway data into a SQLite database. Run `assmt_create_db.jl` to do this.
2. Next we will run `assmt_test_db.jl`. Please submit the output of this file.
3. Now run `assmt_test_http.jl`. You should get a message like "Listening on 8000..." (Windows users: click allow if a firewall diaglog pops up.)
4. Open a webbrowser and go to [http://localhost:8000/nameservice/yourname](http://localhost:8000/nameservice/yourname). Submit the text you see.

Please combine both submissions together!
