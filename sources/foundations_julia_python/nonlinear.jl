
import Pkg 
Pkg.add("NonlinearSolve")
using NonlinearSolve



g(x, p) = x^2 - 2.
u0 = 1.0

prob = NonlinearProblem(g, u0, p)
sol = solve(prob)

print( "sol= ", sol)



f(u, p) = u .* u .- p
u0 = [1.0, 1.0]
p = 2.0
prob = NonlinearProblem(f, u0, p)
sol = solve(prob)

print( "sol= ", sol)

