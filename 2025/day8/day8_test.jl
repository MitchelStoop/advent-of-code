using BenchmarkTools

function read_data()
    lines = readlines("2025/day8/data_day8_test.txt")
    coords = zeros(Int64, size(lines)[1], 3)
    for i in range(1, size(lines)[1], step=1)
        coords[i,:] = parse.(Int64, split(lines[i], ","))
    end
    return coords
end

function day8_2025_p1()
    coords = read_data()
    dist = zeros(Int64, size(coords)[1], size(coords)[1])
    # the minimum distance of each box
    dist_min = zeros(Int64, size(coords)[1])
    # the element of the box with minimum distance
    dist_match = []
    # which circuit is the box part of
    junctions = []

    for i in range(1, size(coords)[1], step=1)
        cur_coord = coords[i,:]
        for j in range(1, size(coords)[1], step=1)
            next_coord = coords[j,:]
            dist[i,j] = sum((cur_coord .- next_coord).^2)
            if i >= j
                dist[i,j] = 200000000000
            end
        end
    end
    dist = Matrix(dist)
    n_ele = 10
    for i in range(1, n_ele, step=1)
        dist_argmin = argmin(dist)
        dist_min[i] = dist[dist_argmin]
        dist[dist_argmin] = 200000000000
        dist_match = push!(dist_match, (dist_argmin[1], dist_argmin[2]))
    end

    dist_match = sort(dist_match)
    # the 10 boxes with smallest distances
    for i in range(1, n_ele, step=1)
        pair_ele1 = dist_match[i][1]
        pair_ele2 = dist_match[i][2]
        junction_ele1 = findall.(x -> x==pair_ele1, junctions)
        junction_ele2 = findall.(x -> x==pair_ele2, junctions)
        # if box and target box are not in circuit, make a new circuit
        if reduce(&, isempty.(junction_ele1), init=true) && reduce(&, isempty.(junction_ele2), init=true)
            junctions = push!(junctions, [pair_ele1, pair_ele2])
        else
            # find the vector in which box is in a circuit
            for j in range(1, size(junctions)[1], step=1)
                if isempty(junction_ele1[j]) && isempty(junction_ele2[j])
                    continue
                elseif !isempty(junction_ele1[j]) && isempty(junction_ele2[j])
                    junctions[j] = push!(junctions[j], pair_ele2)
                elseif isempty(junction_ele1[j]) && !isempty(junction_ele2[j])
                    junctions[j] = push!(junctions[j], pair_ele1)
                else
                    continue
                end
            end
        end
    end
    println(junctions)


    return
end

day8_2025_p1()