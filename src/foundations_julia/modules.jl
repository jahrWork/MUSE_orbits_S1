module modules
# To load a module from a package, the statement using ModuleName can be used. 
# To load a module from a locally defined module, 
# a dot needs to be added before the module name like using .ModuleName
# 
# define module A inside your current module. 
#The dot means "look inside the current module for this"

# Use revise to track changes in different files 
using Pkg
Pkg.add("Revise")
using Revise 

Pkg.add("my_library")
using my_library


includet("./moduleA/m1.jl")

import ..m1  
using ..m1: f

function main()

     x = 2 
     println("Hello from main program")

     m1.f()
      f()
     println("x = ", x)

     my_library.f()


end 


end 

# path = joinpath(@__DIR__, "./moduleA/")
# push!(LOAD_PATH, path)

# using m1

using .modules
modules.main()





#= 
module main 
     using Revise
     includet("m2.jl")  # revise only tracks change  of functions 
end  =#

# using .main: m2


# m2.f()
