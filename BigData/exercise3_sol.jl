function sample(datastream)
    count_so_far = 0
    selected_item = nothing
    for item in datastream
        count_so_far += 1
        if rand() <= 1 / count_so_far
            selected_item = item
        end
    end
    return selected_item
end

function testit(N)
    datastream = [1:10]
    counts = zeros(Int, 10)
    for iter = 1:N
        item = sample(datastream)
        counts[item] += 1
    end

    println(counts ./ N)
end

testit(10000)