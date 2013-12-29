# Modelling with Julia/JuMP

## Installation Instructions

### Install Gurobi 5.6.0
If you have an older version of Gurobi on your computer, that should be fine.  None of the features we will be using require the latest version.  Otherwise, 

1. Go to www.gurobi.com
2. Create an account, and request an academic license.
3. Download the installer for Gurobi 5.6.0
4. Install Gurobi, accepting default options. Remember where it installed to!
5. Go back to the website and navigate to the page for your academic license. You'll be given a command with a big code in it, e.g. grbgetkey aaaaa-bbbb
6. In a terminal, navigate to the .../gurobi560/<operating system>/bin folder where <operating system> is the name of your operating system.  
7. Copy-and-paste the command from the website into the command prompt - you need to be on campus for this to work!
8. Go up a level (cd ..)
9.  UNLESS you are on Mac OSX, run the command python setup.py install Apparently this is a bad idea on OSX!  If you are on Mac OSX, see the note below.

You are done!

### Install Julia


### Install JuMP


### Data and Exercise scripts!


## Assignment

## An annoyance with Mac OSX
As of 2013, Gurobi ha a peculiarity whereby the only version of python it would work with was the version of python that shipped with Mac OSX.  (You can read more about it here: https://groups.google.com/forum/#!topic/gurobi/cHHX5RjsRfU ) Note that this is contrast to whatever the documentation says about python setup.py.  Since then, some people have found some workarounds, which are as of yet, untested.

For this course, we will exclusivey be using Julia / JuMP for our coding of LPs, and not python.  Hence this particular peculiarity is not something we will owrry about, but, you should be aware of it in your own research.  
