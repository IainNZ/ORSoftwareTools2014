# Modelling with Julia/JuMP

## Overview
This module covers using the Julia language together with the JuMP modeling language for modeling and solving linear and linear mixed-integer optimization problems.

- Installation instructions for Julia, JuMP and Gurobi are given below.  Gurobi is not strictly required. The default solver (GLPK) that comes down with JuMP is sufficient.
- ``preClassassignment.jl" should be run after installation to confirm everything is working.  See [below]( https://github.com/IainNZ/ORSoftwareTools2014/blob/papersubmit/Modelling/README.md#assignment)
- The file ```LpModeling.pptx''' describes the lecture.  Interspersed throughout are various coding exercises.
- Templates for students for the coding exercises are in the folder ```Exercises and Templates'''  The scripts with the "test" suffix are to test some of our later scripts (which only contain function definitions). Feel free to have a look through these ahead of the class on Thursday. 
- Solutions for instructors are in the folder ```Solutions"  These should not be distributed to students before class.

## Installation Instructions

If you find any errors in these instructions, please contact the course instructors so we can update them for everyone.

### If you already have everything installed from JuMP class last year

There have been updates to packages since last year's class, so at the least you will need to open Julia and run ``Pkg.update()`` to update them.

There have been updates to Julia and Julia Studio as well, so you may want to uninstall/remove them and install the newer, more stable versions.

Most of the issues in the last class were with Julia Studio so we are no longer advocating its use until it improves a bit. It probably makes things a bit easier on Windows if you don't know how to change your PATH.


###If you don't already have Julia/JuMP installed, here's the full set of instructions:  

### Install Julia

#### Mac OS X
1.  We will use the v0.2 binaries provided on the [Julia download page](http://julialang.org/downloads/).  If you are running OS-X Lion, Mountain Lion, or Mavericks, choose the 10.7+64-bit version.  Snow Leopard users, the 10.6 64-bit version is for you.
2. Once downloaded, open the .dmg disk image in Finder and then drag Julia-0.2.app to your Applications folder.
3. Click on the Julia-0.2.app file to open it. If it does not open, you may need to change your applications permissions:
 * Open System Preferences.app
 * Go to Security and Privacy
 * Click "Allow Anyway" next to Julia-0.2.app
4. Open the Terminal.app add the Julia executable to your path:
 * Run ``echo PATH=\$PATH:\"/Applications/Julia-0.2.0.app/Contents/Resources/julia/bin\" >> ~/.bash_profile``.

 * You can now run Julia by typing ``julia`` at the command line. To run a Julia file, type ``julia path/to/file``.

### Windows 

1. You can install the Julia 0.2 binaries from the [Julia download page](http://julialang.org/downloads/) - you should use the 64-bit version.
2. Extract the files to wherever you want.
3. Open a Command Window and navigate to the the folder you made. You should now be able to run Julia by typing ``julia`` for interactive mode or ``julia myfile.jl`` to run a script.
4. If you want to be able to run Julia from any location on your computer, you will need to add the Julia folder to your PATH. PATH is a list of folders that Windows looks in when the program name you type in isn't in the current folder. To see how to change your PATH, look at [this link](http://www.computerhope.com/issues/ch000549.htm). Your PATH probably looks like ``"C:/RandomFolder/;c:/somestuff/blah/"`` right now. Say you put Julia in ``C:/Julia02/`` - you should add this to the end of your PATH so it will look like ``"C:/RandomFolder/;c:/somestuff/blah/;C:/Julia02"``. Note the ``;`` used to separate the folders.


### Linux

Follow the instructions here [Julia download page](http://julialang.org/downloads/)  depending on your particular flavor of Linux.  


### Install Gurobi >=5.6.0
You should be able to use GLPK and CBC, the default solvers that install with JuMP for all of the exercises in this course.

For larger, more complex optimization problems, though, you may want to use commercial solver Gurobi.  If you'd like to also install Gurobi, you can do so as follows.  (Install a version >= 5.6.0 to make sure all the features of JuMP work correctly.  Also we will be using the 64bit version of Julia, so make sure that you have the 64 bit version of Gurobi intalled.)  

1. Go to www.gurobi.com
2. Create an account, and request an academic license.
3. Download the installer for Gurobi 5.6.0
4. Install Gurobi, accepting default options. Remember where it installed to!
5. Go back to the website and navigate to the page for your academic license. You'll be given a command with a big code in it, e.g. grbgetkey aaaaa-bbbb
6. In a terminal, navigate to the .../gurobi560/<operating system>/bin folder where <operating system> is the name of your operating system.  
7. Copy-and-paste the command from the website into the command prompt - you need to be on campus for this to work!


### Install JuMP and the Gurobi interface

Installing these is easy, use the Julia package manager: 

```jl
julia> Pkg.add("Gurobi")
julia> Pkg.add("JuMP")
```


## Assignment

Download and run the Julia script ``assignment.jl``. You can do this by opening a terminal window, navigating to the directory of ``assignment.jl``, and typing in
```
julia assignment.jl
```
The output of the script is a list of seven names, with the heading 
```
*** PARTY INVITATION LIST ***
```
Copy and paste these names into the assignment submission text box and submit them to complete the assignment!

If you encounter any problems running the script, please let us know as soon as possible.
