function f(x, y=nothing)

    if !isnothing(y) 

         return x+y

    else 
         return x 
    end
         
end 

function g(; x, y=nothing)

    if !isnothing(y) 

         return x+y

    else 
         return x 
    end
         
end 

function h(; x::Float64, y=nothing)

    if !isnothing(y) 

         return x+y

    else 
         return x 
    end
         
end 


println("f(x,y) = ", f(2,2))
println("f(x,y) = ", f(2))

println("g(x,y) = ", g(x=2))
println("g(x,y) = ", g(x=2, y=3))

println("h(x,y) = ", h( x = 2.0 ) )
println("h(x,y) = ", h( x = 2.0, y = 3 ) )