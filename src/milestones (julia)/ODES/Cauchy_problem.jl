
module Cauchy_problem

using OffsetArrays: Origin

function Cauchy_problem_solution( ; F, t, U0, Temporal_scheme, order=nothing, Tolerance=nothing ) 
     #=
    Inputs:  
           F(U,t) : Function dU/dt = F(U,t) 
           t : time partition t (vector of length N+1)
           U0 : initial condition at t=0
           Temporal_schem 
           q : order of the scheme (optional) 
           Tolerance: Error tolerance (optional)

    Return: 
           U: matrix[0:N, 1:Nv], Nv state values at N+1 time steps     
     =#

     N =  size(t)[1]-1
     Nv = size(U0)[1]
     U = zeros(N+1, Nv)
     U = Origin(0, 1)(U) 

     U[0,:] = U0

     for n in 0:N-1

        if  !isnothing(order) 
          U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n], F, order, Tolerance ) 

        else
          U[n+1,:] = Temporal_scheme( U[n, :], t[n+1] - t[n], t[n], F ) 

        end

     end

     return U


end 


       
end 

