using DataFrames
using CSV

function read_in_data()
    data = Matrix(CSV.read("2024/1/data_1.txt", DataFrame, delim=',', comment="#", header=false))
    return data
end

function distance_calc()
    data = read_in_data()
    col1 = data[:,1]
    col2 = data[:,2]
    col1_sort = sort(col1)
    col2_sort = sort(col2)
    col_dist = abs.(col1_sort - col2_sort)
    sum_dist = sum(col_dist)
    println(sum_dist)
end

function similarity_calc()
    data = read_in_data()
    col1 = data[:,1]
    col2 = data[:,2]

    sim_total = 0
    for i in unique(col1)
        len_i_in_col1 = length(col1[col1 .== i])
        len_i_in_col2 = length(col2[col2 .== i])
        sim_total += i * len_i_in_col1 * len_i_in_col2
    end
    println(sim_total)
end

distance_calc()
similarity_calc()