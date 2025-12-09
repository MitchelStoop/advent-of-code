using DataFrames
using CSV
using BenchmarkTools

function read_data()
    lines = readlines("2025/day9/data_day9.txt")
    coords = zeros(Int64, size(lines)[1], 2)
    for i in range(1, size(lines)[1], step=1)
        coords[i,:] = parse.(Int64, split(lines[i], ","))
    end
    return coords
end

function day9_2025()
    coords = read_data()
    dist = []
    for i in range(1, size(coords)[1], step=1)
        cur_coord = coords[i,:]
        for j in range(1, size(coords)[1], step=1)
            next_coord = coords[j,:]
            dist = push!(dist, [prod((cur_coord .- next_coord .+ 1)), i, j])
        end
    end
end

function day9_2025_p2()
    # read-in
    coords = read_data()
    
    # set-up
    dist = []
    floor_xmax = maximum(coords[:,1]) + 1
    floor_ymax = maximum(coords[:,2]) + 1
    prev_red_tile = coords[end,:]
    floor = zeros(Int64, floor_xmax, floor_ymax)

    # set red and green tiles
    for i in range(1, size(coords)[1], step=1)
        red_tile = coords[i,:]
        floor[red_tile[1], red_tile[2]] = 1
        if prev_red_tile[1] > red_tile[1]
            floor[red_tile[1]:prev_red_tile[1],prev_red_tile[2]:red_tile[2]] .= 1
        elseif prev_red_tile[2] > red_tile[2]
            floor[prev_red_tile[1]:red_tile[1],red_tile[2]:prev_red_tile[2]] .= 1
        else
            floor[prev_red_tile[1]:red_tile[1],prev_red_tile[2]:red_tile[2]] .= 1
        end
        prev_red_tile = red_tile
    end
    floor_fill = flood_polygon(floor, 1, 1)

    # println(floor_fill)
end

function flood_polygon(grid, x1, y1)
    flooding = true
    flood_indices = [(x1, y1)]
    iii = 0
    while flooding
        flooding=false
        x_cur, y_cur = popat!(flood_indices, 1)
        # check if position is 0, otherwise continue
        # check if the border is still within {3,3} box centred on position
        # push the surrounding 9 positions to flood_indices
        # accept the position and set it to 2
        if grid[x_check, y_check] != 0
            continue
        end
        if !all(isempty.(findall.(x -> x==1, grid[x_check-1:x_check+1,y_check-1:y_check+1])))

        end

        end


        grid[x_cur, y_cur] = 2
        if x_cur >= 2 && grid[x_cur-1, y_cur] == 0 && (grid[x_cur-1, y_cur] == 0)
            flood_indices = push!(flood_indices, (x_cur-1, y_cur))
            flooding=true
        end
        if x_cur <= size(grid)[1] - 1 && grid[x_cur+1, y_cur] == 0
            flood_indices = push!(flood_indices, (x_cur+1, y_cur))
            flooding=true
        end
        if y_cur >= 2 && grid[x_cur, y_cur-1] == 0
            flood_indices = push!(flood_indices, (x_cur, y_cur-1))
            flooding=true
        end
        if y_cur <= size(grid)[2] - 1 && grid[x_cur, y_cur+1] == 0
            flood_indices = push!(flood_indices, (x_cur, y_cur+1))
            flooding=true
        end
        if !isempty(flood_indices)
            flooding = true
        end
        iii+=1
        if iii%10000000 == 0
            println(iii)
        end
    end
    return grid
end

#     # loop over two red tiles
#     for i in range(1, size(coords)[1]-1, step=1)
#         red_tile1 = coords[i,:]
#         x1 = red_tile1[1]
#         y1 = red_tile1[2]
#         for j in range(i+1, size(coords)[1], step=1)
#             red_tile2 = coords[j,:]
#             x2 = red_tile2[1]
#             y2 = red_tile2[2]
#             if x2 >= x1 && y2 >= y1
#                 floor_check = floor[x1+1:x2-1,y1+1:y2-1]
#             elseif x2 >= x1 && y2 < y1
#                 floor_check = floor[x1+1:x2-1,y2+1:y1-1]
#             elseif x2 < x1 && y2 >= y1
#                 floor_check = floor[x2+1:x1-1,y1+1:y2-1]
#             elseif x2 < x1 && y2 < y1
#                 floor_check = floor[x2+1:x1-1,y2+1:y1-1]
#             end
#             contain_check = findall.(x -> x==1, floor_check)
#             rect_empty = isempty.(contain_check)
#             if all(rect_empty)
#                 dist = push!(dist, [prod((red_tile1 .- red_tile2 .+ 1)), i, j])
#             end
#             println(j)
#         end
#     end
#     println(maximum(dist))
# end

function check_box(xmin, xmax, ymin, ymax)

end

day9_2025_p2()