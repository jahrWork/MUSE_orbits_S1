module MUSE_ORBITS_S1
#Uncomment tehe following lines to install once in a life these packages 
#import Pkg 
#Pkg.add("Revise")
# Pkg.add("Plots")
# Pkg.add("OffsetArrays")
# Pkg.add("NonlinearSolve")

# Pkg.generate("./src/Cauchy_problem")
# Pkg.generate("./src/Physics")
# Pkg.generate("./src/Temporal_schemes")

# using Pkg
# println(" current directory: ", pwd() )
# Pkg.develop(path = "./src/Cauchy_problem")
# Pkg.develop(path = "./src/Physics")
# Pkg.develop(path = "./src/Temporal_schemes")



println(" current directory: ", pwd() )
include("./milestones/Milestone2.jl")


function main() 

   # Simulation(tf = 4*2*pi, N = 40, U0 = [ 1., 0., 0., 1. ]  )
    Simulation(tf = 4*2*pi, N = 40, U0 = [ 1., 0. ]  )

end 


main()

end 


