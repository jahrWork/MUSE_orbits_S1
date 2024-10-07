module MUSE_ORBITS_S1
#Uncomment tehe following lines to install once in a life these packages 
import Pkg 
#Pkg.add("Revise")
# Pkg.add("Plots")
# Pkg.add("OffsetArrays")
# Pkg.add("NonlinearSolve")
using Revise 

#includet("../my_library/src/my_library.jl")
#Pkg.add("my_library")
#Pkg.add("my_project")


includet("./milestones_julia/Milestone2.jl")

using ..Milestone2: Simulation

function main() 

    Simulation(tf = 4*2*pi, N = 40, U0 = [ 1., 0., 0., 1. ]  )

end 

end 

using .MUSE_ORBITS_S1: main 

main()

