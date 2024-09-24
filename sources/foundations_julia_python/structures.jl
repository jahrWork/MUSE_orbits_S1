using Base


struct wheel
    R:: Int64
    O:: Int64
end

s = wheel(3, 4)
println(s)


#  with keyword arguments and optional members
@kwdef struct car2
    x::wheel = 0
    y::Float64
end

s2 = car2( x=wheel(1,1), y=5)

println(s2)
println(s2.x.R)