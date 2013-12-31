# Basic Julia By Example

######
#Three basic containers
######
#Arrays  
lyrics = ["Never", "Gonna", "Give", "You", "Up"]
println(lyrics)

#arrays can be modified (1-based)
#Modify arrays (1-based)
lyrics[3] = "Let"
lyrics[5] = "Down"
println(lyrics)

#Tuples - like "fixed" arrays
yolo = ("you", "only", "live", "once")
yolo[end] = "twice"  #Raises an error

#Dictionaries
#to each "key" associates a value
stageNames = ["Velibor"=>"Velibro", "Vishal"=>"V-Diddy", "Dimitris"=>"D Unit" ]
println( stageNames["Vishal"] )

## There are many other useful container types (multidimensional arrays)
## and the ability to define your own composite types... See the Julia Manual

######
## Basic Control Flow 
######
#Write a for loop syntax (like Matlab)
for l in lyrics
    println(l)
end

#A different way to write to write that loop
#Notice the "view" 1:5
for ix in 1:5
    println(lyrics[ix])
end
    
    
    