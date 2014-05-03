# Demonstration of "Find Most Frequent"

# Make the data set first

N = 10000
data = Int[]
for i = 1:(2*N)
  push!(data, -666)
end
for i = 1:N
  push!(data, rand(1:N))
end
shuffle!(data)

most_common = data[1]
counter = 1

for i = 1:length(data)
  if data[i] == most_common
    counter += 1
  elseif data[i] != most_common && counter >= 1
    counter -= 1
  else
    most_common = data[i]
    counter = 1
  end
end

println(most_common)
