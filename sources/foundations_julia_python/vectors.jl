import Pkg 
Pkg.add("Plots")
Pkg.add("OffsetArrays")

using Plots
using OffsetArrays: Origin

function F(U,t) 
    
   x, xd = U[1], U[2]

   return  [  xd, -x ]
end 

N = 200

U =  zeros(N+1, 2)  
println( typeof(U) )

t = zeros(N+1)  
t = Vector( range(0., 4*pi, N+1) )
t = Origin(0)(t)
U = Origin(0, 1)(U) 
println(t[0])

U[0, :] = [1, 0] 
dt = (4*pi)/N 

for n in 0:N-1
   U[n+1, :] = U[n,:]  + dt * F( U[n, :], t[n] )
end

plot( U[:, 1], U[:, 2], aspect_ratio=:equal  )

