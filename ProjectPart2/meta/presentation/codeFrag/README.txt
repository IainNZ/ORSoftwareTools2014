To generate highlighted code, first install pygments:

sudo apt-get install python-setuptools
sudo easy_install "Pygments==1.6"

To generate a pygmentsPreamble.tex run

pygmentize -o lazyEx1Full.tex -O full -l julia lazyEx1.jl

and copy the preamble info into pygments Preable.tex


To generate lazyEx1.tex, run 

pygmentize -o lazyEx1.tex -l julia lazyEx1.jl


Note that version 1.6 or higher of pygemnts is required for Julia.
