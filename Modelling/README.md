# Modelling with Julia/JuMP

## Installation Instructions

### Install Gurobi 5.6.0
If you have an older version of Gurobi (>= 5.1) on your computer, that should be fine.  None of the features we will be using require the latest version.  We will be using the 64bit version of Julia, so make sure that you have the 64 bit version of Gurobi intalled.  If you need a new version:

1. Go to www.gurobi.com
2. Create an account, and request an academic license.
3. Download the installer for Gurobi 5.6.0
4. Install Gurobi, accepting default options. Remember where it installed to!
5. Go back to the website and navigate to the page for your academic license. You'll be given a command with a big code in it, e.g. grbgetkey aaaaa-bbbb
6. In a terminal, navigate to the .../gurobi560/<operating system>/bin folder where <operating system> is the name of your operating system.  
7. Copy-and-paste the command from the website into the command prompt - you need to be on campus for this to work!


### Install Julia
#### Mac OS X
1.  We will use the v0.2-rc2 binaries provided http://julialang.org/downloads/.  If you are running OS-X Lion, Mountain Lion, or Mavericks, choose the 10.7+64-bit version.  Snow Leopard users, the 10.6 64-bit version is for you.
2. Once downloaded, open the .dmg disk image in Finder and then drag Julia-0.2.0-rc2.app to your Applications folder.
3. Click on the Julia-0.2.0-rc2.app file to open it. If it does not open, you may need to change your applications permissions:
Open System Preferences.app
Go to Security and Privacy
Click "Allow Anyway" next to Julia-0.2.0-rc2.app
4. Open the Terminal.app add the Julia executable to your path:
Run nano ~/.bash_profile and add export PATH=$PATH:"/Applications/Julia-0.2.0-rc2.app/Contents/Resources/julia/bin" to the bottom of the file.
You can now run Julia by typing julia at the command line. To run a Julia file, type julia path/to/file.

### Windows 

You may install the Julia 0.2-RC binaries from http://julialang.org/downloads/.

### Linux
1. We will use the latest nightly binaries. We can do this by adding a new repository. Run the following commands at your prompt:

```bash
sudo add-apt-repository ppa:staticfloat/julianightlies
sudo add-apt-repository ppa:staticfloat/julia-deps
sudo apt-get update
sudo apt-get install julia
```
2. When thats done, type ``julia`` at your prompt to start Julia. Check that it starts!


### Install JuMP
Installing JuMP is easy, use the Julia package manager: 

```
julia> Pkg.add("JuMP")
```

### Data and Exercise scripts!


## Assignment

## An annoyance with Mac OSX
As of 2013, Gurobi ha a peculiarity whereby the only version of python it would work with was the version of python that shipped with Mac OSX.  (You can read more about it here: https://groups.google.com/forum/#!topic/gurobi/cHHX5RjsRfU ) Note that this is contrast to whatever the documentation says about python setup.py.  Since then, some people have found some workarounds, which are as of yet, untested.

For this course, we will exclusivey be using Julia / JuMP for our coding of LPs, and not python.  Hence this particular peculiarity is not something we will owrry about, but, you should be aware of it in your own research.  
