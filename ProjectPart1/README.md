# Project Part 1 - Internet and Databases

## Lecture Notes

Lectures notes available via [Google Drive](https://docs.google.com/presentation/d/1ubTf_Lt2JzKDkkDzDIG9BhrTKq1lpsd-P5t9nutp3C4/edit?usp=sharing)

## Installation Instructions

### NOTE: These instructions aren't quite ready for Windows users. Please wait for a few days, e.g. Sunday night.

You have already installed Julia for the previous classes. You should now add the following packages:

* HttpServer
* SQLite

You can do this with the `Pkg.add()` command.

## Assignment

You need to test each package individually.

1. We will turn the stations.csv Hubway data into a SQLite database. Run `create_db.jl` to do this.
2. Next we will run `test_db.jl`. Please submit the output of this file.
3. Now run `test_http.jl`. You should get a message like "Listening on 8000..."
4. Open a webbrowser and go to [http://localhost:8000/nameservice/yourname](http://localhost:8000/nameservice/yourname). Submit the text you see.

Please combine both submissions together!
