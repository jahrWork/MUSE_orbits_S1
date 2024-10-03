# If the environment has compiled Plots, 
# the following line can be commented 
#import Pkg 
#Pkg.add("Plots") 

using Plots

println("Hello world")

function plot_example()

  t =  Vector( range(0, 1, 100) )

  for i in 1:3
    
    y = sin.( 2  * i * pi * t )
    display( plot!(t, y) )
  end 

end 

@time plot_example()

