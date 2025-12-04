using BenchmarkTools

function read_data()
    lines = map(collect, readlines("2025/day4/data_day4.txt"))
    grid = permutedims(hcat(lines...))
    grid = replace(grid, '@' => 1)
    grid = replace(grid, '.' => 0)
    return grid
end

function day4_2025()
    data = read_data()

    # gridsize
    size_x = size(data)[1]
    size_y = size(data)[2]

    # setup
    n_iter = 0
    n_remove = 0
    n_remove_iter1 = 0
    n_remove_total = 0
    removing = true
    while removing
        n_iter += 1

        # matrix with extra row/column surrounding grid
        n_adj = zeros(Int64, size_x+2, size_y+2)
        for i in range(-1, 1, step=1)
            for j in range(-1, 1, step=1)
                # rolls should not be added to themselves
                if i == 0 && j == 0
                    continue
                end
                n_adj[2+i : end-1+i, 2+j : end-1+j] += data
            end
        end
        n_data = n_adj[2 : end-1, 2 : end-1]
        n_remove = length(n_data[n_data .< 4 .&& data .== 1])
        n_remove_total += n_remove
        data[n_data .< 4] .= 0
        if n_remove == 0
            removing = false
        end
        if n_iter == 1
            n_remove_iter1 = n_remove
        end
    end
    return n_remove_iter1, n_remove_total
end
function day4_2025_v2()
    data = read_data()

    # gridsize
    size_x = size(data)[1]
    size_y = size(data)[2]

    # setup
    n_remove_total = 0
    n_iter = 0

    removing = true
    while removing
        # at start we have not removed roll yet
        removing = false
        n_iter += 1
        
        # iterate over every roll
        for i in range(1, size_x, step=1)
            for j in range(1, size_y, step=1)
                n_adj_rolls = 0
                if data[i,j] == 0
                    continue
                end
                if i - 1 >= 1 && data[i-1,j] == 1
                    n_adj_rolls += 1
                end
                if j - 1 >= 1 && data[i,j-1] == 1
                    n_adj_rolls += 1
                end
                if i + 1 <= size_x && data[i+1,j] == 1
                    n_adj_rolls += 1
                end
                if j + 1 <= size_y && data[i,j+1] == 1
                    n_adj_rolls += 1
                end
                if i - 1 >= 1 && j - 1 >= 1 && data[i-1,j-1] == 1
                    n_adj_rolls += 1
                end
                if i + 1 <= size_x && j - 1 >= 1 && data[i+1,j-1] == 1
                    n_adj_rolls += 1
                end
                if i - 1 >= 1 && j + 1 <= size_y && data[i-1,j+1] == 1
                    n_adj_rolls += 1
                end
                if i + 1 <= size_x && j + 1 <= size_y && data[i+1,j+1] == 1
                    n_adj_rolls += 1
                end
                if n_adj_rolls < 4
                    removing = true
                    n_remove_total += 1
                    data[i,j] = 0
                end
            end
        end
        if n_iter == 1
            n_iter1 = n_remove_total
        end
    end
    return n_iter1, n_remove_total
end

n_iter1, n_total = @btime day4_2025()

println("$n_iter1 rolls of paper can be accessed by a forklift.")
println("$n_total total rolls of paper can be removed by the Elves and their forklifts.")

n_iter1, n_total = @btime day4_2025_v2()

println("$n_iter1 rolls of paper can be accessed by a forklift.")
println("$n_total total rolls of paper can be removed by the Elves and their forklifts.")