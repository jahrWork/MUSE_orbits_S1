
# To load a module or a package  named: library, 
# the statement using library can be used. 

# To load a module from a locally defined module, 
# a dot needs to be added before the module name like using .my_library
# define module A inside your current module. 
#The dot means "look inside the current module for this"

# There are two ways to deal witn your own modules: 
#   1) modules are libraries=projects
#        folder: my_library
#                     src : inside my_library.jl 
#                     Project.toml
#    
#        my _library is used from this script 
#        using my_library 
# Example:                   
   
  # import Pkg
    using Pkg
  # Pkg.develop(path = "my_library")
   using my_library

   println("1) first way to use your own modules")
   println("   current directory: ", pwd() )
   my_library.f()
   println(".............")
   Pkg.status()

#   2) modules are not projects and are stored in different folders
#      
#      Use revise to track changes in different files 
    using Pkg
    Pkg.add("Revise")
    using Revise 

# Example:  
#        inside folder moduleA there are two file: m1.jl and m2.jl 
#        module m1 uses m2
#        m1 is used from this script 

#        path = joinpath(@__DIR__, "./moduleA/")
#        push!(LOAD_PATH, path)
#        using m1

         includet("./moduleA/m1.jl")

         import ..m1  
         using ..m1: f

         println("2) second way to use your own module")
         x = 2 
         println("Hello from main program") 
         m1.f()
         println("x = ", x)
         println(".............")

    
     
    



