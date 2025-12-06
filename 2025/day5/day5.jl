using DataFrames
using CSV
using BenchmarkTools

function read_data()
    lines = readlines("2025/day5/data_day5.txt")
    # lines = [String(x) for x in eachsplit(lines[1], ",")]
    ranges = lines[1:190]
    tests = lines[192:end]
    return ranges, tests
end

function day5_2025()
    ranges, tests = read_data()
    valid_set = Set()

    for line in ranges
        # start and end value of range
        sub_line = split(line,['-'])
        start_int = parse(Int64, sub_line[1])
        finish_int = parse(Int64, sub_line[2])
        for test in tests
            test = parse(Int64, test)
            if test >= start_int && test <= finish_int
                valid_set = push!(valid_set, test)
            end
        end
    end
    return
end

function two_range_overlap(range1, range2)
    start1, finish1 = range1[1], range1[2]
    start2, finish2 = range2[1], range2[2]
    if start1 < start2 && finish1 < start2
        return range1, range2
    elseif start1 > finish2 && finish1 > finish2
        return range1, range2
    elseif start1 >= start2 && finish1 <= finish2
        return [nothing, nothing], range2
    elseif start1 < start2 && finish1 > finish2
        return range1, [nothing, nothing]
    elseif start1 <= start2 && finish1 >= start2 && finish1 <= finish2
        return [start1, finish2], [nothing, nothing]
    elseif start1 >= start2 && start1 <= finish2 && finish1 >= finish2
        return [start2, finish1], [nothing, nothing]
    else
        error("something went wrong!")
    end
end

function day5_2025_p2()
    ranges, tests = read_data()

    range_unique = []

    starts = []
    finishes = []

    for line in ranges
        # start and end value of range
        sub_line = split(line,['-'])
        start_int = parse(Int64, sub_line[1])
        finish_int = parse(Int64, sub_line[2])
        starts = push!(starts, start_int)
        finishes = push!(finishes, finish_int)
    end
    ranges = [starts, finishes]
    ranges = hcat(ranges...)
    ranges = sort(ranges, dims=1)
    for i in range(1, size(ranges)[1], step=1)
        start = ranges[i,1]
        finish = ranges[i,2]
        unique = true
        # first range is always unique
        if i == 1
            range_unique = push!(range_unique, [start, finish])
            continue
        end

        for j in range(1, size(range_unique)[1], step=1)
            range1, range2 = two_range_overlap([start, finish], range_unique[j])
            # completely non-unique range
            if nothing in range1
                unique = false
                continue
            # partially unique range
            elseif nothing in range2
                range_unique[j] = range1
                unique = false
                continue
            end
        end
        # completely unique range
        if unique
            range_unique = push!(range_unique, [start, finish])
        end
        range_unique = sort(range_unique)
    end

    my_total = 0
    for i in range(1, size(range_unique)[1], step=1)
        start = range_unique[i][1]
        finish = range_unique[i][2]
        my_total += finish - start + 1
    end
    return
end

day5_2025()
@btime day5_2025_p2()

# lines = read_data()

# invalid_ids_p1, invalid_ids_p2 = @btime day2_2025(lines)
# println("Part 1: The sum of all invalid IDs is equal to $invalid_ids_p1")
# println("Part 2: The sum of the invalid IDs with these new rules is equal to $invalid_ids_p2")