using DataFrames
using CSV

function my_func()
    data, n_vault, n_zero, n_zero_passing, dir_sign = Matrix(CSV.read("2025/day1/data_day1.txt", DataFrame, delim=',', comment="#", header=false)), 50, 0, 0, Dict([("L", -1), ("R", 1)])
    for move in data
        n_vault = mod(n_vault * dir_sign[string(move[1])], 100) + parse(Int64, move[2:end])
        n_zero, n_zero_passing, n_vault = n_zero + Int64(iszero(mod(n_vault, 100))), n_zero_passing + div(n_vault, 100), mod(n_vault * dir_sign[string(move[1])], 100)
    end
    println("Number of times the dial is exactly 0: $n_zero\nNumber of times the dial passed 0: $n_zero_passing")
end

my_func()

function read_in_data()
    data = Matrix(CSV.read("2025/day1/data_day1.txt", DataFrame, delim=',', comment="#", header=false))
    return data
end

function vault1_calc()
    data = read_in_data()
    # data = data[1:100]
    n_zero = 0
    vault_int = 50

    for move in data
        previous_vault_int = vault_int

        if direction == "R"
            vault_int += length
        elseif  direction == "L"
            vault_int -= length
        else
            println("something went wrong!")
        end
        if vault_int >= 100
            vault_int = vault_int % 100
        elseif vault_int < 0
            vault_int = (100 + (vault_int%100)) % 100
        end

        if vault_int == 0
            n_zero += 1
        end
    end
    println("The number 0 occured $n_zero amount of times")
end

function vault2_calc()
    data = read_in_data()
    # data = data[1:100]
    n_zero = 0
    vault_int = 50

    for move in data
        previous_vault_int = vault_int
        direction = string(move[1])
        length = parse(Int64, move[2:end])
        if direction == "R"
            vault_int += length
        elseif  direction == "L"
            vault_int -= length
        else
            println("something went wrong!")
        end
        println(previous_vault_int, "   ", vault_int)
        if vault_int >= 100
            n_zero += floor(Int64, vault_int / 100)
            vault_int = vault_int % 100
        elseif vault_int == 0
            n_zero += 1
        elseif vault_int < 0
            n_zero += abs(floor(Int64, (vault_int - 1) / 100))
            if previous_vault_int == 0
                n_zero -= 1
            end
            vault_int = (100 + (vault_int%100)) % 100
        end
         println(n_zero)
    end
    println("The number 0 has been passed $n_zero amount of times")
end

# vault1_calc()
# vault2_calc()