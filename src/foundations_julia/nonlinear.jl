
# Uncommet if these packahes are not installed 
#import Pkg 
#Pkg.add("NonlinearSolve") 
#Pkg.add("LinearAlgebra")

using NonlinearSolve
using LinearAlgebra


g(x) = x^2 - 2.
u0 = 1.0

problem = NonlinearProblem(g, u0)
solution = solve(problem)

println( "solution= ", solution.u)



f(u, p) = u .* u .- p
u0 = [1.0, 1.0]
p = 2.0
problem = NonlinearProblem(f, u0, p)
solution = solve(problem)

println( "solution= ", solution.u)

