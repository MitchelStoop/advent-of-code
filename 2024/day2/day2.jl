using DataFrames
using CSV

function safe_calc()
    lines, safe_reports_p1, safe_reports_p2 = readlines("2024/day2/data_day2.txt"), 0, 0
    for line in lines
        line = [parse(Int64, str_int) for str_int in split(line, ",")]
        println(line)
        if maximum(abs.(diff(line))) <= 3 && (all(>(0), diff(line)) || all(<(0), diff(line)))
            safe_reports_p1, safe_reports_p2 = safe_reports_p1 + 1, safe_reports_p2 + 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),1+argmax((abs.(diff(line)))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),1+argmax((abs.(diff(line))))))) || all(<(0), diff(deleteat!(copy(line),1+argmax((abs.(diff(line))))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),argmax((abs.(diff(line)))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),argmax((abs.(diff(line))))))) || all(<(0), diff(deleteat!(copy(line),argmax((abs.(diff(line))))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),1+argmin((abs.(diff(line)))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),1+argmin((abs.(diff(line))))))) || all(<(0), diff(deleteat!(copy(line),1+argmin((abs.(diff(line))))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),argmin((abs.(diff(line)))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),argmin((abs.(diff(line))))))) || all(<(0), diff(deleteat!(copy(line),argmin((abs.(diff(line))))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),argmin((diff(line))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),argmin((diff(line)))))) || all(<(0), diff(deleteat!(copy(line),argmin((diff(line)))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),1+argmin((diff(line))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),1+argmin((diff(line)))))) || all(<(0), diff(deleteat!(copy(line),1+argmin((diff(line)))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),argmax((diff(line))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),argmax((diff(line)))))) || all(<(0), diff(deleteat!(copy(line),argmax((diff(line)))))))
            safe_reports_p2 += 1
            continue
        elseif maximum(abs.(diff(deleteat!(copy(line),1+argmax((diff(line))))))) <= 3 && (all(>(0), diff(deleteat!(copy(line),1+argmax((diff(line)))))) || all(<(0), diff(deleteat!(copy(line),1+argmax((diff(line)))))))
            safe_reports_p2 += 1
            continue
        end
    end
    return safe_reports_p1, safe_reports_p2
end

safe_reports_p1, safe_reports_p2 = safe_calc()
println("The number of safe reports is: $safe_reports_p1")
println("The number of safe reports, tolerating a single bad level, is: $safe_reports_p2")