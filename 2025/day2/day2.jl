using DataFrames
using CSV
using BenchmarkTools

function day2_calc()
    invalid_ids_p1, invalid_ids_p2, data = 0, 0, Matrix(CSV.read("2025/day2/data_day2.txt", DataFrame, delim=',', comment="#", header=false))
    for sub_data in data
        sub_split = split(sub_data,['-'])
        for n_int in range(parse(Int64, sub_split[1]), parse(Int64, sub_split[2]), step=1)
            if iseven(ndigits(n_int)) && string(n_int)[1:Int64(length(string(n_int))/2)]^2 == string(n_int)
                invalid_ids_p1 += n_int
            end
            for n_int_i in range(1, Int64(floor(length(string(n_int))/2)), step=1)
                if string(n_int)[1:n_int_i]^Int64(div(length(string(n_int)),length(string(n_int)[1:n_int_i]))) == string(n_int)
                    invalid_ids_p2 += n_int
                    break
                end
            end
        end
    end
    return invalid_ids_p1, invalid_ids_p2
end

invalid_ids_p1, invalid_ids_p2 = @btime day2_calc()
println("Part 1: The sum of all invalid IDs is equal to $invalid_ids_p1")
println("Part 2: The sum of the invalid IDs with these new rules is equal to $invalid_ids_p2")

# function day2_calc_alt()
#     invalid_ids_p1, invalid_ids_p2, data = 0, 0, Matrix(CSV.read("2025/day2/data_day2.txt", DataFrame, delim=',', comment="#", header=false))
#     all_ints = []
#     for sub_data in data
#         sub_split = split(sub_data,['-'])
#         for n_int in range(parse(Int64, sub_split[1]), parse(Int64, sub_split[2]), step=1)
#             push!(all_ints, n_int)
#         end
#     end
#     for try_int in range(1, 9, step=1)
#         for try_string in range(1, 10, step=1)
#             if parse(Int64, string(try_int)^try_string) in all_ints
#                 invalid_ids_p2 += parse(Int64, string(try_int)^try_string)
#                 if try_string == 2
#                     invalid_ids_p1 += parse(Int64, string(try_int)^try_string)
#                 end
#             end
#         end
#     end

#     for try_int in range(10, 99, step=1)
#         for try_string in range(1, 5, step=1)
#             if parse(Int64, string(try_int)^try_string) in all_ints
#                 invalid_ids_p2 += parse(Int64, string(try_int)^try_string)
#                 if try_string == 2
#                     invalid_ids_p1 += parse(Int64, string(try_int)^try_string)
#                 end
#             end
#         end
#     end
#     # println(all_ints)
#     return invalid_ids_p1, invalid_ids_p2
# end

# invalid_ids_p1, invalid_ids_p2 = @btime day2_calc_alt()
# println("Part 1: The sum of all invalid IDs is equal to $invalid_ids_p1")
# println("Part 2: The sum of the invalid IDs with these new rules is equal to $invalid_ids_p2")