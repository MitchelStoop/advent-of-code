using DataFrames
using CSV
using BenchmarkTools

function read_data()
    lines = readlines("2025/day2/data_day2.txt")
    lines = [String(x) for x in eachsplit(lines[1], ",")]
    return lines
end

function day2_2025(lines::Vector{String})
    # initial values
    invalid_ids_p1 = 0
    invalid_ids_p2 = 0

    for line in lines
        # start and end value of range
        sub_line = split(line,['-'])
        start_int = parse(Int64, sub_line[1])
        finish_int = parse(Int64, sub_line[2])
        for n_int in range(start_int, finish_int, step=1)
            # part 1: check doubling first half of integer 
            string_int = string(n_int)
            length_int = length(string_int)
            length_half = div(length_int, 2)
            first_half = string_int[1:length_half]
            both_half = first_half^2
            if both_half == string_int
                invalid_ids_p1 += n_int
            end

            # loop over number of digits in integer
            for n_int_i in range(1, length_half, step=1)
                # first digits
                string_int_start = string_int[1:n_int_i]
                # amount of copies needed to make full number
                n_copies = Int64(div(length_int,length(string_int_start)))
                # make number using copies
                try_int = string_int_start ^ n_copies
                if try_int == string_int
                    invalid_ids_p2 += n_int
                    break
                end
            end
        end
    end
    return invalid_ids_p1, invalid_ids_p2
end

lines = read_data()

invalid_ids_p1, invalid_ids_p2 = @btime day2_2025(lines)
println("Part 1: The sum of all invalid IDs is equal to $invalid_ids_p1")
println("Part 2: The sum of the invalid IDs with these new rules is equal to $invalid_ids_p2")