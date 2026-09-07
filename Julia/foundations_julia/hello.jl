println("Hello world")

print("Enter your name : ")
                    # options to work with keyboard VS code: 
                    # 0) enter the input string twice (only first readline)
name = readline()   # 1) open Julia REPL () and type include("./path/hello.jl")
                    # 2) control j, navigate where to locate julia file, julia hello.jl

println(typeof(name))

S = string("Hello ", name)
println(S)
