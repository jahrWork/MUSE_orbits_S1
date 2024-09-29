module new_project

#Base.LOAD_PATH = ["@",  "@stdlib"]

using Pkg 


#Pkg.activate(joinpath(@__DIR__, "../"))
#Pkg.add("LinearAlgebra")
Pkg.add("Plots")

using Plots

Pkg.status()

function greet()
     print("Hello World!")
     plot(1:5, 1:5)
end 

end 

new_project.greet()
