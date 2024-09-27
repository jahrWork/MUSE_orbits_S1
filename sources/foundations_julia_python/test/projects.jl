

using Pkg

# To creae a new project, uncomment the following line 
# If it is already create, comment to aovid error
#Pkg.generate("new_project")
Pkg.generate(joinpath(@__DIR__, "new_project")) # current directory of this file 
# The environment of your project is described by the 
# Project.toml in the project directory


# activate a specific project
#Pkg.activate("new_environment2")
# environment is also selected in VS code Julia env

# Compile different packages in the actual environment 

# Pkg.add("OffsetArrays")

# add documentation to the project 
# Pkg.add("Documenter")
# Pkg.add("DocumenterTools")
# using DocumenterTools
# DocumenterTools.generate(name = "new_project")

# check what environment and packages are installed 
# environment is selected in VS code Julia env
# Pkg.status()
# println("Press enter")
# S = readline() # does not work 

# using OffsetArrays: Origin

# U = [1, 2, 3 ,4, 5]
# U = Origin(0)(U)


# println( "U[0]= ", U[0], " U[4] =", U[4] )

# # If NonlinearSolve is not installed in the environment,
# # uncomment the following line.
# #Pkg.add("NonlinearSolve") 

# # Next time, comment again 

# using NonlinearSolve

# function g(x, p) 
#     return x^2 - 2.
# end    
# u0 = 1.0

# Problem = NonlinearProblem(g, u0)
# @time solution = solve(Problem)
# x = solution.u
# println( "x= ", x)


# N = 4000
# A = rand(N, N)
# b = rand(N)
# p = LinearProblem(A, b)

# linsolve = init(p)
# s = @time solve(linsolve)
# x = s.u 
# println( " x =", x[1])

