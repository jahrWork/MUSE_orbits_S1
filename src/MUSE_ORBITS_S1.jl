
#Uncomment tehe following lines to install once in a life these packages 
# import Pkg 
# Pkg.add("Revise")
# Pkg.add("Plots")
# Pkg.add("OffsetArrays")
# Pkg.add("NonlinearSolve")


using Revise 

includet("./milestones_julia/Milestone2.jl")

using .Milestone2: Simulation

Simulation(tf = 4*2*pi, N = 40, U0 = [ 1., 0., 0., 1. ]  )