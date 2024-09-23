import Pkg 
Pkg.add("Plots")

using Plots

println("Hello world")

t =  Vector( range(0, 1, 100) )


for i in range(1,3)
    
  y = sin.( 2  * i * pi * t )
  display( plot!(t, y) )
end 
