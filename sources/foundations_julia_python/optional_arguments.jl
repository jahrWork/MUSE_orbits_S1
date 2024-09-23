function f(x, y=nothing)

    if !isnothing(y) 

         return x+y

    else 
         return x 
    end
         
end 

println("f(x,y) = ", f(2,2))
println("f(x,y) = ", f(2))