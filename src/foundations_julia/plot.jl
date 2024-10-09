# If the environment has compiled Plots, 
# the following line can be commented 
#import Pkg 
#Pkg.add("Plots") 

using Plots

function plot_example()

  N = 100
  t =  Vector( range(0, 1, N) )
  y = zeros(N, 3)

  for i in 1:3
        y[:,i] = sin.( 2  * i * pi * t )
  end     
  
  plot(t, y, 
       title = "Trigonometric f of different frequency \$ y(t) = \\sin(2  \\pi  f  t) \$", 
       xlabel = "\$ t \$", ylabel = "\$ y \$", 
       label = ["f=1" "f=2" "f=3"], lw = 3,
       xlimits=(0,1), ylimits=(-2,2)
      )
  

end 

@time plot_example()

