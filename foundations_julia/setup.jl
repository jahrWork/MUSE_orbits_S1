using Pkg

# author : Pedro Rodriguez Jimenez dic 2024
# Ruta al Project.toml donde están las dependencias
project_path = pwd()

println("Activating the project environment...")
Pkg.activate(project_path)

println(" ")

println("Checking for inconsistencies in the project...")
# Intenta resolver y reparar cualquier inconsistencia
try
    Pkg.resolve()
    println("Inconsistencies resolved.")
catch e
    println("Error while resolving dependencies: ", e)
    println("Trying to fix dependencies...")
    try
        Pkg.instantiate()
        println("Dependencies fixed.")
    catch e_inner
        println("Error while fixing dependencies: ", e_inner)
        println("Consider manually inspecting Project.toml and Manifest.toml.")
        return
    end
end

println(" ")

println("Installing the packages according to [deps]...")
try
    Pkg.instantiate()
    println("Packages installed successfully.")
catch e
    println("Error while installing packages: ", e)
    println("Ensure that Project.toml is correctly configured.")
    return
end

println(" ")

println("Updating the packages according to [compat]...")
try
    Pkg.resolve()
    println("Packages updated successfully.")
catch e
    println("Error while updating packages: ", e)
end

println(" ")

println("Versions of the packages installed:")
Pkg.status()

println(" ")

println("Project environment ready.")
