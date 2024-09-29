using Pkg
Pkg.add("PackageCompiler")


using PackageCompiler



create_sysimage(["Plots"], sysimage_path="sys_plots.so", precompile_execution_file="hello.jl")


#create_app("./sources/foundations_julia_python/hello.jl", "hello.exe")