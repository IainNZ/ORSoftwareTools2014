#Solutions to finger exercises

####
#Create an array of the first 10 squares
####
powerList = [ i^2 for i in 1:10]
print(powerList)

####
#Creating list of odd numbers
####
#Solution 1
oddList = Int[]
for i in 1:20
    if i % 2 == 1
        push!(oddList, i)
    end
end
print(oddList)

#Solution 2
oddList2 = [2 * i + 1 for i in 0:9 ]
println(oddList2)

#Solution 3
oddList3 = [1:20]
oddList3 = oddList3[oddList3 .% 2 .== 1] 
print(oddList3)

#Bonus question: What are the pros/cons of each of the above 3 solutions?

####
#Fizz buzz solution
####
function FizzBuz( n )
    for ix in 1:n
        if (ix % 3 == 0) & (ix % 5 == 0)
            println("FizzBuzz")
        elseif ix % 3 == 0
            println("Fizz")
        elseif ix % 5 == 0
            println("Buzz")
        else
            println(ix)
        end
    end
end        
