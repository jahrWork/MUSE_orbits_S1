
#Uncomment tehe following lines to install once in a life these packages 
# import Pkg 
# Pkg.add("Revise")
# Pkg.add("Plots")
# Pkg.add("OffsetArrays")
# Pkg.add("NonlinearSolve")

using Plots
using Revise 
using OffsetArrays: Origin

includet("./ODES/Cauchy_problem.jl")
includet("./ODES/Temporal_schemes.jl")
includet("./Physics/Orbits.jl")

using .Cauchy_problem: Cauchy_problem_solution
using .Temporal_schemes: Euler, RK4, Inverse_Euler, Crank_Nicolson, Embedded_RK 
using .Orbits: Kepler 

    
#     This is a Simulation code to integrate Cauchy problems with some numerical scheme.
#
#     The objective of this Milestone is to create different functions or abstractions 
#     by means of functional programming or function composition. 
#     Namely, the following modules are created to allow this functional composition:
#             1) ODES.Cauhy_problem
#             2) ODES.Temporal_schemes
#             3) Physics.Orbits
#    
#     The idea is to create a Cauchy problem abstraction to integrate different physical 
#     problems with different temporal schemes.
#    
#     Different abstractions : 
#                      1) dU/dt = F(U, t) 
#                      2) Temporal scheme to integrate one step 
#                      3) Cauchy problem to perform different steps 
#
function Simulation( ; tf :: Float64, N :: Integer, U0 :: Vector) 
                   # ; it separates positional from keyword arguments

    time = range(0., tf, N+1) 
    time = Origin(0)(time)
    
    schemes = [  (Euler, nothing, nothing), 
                 (RK4, nothing, nothing), 
                 (Inverse_Euler, nothing, nothing), # it takes much more time than CranK_Nicolson 
                                                    # The reason is associated to convergence of nonlinear problem
                                                    # The initial condition of CN is better than the IC of Euler
                 (Crank_Nicolson, nothing, nothing),
                 (Embedded_RK, 2, 1e-1), 
                 (Embedded_RK, 8, 1e-1) ]

    for (method, order, eps)  in schemes
       
        U =  @time Cauchy_problem_solution( F = Kepler, t = time, U0 = U0, Temporal_scheme = method, order = order, Tolerance = eps ) 
      
        display( plot( U[:, 1], U[:, 2], aspect_ratio=:equal  ) )
        display( scatter( U[:, 1], U[:, 2], aspect_ratio=:equal )  )

    end

end 

Simulation(tf = 7., N = 30, U0 = [ 1., 0., 0., 1. ]  )