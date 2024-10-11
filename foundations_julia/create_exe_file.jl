using Pkg
Pkg.add("PackageCompiler")


using PackageCompiler

#create_sysimage(["Plots"], sysimage_path="sys_plots.so", precompile_execution_file="src/hello.jl")
#create_sysimage(["Plots"], sysimage_path="sys_plots.so", precompile_execution_file="src/foundations_julia/hello.jl")


# Uncomment to create a new project 
# it creates a folder my_project with src folder and toml file 
#Pkg.generate(joinpath(@__DIR__, "my_project")) # current directory of this file 
#path = joinpath(@__DIR__, "../../")
#path = joinpath(@__DIR__, "../")
#Pkg.generate(joinpath(path, "my_project"))  # 

# It does not work VS code. Change manually 
# Pkg.activate() 


# it looks for "my_project" folder from root folder of VS code 
# it creates a new folder "my_project_bin"

create_app("my_project", "my_project_bin", force=true) 
