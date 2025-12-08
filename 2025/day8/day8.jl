using BenchmarkTools

function read_data()
    lines = readlines("2025/day8/data_day8.txt")
    coords = zeros(Int64, size(lines)[1], 3)
    for i in range(1, size(lines)[1], step=1)
        coords[i,:] = parse.(Int64, split(lines[i], ","))
    end
    return coords
end

function day8_2025()
    n_lim = 1000
    coords = read_data()
    dist = []
    junctions = [[0]]
    for i in range(1, size(coords)[1], step=1)
        cur_coord = coords[i,:]
        for j in range(1, size(coords)[1], step=1)
            next_coord = coords[j,:]
            if i >= j
                continue
            end
            dist = push!(dist, (sum((cur_coord .- next_coord).^2), i, j))
        end
    end

    dist = sort(dist)

    k = 0
    while length(junctions[1]) != size(coords)[1]
        k += 1
        box1 = dist[k][2]
        box2 = dist[k][3]
        if k == 1
            junctions = [[box1, box2]]
            continue
        end
        box1_check = findall.(x -> x==box1, junctions)
        box2_check = findall.(x -> x==box2, junctions)
        box1_empty = isempty.(box1_check)
        box2_empty = isempty.(box2_check)
        if reduce(&, box1_empty) && reduce(&, box2_empty)
            junctions = push!(junctions, [box1, box2])
        elseif reduce(|, .!box1_empty) && reduce(&, box2_empty)
            box1_in = (1:1:length(box1_empty))[.!box1_empty]
            junctions[box1_in[1]] = push!(junctions[box1_in[1]], box2)
        elseif reduce(|, .!box2_empty) && reduce(&, box1_empty)
            box2_in = (1:1:length(box2_empty))[.!box2_empty]
            junctions[box2_in[1]] = push!(junctions[box2_in[1]], box1)
        else
            box1_in = ((1:1:length(box1_empty))[.!box1_empty])
            box2_in = (1:1:length(box2_empty))[.!box2_empty]
            if box1_in[1] != box2_in[1]
                junctions[box1_in[1]] = union(junctions[box1_in[1]], junctions[box2_in[1]])
                junctions = deleteat!(junctions, box2_in[1])
            end
        end
        if k == 1000
            largest_circuits = sort(size.(junctions), rev=true)
            p1_largest3 = largest_circuits[1][1] * largest_circuits[2][1] * largest_circuits[3][1]
            println("part 1. multiply together the sizes of the three largest circuits: $p1_largest3")
        end
        if length(junctions[1]) == n_lim
            x_1 = coords[box1]
            x_2 = coords[box2]
            p2_x12 = x_1 * x_2
            println("part 2. $x_1 times $x_2: $p2_x12")
            break
        end
    end
end

@btime day8_2025()