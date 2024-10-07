module m1

 x = 111
 
 using Revise 
 includet("./m2.jl")
 using ...m2

 function f()
   

    println("Hello from module m1 inside of folder moduleA") 
    println("x = ", 7*x)
    m2.f()
 end 

end 