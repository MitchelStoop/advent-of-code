# L or R is no longer needed after using symmetry
# eg. going L250 from 20 (-230) is the same as R250 from 100-20=80 (330)
# dial value needs correction after (-230 -> 70) and (330 -> 30 -> 70 correction)

function read_data()
    lines = readlines("2025/day1/data_day1.txt")
    return lines
end

function day1_2025(lines::Vector{String})
    # initial values and setup
    n_vault = 50
    n_zero = 0 # part 1
    n_zero_passing = 0 # part 2
    dir_sign = Dict([("L", -1), ("R", 1)])
    for move in lines
        length_move = parse(Int64, move[2:end])
        dir_move = string(move[1])

        # use symmetry here to change dial value
        n_vault = mod(n_vault * dir_sign[dir_move], 100)
        n_vault += length_move

        # determine number of times the dial stops exactly at 0
        n_zero += Int64(iszero(mod(n_vault, 100)))

        # number of times the dial stops at, or, passes 0
        n_zero_passing += div(n_vault, 100)

        # the dial value needs correction
        n_vault = mod(n_vault * dir_sign[dir_move], 100)
    end
    return n_zero, n_zero_passing
end

lines = read_data()

n_zero, n_zero_passing = @btime day1_2025(lines)
println("Number of times the dial stops exactly at 0: $n_zero")
println("Number of times the dial passed 0: $n_zero_passing")