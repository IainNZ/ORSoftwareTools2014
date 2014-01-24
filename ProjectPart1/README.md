# Project Part 1 - Internet and Databases

## Lecture Notes

Lectures notes available via [Google Drive](https://docs.google.com/presentation/d/1ubTf_Lt2JzKDkkDzDIG9BhrTKq1lpsd-P5t9nutp3C4/edit?usp=sharing)

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
and following the prompts. On older versions, you may need to install the entire Xcode application, which can be found [here](https://developer.apple.com/xcode/). Contact [huchette@mit.edu](huchette@mit.edu) if you need help with this. 

## Assignment

You need to test each package individually.

1. We will turn the stations.csv Hubway data into a SQLite database. Run `create_db.jl` to do this.
2. Next we will run `test_db.jl`. Please submit the output of this file.
3. Now run `test_http.jl`. You should get a message like "Listening on 8000..." (Windows users: click allow if a firewall diaglog pops up.)
4. Open a webbrowser and go to [http://localhost:8000/nameservice/yourname](http://localhost:8000/nameservice/yourname). Submit the text you see.

Please combine both submissions together!
