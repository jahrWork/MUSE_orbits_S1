
import Pkg 
Pkg.add("Revise")
Pkg.add("Plots")
Pkg.add("OffsetArrays")

using Plots
using Revise 
using OffsetArrays: Origin

includet("./ODES/Cauchy_problem.jl")
includet("./ODES/Temporal_schemes.jl")
includet("./Physics/Orbits.jl")

using .Cauchy_problem: Cauchy_problem_solution
#using .Temporal_schemes: Euler, Inverse_Euler, Crank_Nicolson, Embedded_RK 
using .Temporal_schemes: Euler, RK4
using .Orbits: Kepler 



function Simulation( ; tf :: Float64, N :: Integer, U0 :: Vector) 
                   # ; it separates positional from keyword arguments
   
#     #= 
#     This is a Simulation code to integrate Cauchy problems with some numerical scheme.

#     The objective of this Milestone is to create different functions or abstractions 
#     by means of functional programming or function composition. 
#     Namely, the following modules are created to allow this functional composition:
#             1) ODES.Cauhy_problem
#             2) ODES.Temporal_schemes
#             3) Physics.Orbits
    
#     The idea is to create a Cauchy problem abstraction to integrate different physical 
#     problems with different temporal schemes.
    
#     Different abstractions : 
#                      1) dU/dt = F(U, t) 
#                      2) Temporal scheme to integrate one step 
#                      3) Cauchy problem to perform different steps 
 

    time = range(0., tf, N+1) 
    time = Origin(0)(time)
    # schemes = [  (Euler, None, None ),  (Embedded_RK, 2, 1e-1), (Embedded_RK, 8, 1e-1)  ]
    schemes = [  (Euler, nothing, nothing), (RK4, nothing, nothing) ]

      for (method, order, eps)  in schemes
       
        U =  Cauchy_problem_solution( F = Kepler, t = time, U0 = U0, Temporal_scheme = method, order = order, Tolerance = eps ) 
      
        display( plot!( U[:, 1], U[:, 2], aspect_ratio=:equal  ) )
        display( scatter!( U[:, 1], U[:, 2] ) )

      end

end 

Simulation(tf = 10., N = 1000, U0 = [ 1., 0., 0., 1. ]  )