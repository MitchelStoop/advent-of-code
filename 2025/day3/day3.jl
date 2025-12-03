using BenchmarkTools

function read_data()
    lines = readlines("2025/day3/data_day3.txt")
    return lines
end

function day3_2025(n_battery::Int64, lines::Vector{String})
    # initial values
    joltage_batt_n = 0

    for line in lines
        # collect individual characters
        int_arr = collect(line)

        # empty setup
        batt_idx_max = 0
        batt_n = ""

        for i_batt in range(n_battery-1, 0, step=-1)
            batt_idx_max += argmax(int_arr[batt_idx_max + 1 : end - i_batt])
            batt_n *= int_arr[batt_idx_max]
        end
        joltage_batt_n += parse(Int64, batt_n)
    end
    return joltage_batt_n
end

lines = read_data()

joltage_2 = @btime day3_2025(2, lines)
joltage_12 = @btime day3_2025(12, lines)
println("Maximum joltage using 2 batteries: $joltage_2")
println("Maximum joltage using 12 batteries: $joltage_12")